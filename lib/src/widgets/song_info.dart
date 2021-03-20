import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/resources/colors.dart';
import 'package:genius_radio/src/widgets/responsive_text.dart';
import 'package:genius_radio/src/stores/player_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class SongInfo extends StatefulWidget {
  @override
  _SongInfoState createState() => _SongInfoState();
}

class _SongInfoState extends State<SongInfo> {
  PlayerStore _store;

  @override
  void initState() {
    super.initState();
    _store = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Neumorphic(
                  padding: EdgeInsets.all(10),
                  style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                      color: Colors.white),
                  child: context.ytController.value.isReady &&
                          _store.playerState != PlayerState.buffering
                      ? CircleAvatar(
                          maxRadius: 150,
                          minRadius: 100,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              YoutubePlayerController.getThumbnail(
                                  videoId: _store
                                      .playlist[_store.playlistIndex].videoId,
                                  quality: ThumbnailQuality.max,
                                  webp: false)),
                        )
                      : CircleAvatar(
                          maxRadius: 150,
                          minRadius: 100,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage("assets/animation.gif"),
                        ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ResponsiveText(
                        text: _store.playlist[_store.playlistIndex].author,
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
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ResponsiveText(
                        text: _store.playlist[_store.playlistIndex].title,
                        mediumStyle: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: CustomColors.darkBlue,
                        ),
                        bigStyle: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: CustomColors.darkBlue,
                        ),
                        overflow: TextOverflow.ellipsis,
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                //Dummy object
                _store.playerState == PlayerState.playing
                    ? SizedBox()
                    : SizedBox()
              ],
            ));
  }
}
