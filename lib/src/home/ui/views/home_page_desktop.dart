import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:genius_radio/resources/assets.dart';
import 'package:genius_radio/resources/colors.dart';
import 'package:genius_radio/src/home/ui/widgets/controls.dart';
import 'package:genius_radio/src/home/ui/widgets/playlist.dart';
import 'package:genius_radio/src/home/ui/widgets/song_info.dart';

class HomePageDesktop extends StatelessWidget {
  final Function onShowCreditClick;
  final Function onShareClick;

  HomePageDesktop(this.onShowCreditClick, this.onShareClick);

  @override
  Widget build(BuildContext context) {
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
                      boxShape: NeumorphicBoxShape.circle(),
                      color: Color.fromRGBO(248, 247, 247, 1)),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(CustomAssets.devgenius),
                  ),
                  onPressed: onShowCreditClick),
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
    Spacer(
    )
    ]
    ,
    );
  }
}
