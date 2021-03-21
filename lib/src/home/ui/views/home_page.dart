// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genius_radio/resources/assets.dart';
import 'package:genius_radio/resources/colors.dart';
import 'package:genius_radio/resources/constants.dart';
import 'package:genius_radio/resources/texts.dart';
import 'package:genius_radio/src/base/utilities/cookie_manager.dart';
import 'package:genius_radio/src/home/stores/player_store.dart';
import 'package:genius_radio/src/home/ui/views/credits_dialog.dart';
import 'package:genius_radio/src/home/ui/views/home_page_desktop.dart';
import 'package:genius_radio/src/home/ui/views/home_page_mobile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

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
        CustomTexts.shareAppText,
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
                                  ? HomePageDesktop(showCredits, share)
                                  : HomePageMobile(showCredits, share)),
                    ),
                  ],
                ),
              )
            : Center(child: Image.asset(CustomAssets.loadingAnimations)),
      ),
    );
  }
}
