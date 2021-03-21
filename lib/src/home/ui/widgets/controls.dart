import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/resources/colors.dart';
import 'package:genius_radio/resources/custom_thumb_shape.dart';
import 'package:genius_radio/src/home/stores/player_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class Controls extends StatefulWidget {
  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> with TickerProviderStateMixin {
  PlayerStore _store;
  bool _isPlaying = false;

  @override
  void initState() {
    _store = context.read();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formatDuration(String value) {
    return _store.position.toString().split(".")[0].split(":")[1] +
        ":" +
        _store.position.toString().split(".")[0].split(":")[2];
  }

  @override
  Widget build(BuildContext context) {
    context.ytController.listen((value) {
      if (value.playerState == PlayerState.playing) {
        if (_isPlaying != true) {
          _isPlaying = true;
        }
      } else {
        if (_isPlaying != false) {
          _isPlaying = false;
        }
      }
    });
    return Observer(
        builder: (_) => Column(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: CustomColors.darkBlue,
                      inactiveTrackColor: Colors.grey[200],
                      trackHeight: 10,
                      trackShape: RoundedRectSliderTrackShape(),
                      thumbColor: CustomColors.darkBlue,
                      thumbShape: CustomThumbShape(thumbRadius: 10),
                      overlayColor: CustomColors.darkBlue.withOpacity(0.3),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 28.0),
                    ),
                    child: Slider(
                        value: _store.isSeeking
                            ? _store.seekValue
                            : _store.position != null
                                ? _store.position.inSeconds.toDouble()
                                : 0,
                        max: _store.duration != null
                            ? _store.duration.inSeconds.toDouble()
                            : 100,
                        onChangeEnd: (value) {
                          _store.setSeeking(false);
                          context.ytController
                              .seekTo(Duration(seconds: value.toInt()));
                        },
                        onChangeStart: (value) {
                          _store.setSeeking(true);
                          _store.setSeekValue(value);
                        },
                        onChanged: (value) {
                          _store.setSeekValue(value);
                        }),
                  ),
                ),
                Text(
                  formatDuration(_store.position.toString()),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: NeumorphicButton(
                            style: NeumorphicStyle(
                                color: Colors.white,
                                boxShape: NeumorphicBoxShape.circle()),
                            child: Icon(
                              Icons.skip_previous_rounded,
                              color: CustomColors.darkBlue,
                            ),
                            onPressed: () {
                              context.ytController.previousVideo();
                            }),
                      ),
                    ),
                    SizedBox(width: 35),
                    Container(
                      height: 80,
                      width: 80,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: NeumorphicButton(
                            style: NeumorphicStyle(
                                color: CustomColors.darkBlue,
                                boxShape: NeumorphicBoxShape.circle()),
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 250),
                              child: _isPlaying
                                  ? Icon(
                                      Icons.pause_rounded,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                    ),
                            ),
                            onPressed: () {
                              context.ytController.value.playerState ==
                                      PlayerState.playing
                                  ? context.ytController.pause()
                                  : context.ytController.play();
                            }),
                      ),
                    ),
                    SizedBox(width: 35),
                    Container(
                      height: 60,
                      width: 60,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: NeumorphicButton(
                            style: NeumorphicStyle(
                                color: Colors.white,
                                boxShape: NeumorphicBoxShape.circle()),
                            child: Icon(
                              Icons.skip_next_rounded,
                              color: CustomColors.darkBlue,
                            ),
                            onPressed: () {
                              context.ytController.nextVideo();
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }
}
