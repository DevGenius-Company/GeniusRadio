import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/resources/app_config.dart';
import 'package:genius_radio/resources/constants.dart';
import 'package:genius_radio/src/widgets/controls.dart';
import 'package:genius_radio/src/widgets/playlist.dart';
import 'package:genius_radio/src/widgets/responsive_text.dart';
import 'package:genius_radio/src/widgets/song_info.dart';
import 'package:genius_radio/stores/player_store.dart';
import 'package:provider/provider.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';
import 'package:google_fonts/google_fonts.dart';

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
          home: Stack(
            children: [
              MyHomePage(title: 'GeniusRadio'),
            ],
          ),
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
  YoutubePlayerController _controller;
  PlayerStore _store;

  get http => null;

  @override
  void initState() {
    super.initState();
    _store = context.read();
    _store.loadPlaylist(Constants.playlist);

    _controller = YoutubePlayerController(
      initialVideoId: Constants.playlist[0],
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
      _store.setValues(value);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildDesktop(){
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
                          boxShape:
                          NeumorphicBoxShape.circle()),
                      child: Hero(
                          tag: 'devGenius',
                          child: CircleAvatar(
                            backgroundImage: Image.network(
                                "https://avatars.githubusercontent.com/u/80033394?s=400&u=c7ab6ed6420f6a3bfd7a06b77823e6330a4de7f4&v=4")
                                .image,
                          )),
                      onPressed: () {}),
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
                          boxShape:
                          NeumorphicBoxShape.circle()),
                      child: Icon(
                        Icons.share_outlined,
                        color: Color.fromRGBO(26, 41, 75, 1),
                      ),
                      onPressed: () {}),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(120),
            child: Neumorphic(
              style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(65)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 30,bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          SongInfo(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              constraints: BoxConstraints(
                                  maxWidth: 400),
                              child: Controls()),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      flex: 6,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              0, 50, 50, 50),
                          child: Playlist()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobile(){
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
                          boxShape:
                          NeumorphicBoxShape.circle()),
                      child: Hero(
                          tag: 'devGenius',
                          child: CircleAvatar(
                            backgroundImage: Image.network(
                                "https://avatars.githubusercontent.com/u/80033394?s=400&u=c7ab6ed6420f6a3bfd7a06b77823e6330a4de7f4&v=4")
                                .image,
                          )),
                      onPressed: () {}),
                ),
              ),
              Spacer(),
              ResponsiveText(
                text: "🚀 Genius Radio",
                mediumStyle: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(26, 41, 75, 1),
                ),
                bigStyle: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(26, 41, 75, 1),
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
                          boxShape:
                          NeumorphicBoxShape.circle()),
                      child: Icon(
                        Icons.share_outlined,
                        color: Color.fromRGBO(26, 41, 75, 1),
                      ),
                      onPressed: () {}),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                SongInfo(),
                SizedBox(
                  height: 35,
                ),
                Container(
                    constraints: BoxConstraints(
                        maxWidth: 400),
                    child: Controls()),
              ],
            )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayerIFrame(
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
      child: YoutubePlayerControllerProvider(
        controller: _controller,
        child: Observer(
          builder: (_) => !_store.isLoadingPlaylist
              ? Scaffold(
                  backgroundColor: Color.fromRGBO(248, 247, 247, 1),
                  body: Stack(
                    children: [
                      //Invisible Player
                      SizedBox(height: 0, width: 0, child: player),
                      LayoutBuilder(
                          builder: (context, constraints) => (constraints.maxHeight/constraints.maxWidth)<1?_buildDesktop():_buildMobile()),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
