import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/resources/colors.dart';
import 'package:genius_radio/src/widgets/responsive_text.dart';
import 'package:genius_radio/src/stores/player_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class Playlist extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(height: 35),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        itemCount: _store.playlist.length,
                        itemBuilder: (BuildContext context, int index) => _store
                                    .playlistIndex ==
                                index
                            ? Neumorphic(
                                margin: EdgeInsets.only(right: 50, top: 10),
                                padding: EdgeInsets.all(19),
                                style: NeumorphicStyle(
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(15)),
                                    color: CustomColors.darkBlue),
                                child: Row(
                                  children: [
                                    Icon(Icons.play_arrow_rounded,
                                        color: Colors.white),
                                    SizedBox(width: 22),
                                    Expanded(
                                      child: ResponsiveText(
                                          text: _store.playlist[index].author +
                                              " - " +
                                              _store.playlist[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          mediumStyle: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontSize: 15),
                                          bigStyle: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontSize: 18)),
                                    ),
                                  ],
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  context.ytController.playVideoAt(index);
                                  //_store.selectSong(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 50, top: 0),
                                  padding: EdgeInsets.all(19),
                                  child: Row(
                                    children: [
                                      ResponsiveText(
                                          text: (index + 1).toString(),
                                          overflow: TextOverflow.ellipsis,
                                          mediumStyle: GoogleFonts.montserrat(
                                              color: CustomColors.darkBlue,
                                              fontSize: 15),
                                          bigStyle: GoogleFonts.montserrat(
                                              color: CustomColors.darkBlue,
                                              fontSize: 18)),
                                      SizedBox(width: 22),
                                      Expanded(
                                        child: ResponsiveText(
                                            text: _store
                                                    .playlist[index].author +
                                                " - " +
                                                _store.playlist[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            mediumStyle: GoogleFonts.montserrat(
                                                color: CustomColors.darkBlue,
                                                fontSize: 15),
                                            bigStyle: GoogleFonts.montserrat(
                                                color: CustomColors.darkBlue,
                                                fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ))),
                  ),
                ),
                //Dummy object
                _store.playlistIndex == 0 ? SizedBox() : SizedBox(),
              ],
            ));
  }
}
