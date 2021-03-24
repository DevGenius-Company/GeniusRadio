import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/resources/assets.dart';
import 'package:genius_radio/resources/colors.dart';
import 'package:genius_radio/src/home/ui/widgets/controls.dart';
import 'package:genius_radio/src/home/ui/widgets/responsive_text.dart';
import 'package:genius_radio/src/home/ui/widgets/song_info.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageMobile extends StatelessWidget {
  final Function onShowCreditClick;
  final Function onShareClick;

  HomePageMobile(this.onShowCreditClick, this.onShareClick);

  @override
  Widget build(BuildContext context) {
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
                          boxShape: NeumorphicBoxShape.circle(),
                          color: Color.fromRGBO(248, 247, 247, 1)),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(CustomAssets.devgenius),
                      ),
                      onPressed: onShowCreditClick),
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
                          boxShape: NeumorphicBoxShape.circle(),
                          color: Color.fromRGBO(248, 247, 247, 1)),
                      child: Icon(
                        Icons.share_outlined,
                        color: CustomColors.darkBlue,
                      ),
                      onPressed: onShareClick),
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
}
