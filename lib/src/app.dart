// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/resources/app_config.dart';
import 'package:genius_radio/resources/colors.dart';
import 'package:genius_radio/resources/constants.dart';
import 'package:genius_radio/src/cookie_manager.dart';
import 'package:genius_radio/src/dialogs/credits_dialog.dart';
import 'package:genius_radio/src/widgets/controls.dart';
import 'package:genius_radio/src/widgets/playlist.dart';
import 'package:genius_radio/src/widgets/responsive_text.dart';
import 'package:genius_radio/src/widgets/song_info.dart';
import 'package:genius_radio/src/stores/player_store.dart';
import 'package:provider/provider.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:clipboard/clipboard.dart';

void mainCommon({@required String host}) {
  WidgetsFlutterBinding.ensureInitialized();
  var configuredApp = App(host);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(configuredApp),
  );
}

class App extends StatelessWidget {
  final String host;

  App(this.host);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PlayerStore>(
          create: (_) => PlayerStore(),
        )
      ],
      child: AppConfig(
        host,
        child: MaterialApp(
          title: 'GeniusRadio',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'GeniusRadio'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  PlayerStore _store;

  // ignore: close_sinks
  YoutubePlayerController _controller;
  FToast fToast;
  bool showApp = true;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _store = context.read();
    _store.loadPlaylist(Constants.playlist);
    if (CookieManager.getCookie("index") != null) {
      _store.selectSong(int.parse(CookieManager.getCookie("index")));
    }
    _controller = YoutubePlayerController(
      initialVideoId: CookieManager.getCookie("index") != null
          ? Constants.playlist[int.parse(CookieManager.getCookie("index"))]
          : Constants.playlist[0],
      params: YoutubePlayerParams(
          playlist: Constants.playlist,
          showControls: false,
          showFullscreenButton: false,
          autoPlay: true,
          playsInline: true),
    );
    _controller.listen((value) {
      if (value.metaData.videoId !=
          _store.playlist[_store.playlistIndex].videoId) {
        int index = _store.playlist
            .indexWhere((element) => element.videoId == value.metaData.videoId);
        if (index > -1) {
          _store.selectSong(index);
        }
      }
      if (!(value.playerState == PlayerState.unStarted)) {
        CookieManager.addToCookie("index", _store.playlistIndex.toString());
      }
      _store.setValues(value);
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showApp = false;
      });
    });
  }

  void showCredits() {
    showDialog(context: context, builder: (_) => CreditsDialog());
  }

  void showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: CustomColors.darkBlue,
      ),
      child: Text(
        "🚀 Copied the url in your clipboard! Share it everywhere you want!",
        style: GoogleFonts.montserrat(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  void share() {
    FlutterClipboard.copy(window.location.href).then((value) => showToast());
  }

  Widget _buildDesktop() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: NeumorphicButton(
                      padding: EdgeInsets.all(4),
                      style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle()),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/avatars/devgenius.png"),
                      ),
                      onPressed: () => showCredits()),
                ),
              ),
              Spacer(),
              Container(
                height: 80,
                width: 80,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: NeumorphicButton(
                      style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle()),
                      child: Icon(
                        Icons.share_outlined,
                        color: CustomColors.darkBlue,
                      ),
                      onPressed: () => share()),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 7,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(65)),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SongInfo(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 400),
                                        child: Controls()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            flex: 6,
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 50, 50, 50),
                                child: Playlist()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        Spacer()
      ],
    );
  }

  Widget _buildMobile() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: NeumorphicButton(
                      padding: EdgeInsets.all(4),
                      style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle()),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/avatars/devgenius.png"),
                      ),
                      onPressed: () => showCredits()),
                ),
              ),
              Spacer(),
              ResponsiveText(
                text: "🚀 Genius Radio",
                mediumStyle: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.darkBlue,
                ),
                bigStyle: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.darkBlue,
                ),
                align: TextAlign.center,
              ),
              Spacer(),
              Container(
                height: 60,
                width: 60,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: NeumorphicButton(
                      style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle()),
                      child: Icon(
                        Icons.share_outlined,
                        color: CustomColors.darkBlue,
                      ),
                      onPressed: () => share()),
                ),
              ),
            ],
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SongInfo(),
              SizedBox(
                height: 35,
              ),
              Container(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Controls()),
            ],
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _player = YoutubePlayerIFrame(
      key: GlobalKey(),
    );
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        baseColor: Color.fromRGBO(248, 247, 247, 1),
        shadowLightColor: Colors.white,
        shadowDarkColor: Colors.grey[400],
        accentColor: Colors.cyan,
        depth: 10,
        intensity: 2,
      ),
      child: Observer(
        builder: (_) => !_store.isLoadingPlaylist && !showApp
            ? YoutubePlayerControllerProvider(
                controller: _controller,
                child: Stack(
                  children: [
                    SizedBox(height: 0, width: 0, child: _player),
                    Scaffold(
                      backgroundColor: Color.fromRGBO(248, 247, 247, 1),
                      body: LayoutBuilder(
                          builder: (context, constraints) =>
                              (constraints.maxHeight / constraints.maxWidth) < 1
                                  ? _buildDesktop()
                                  : _buildMobile()),
                    ),
                  ],
                ),
              )
            : Center(child: Image.asset("assets/animation.gif")),
      ),
    );
  }
}
