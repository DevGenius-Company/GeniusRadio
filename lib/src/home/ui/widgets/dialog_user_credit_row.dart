import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genius_radio/resources/colors.dart';
import 'package:genius_radio/src/base/utilities/url_launcher.dart';
import 'package:genius_radio/src/home/ui/widgets/responsive_avatar.dart';
import 'package:genius_radio/src/home/ui/widgets/responsive_text.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogUserCreditRow extends StatelessWidget {
  final String assetImage;
  final String username;
  final String linkedinUrl;
  final String description;

  DialogUserCreditRow(
      this.assetImage, this.username, this.linkedinUrl, this.description);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Spacer(),
        ResponsiveAvatar(assetImage),
        Spacer(),
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ResponsiveText(
                    text: username,
                    mediumStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.darkBlue),
                    bigStyle: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.darkBlue),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.linkedin),
                    color: Color.fromRGBO(15, 118, 168, 1),
                    onPressed: () => launchURL(linkedinUrl),
                  ),
                ],
              ),
              ResponsiveText(
                text: description,
                smallStyle: TextStyle(fontSize: 0),
                mediumStyle: GoogleFonts.montserrat(
                    fontSize: 15, color: CustomColors.darkBlue),
                bigStyle: GoogleFonts.montserrat(
                    fontSize: 18, color: CustomColors.darkBlue),
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}
