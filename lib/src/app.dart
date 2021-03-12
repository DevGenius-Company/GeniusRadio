import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/resources/app_config.dart';
import 'package:genius_radio/resources/constants.dart';
import 'package:genius_radio/stores/player_store.dart';
import 'package:provider/provider.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

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
      if (value.playerState == PlayerState.playing) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _store.setValues(value);
      _store.setPosition(value.position);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            padding: EdgeInsets.all(40),
                            child: Neumorphic(
                              padding: EdgeInsets.all(10),
                              style: NeumorphicStyle(
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(65)),
                                  color: Colors.white),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 310,
                                      width: 310,
                                      child: Neumorphic(
                                        padding: EdgeInsets.all(10),
                                        style: NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.circle(),
                                            color: Colors.white),
                                        child: _controller.value.isReady
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
                                                        Colors.transparent,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Color.fromRGBO(26,
                                                                41, 75, 1)))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      _store.playlist[_store.playlistIndex]
                                          .author,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      _store
                                          .playlist[_store.playlistIndex].title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    NeumorphicSlider(
                                      style: SliderStyle(
                                          depth: 2,
                                          thumbBorder: NeumorphicBorder(
                                              isEnabled: true,
                                              color: Colors.white,
                                              width: 6),
                                          accent: Color.fromRGBO(26, 41, 75, 1),
                                          variant:
                                              Color.fromRGBO(26, 41, 75, 1)),
                                      value:
                                          _store.position.inSeconds.toDouble(),
                                      max: _store.duration.inSeconds.toDouble(),
                                      onChanged: (value) {
                                        _controller.seekTo(
                                            Duration(seconds: value.toInt()));
                                      },
                                    ),
                                    Text(
                                      _store.position.toString(),
                                      style: const TextStyle(
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
                                                    Icons.skip_previous_rounded,
                                                    color: Color.fromRGBO(
                                                        26, 41, 75, 1),
                                                  ),
                                                  onPressed: () {
                                                    _store.previousSong();
                                                    _controller.previousVideo();
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
                                                      color: Color.fromRGBO(
                                                          26, 41, 75, 1),
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .circle()),
                                                  child: AnimatedIcon(
                                                    icon: AnimatedIcons
                                                        .pause_play,
                                                    color: Colors.white,
                                                    progress:
                                                        _animationController,
                                                    semanticLabel: 'Show menu',
                                                  ),
                                                  onPressed: () {
                                                    _controller.value
                                                                .playerState ==
                                                            PlayerState.playing
                                                        ? _controller.pause()
                                                        : _controller.play();
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
                                                    Icons.skip_next_rounded,
                                                    color: Color.fromRGBO(
                                                        26, 41, 75, 1),
                                                  ),
                                                  onPressed: () {
                                                    _store.nextSong();
                                                    _controller.nextVideo();
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 300,
                                      child: ListView.builder(
                                          itemCount: _store.playlist.length,
                                          itemBuilder: (BuildContext ctxt,
                                                  int index) =>
                                              _store.playlistIndex == index
                                                  ? Neumorphic(
                                                      padding:
                                                          EdgeInsets.all(19),
                                                      style: NeumorphicStyle(
                                                          boxShape: NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          color: Color.fromRGBO(
                                                              26, 41, 75, 1)),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .play_arrow_rounded,
                                                              color:
                                                                  Colors.white),
                                                          SizedBox(width: 22),
                                                          Text(
                                                              _store
                                                                      .playlist[
                                                                          index]
                                                                      .author +
                                                                  " - " +
                                                                  _store
                                                                      .playlist[
                                                                          index]
                                                                      .title,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      18)),
                                                        ],
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: (){
                                                        _store.selectSong(index);
                                                        _controller.playVideoAt(index);
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  19),
                                                          child: Row(
                                                            children: [
                                                              Text((index+1).toString()),
                                                              SizedBox(width: 22),
                                                              Text(
                                                                  _store
                                                                      .playlist[
                                                                  index]
                                                                      .author +
                                                                      " - " +
                                                                      _store
                                                                          .playlist[
                                                                      index]
                                                                          .title,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                      18)),
                                                            ],
                                                          ),))),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
