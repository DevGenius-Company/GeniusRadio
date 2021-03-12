import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/resources/app_config.dart';
import 'package:genius_radio/resources/constants.dart';
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

              /*SizedBox(height:200,width: 200,child: YoutubePlayerIFrame(
                controller: _controller,
                key: Key("player"),
              )),*/
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
  AnimationController _animationController;

  get http => null;

  @override
  void initState() {
    super.initState();
    _store = context.read();
    _store.loadPlaylist(Constants.playlist);

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

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
      /*if(value.playerState==PlayerState.ended && !_store.isSeeking){
        if(_store.playlistIndex!=_store.playlist.length-1){
          _controller.seekTo(Duration(milliseconds: 0));
          _store.nextSong();
          _controller.nextVideo();
        }
      }*/
      if (value.metaData.videoId !=
          _store.playlist[_store.playlistIndex].videoId) {
        int index = _store.playlist
            .indexWhere((element) => element.videoId == value.metaData.videoId);
        if (index > -1) {
          _store.selectSong(index);
        }
      }
      /*if(value.playerState == PlayerState.playing &&_controller.value.position.inSeconds!=0 && _controller.value.position.inSeconds==_controller.metadata.duration.inSeconds){
        _controller.seekTo(Duration(seconds: 0));
        _controller.nextVideo();
        _store.nextSong();
      }*/
      if (value.playerState == PlayerState.playing) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _store.setValues(value);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String formatDuration(String value) {
    return _store.position.toString().split(".")[0].split(":")[1] +
        ":" +
        _store.position.toString().split(".")[0].split(":")[2];
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
                      Column(
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
                                  padding: const EdgeInsets.only(left:30),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 400,
                                              width: 400,
                                              child: Neumorphic(
                                                padding: EdgeInsets.all(10),
                                                style: NeumorphicStyle(
                                                    boxShape: NeumorphicBoxShape
                                                        .circle(),
                                                    color: Colors.white),
                                                child: _controller
                                                            .value.isReady &&
                                                        _store.playerState !=
                                                            PlayerState.buffering
                                                    ? ClipOval(
                                                        child: Image.network(
                                                        YoutubePlayerController
                                                            .getThumbnail(
                                                                videoId: _store
                                                                    .playlist[_store
                                                                        .playlistIndex]
                                                                    .videoId,
                                                                quality:
                                                                    ThumbnailQuality
                                                                        .max,
                                                                webp: false),
                                                        fit: BoxFit.cover,
                                                      ))
                                                    : SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Color
                                                                        .fromRGBO(
                                                                            26,
                                                                            41,
                                                                            75,
                                                                            1)))),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    _store
                                                        .playlist[
                                                            _store.playlistIndex]
                                                        .author,
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          26, 41, 75, 1),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    _store
                                                        .playlist[
                                                            _store.playlistIndex]
                                                        .title,
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w300,
                                                      color: Color.fromRGBO(
                                                          26, 41, 75, 1),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 400),
                                              child: NeumorphicSlider(
                                                style: SliderStyle(
                                                    depth: 2,
                                                    thumbBorder: NeumorphicBorder(
                                                        isEnabled: true,
                                                        color: Colors.white,
                                                        width: 6),
                                                    accent: Color.fromRGBO(
                                                        26, 41, 75, 1),
                                                    variant: Color.fromRGBO(
                                                        26, 41, 75, 1)),
                                                value: _store.isSeeking
                                                    ? _store.seekValue
                                                    : _store.position.inSeconds
                                                        .toDouble(),
                                                max: _store.duration.inSeconds
                                                    .toDouble(),
                                                onChangeEnd: (value) {
                                                  _store.setSeeking(false);
                                                  _controller.seekTo(Duration(
                                                      seconds: value.toInt()));
                                                },
                                                onChangeStart: (value) {
                                                  _store.setSeeking(true);
                                                  _store.setSeekValue(value);
                                                },
                                                onChanged: (value) {
                                                  _store.setSeekValue(value);
                                                },
                                              ),
                                            ),
                                            Text(
                                              formatDuration(
                                                  _store.position.toString()),
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 35),
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 400),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      child: NeumorphicButton(
                                                          style: NeumorphicStyle(
                                                              color: Colors.white,
                                                              boxShape:
                                                                  NeumorphicBoxShape
                                                                      .circle()),
                                                          child: Icon(
                                                            Icons
                                                                .skip_previous_rounded,
                                                            color: Color.fromRGBO(
                                                                26, 41, 75, 1),
                                                          ),
                                                          onPressed: () {
                                                            _controller
                                                                .previousVideo();
                                                            _store.previousSong();
                                                          }),
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
                                                              color:
                                                                  Color.fromRGBO(
                                                                      26,
                                                                      41,
                                                                      75,
                                                                      1),
                                                              boxShape:
                                                                  NeumorphicBoxShape
                                                                      .circle()),
                                                          child: AnimatedIcon(
                                                            icon: AnimatedIcons
                                                                .pause_play,
                                                            color: Colors.white,
                                                            progress:
                                                                _animationController,
                                                            semanticLabel:
                                                                'Show menu',
                                                          ),
                                                          onPressed: () {
                                                            _controller.value
                                                                        .playerState ==
                                                                    PlayerState
                                                                        .playing
                                                                ? _controller
                                                                    .pause()
                                                                : _controller
                                                                    .play();
                                                          }),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      child: NeumorphicButton(
                                                          style: NeumorphicStyle(
                                                              color: Colors.white,
                                                              boxShape:
                                                                  NeumorphicBoxShape
                                                                      .circle()),
                                                          child: Icon(
                                                            Icons
                                                                .skip_next_rounded,
                                                            color: Color.fromRGBO(
                                                                26, 41, 75, 1),
                                                          ),
                                                          onPressed: () {
                                                            _controller
                                                                .nextVideo();
                                                            _store.nextSong();
                                                          }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Expanded(
                                        flex: 6,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 50, 50, 50),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                              "🚀 Genius Radio",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      26, 41, 75, 1),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 35),
                                              Expanded(
                                                child: ListView.builder(
                                                    itemCount:
                                                        _store.playlist.length,
                                                    itemBuilder: (BuildContext
                                                                context,
                                                            int index) =>
                                                        _store.playlistIndex ==
                                                                index
                                                            ? Neumorphic(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(19),
                                                                style: NeumorphicStyle(
                                                                    boxShape: NeumorphicBoxShape.roundRect(
                                                                        BorderRadius
                                                                            .circular(
                                                                                15)),
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            26,
                                                                            41,
                                                                            75,
                                                                            1)),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .play_arrow_rounded,
                                                                        color: Colors
                                                                            .white),
                                                                    SizedBox(
                                                                        width:
                                                                            22),
                                                                    Expanded(
                                                                      child: Text(
                                                                          _store.playlist[index].author +
                                                                              " - " +
                                                                              _store
                                                                                  .playlist[
                                                                                      index]
                                                                                  .title,
                                                                          overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                          style: GoogleFonts.montserrat(
                                                                              color:
                                                                                  Colors.white,
                                                                              fontSize: 18)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : InkWell(
                                                                onTap: () {
                                                                  _controller
                                                                      .playVideoAt(
                                                                          index);
                                                                  //_store.selectSong(index);
                                                                },
                                                                child: Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              19),
                                                                  child: Row(
                                                                    children: [
                                                                      Text((index +
                                                                              1)
                                                                          .toString()),
                                                                      SizedBox(
                                                                          width:
                                                                              22),
                                                                      Expanded(
                                                                        child: Text(
                                                                            _store.playlist[index].author +
                                                                                " - " +
                                                                                _store.playlist[index].title,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: GoogleFonts.montserrat(color: Colors.black, fontSize: 18)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
