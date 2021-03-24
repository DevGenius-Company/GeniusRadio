import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genius_radio/resources/assets.dart';
import 'package:genius_radio/resources/colors.dart';
import 'package:genius_radio/resources/constants.dart';
import 'package:genius_radio/resources/texts.dart';
import 'package:genius_radio/src/home/ui/widgets/dialog_user_credit_row.dart';
import 'package:genius_radio/src/home/ui/widgets/responsive_text.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditsDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreditsDialogState();
}

class _CreditsDialogState extends State<CreditsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
      child: LayoutBuilder(
          builder: (context, constraints) => Container(
                constraints: BoxConstraints(minWidth: 350, maxWidth: 900),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ResponsiveText(
                      text: CustomTexts.developedBy,
                      mediumStyle: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.darkBlue),
                      bigStyle: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.darkBlue),
                    ),
                    SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DialogUserCreditRow(
                            CustomAssets.emanuel,
                            CustomTexts.emanuelTesoriello,
                            Constants.linkedinEmanuelUrl,
                            CustomTexts.emanuelDescription),
                        SizedBox(height: 25),
                        DialogUserCreditRow(
                            CustomAssets.giorgio,
                            CustomTexts.giorgioBoa,
                            Constants.linkedinGiorgioUrl,
                            CustomTexts.giorgioDescription),
                        SizedBox(height: 25),
                        DialogUserCreditRow(
                            CustomAssets.francesco,
                            CustomTexts.francescoLaForgia,
                            Constants.linkedinFrancescoUrl,
                            CustomTexts.francescoDescription),
                        SizedBox(height: 25),
                      ],
                    ),
                    SizedBox(height: 40),
                    ResponsiveText(
                      text: CustomTexts.sponsoredBy,
                      mediumStyle: GoogleFonts.montserrat(
                          fontSize: 10, color: CustomColors.darkBlue),
                      bigStyle: GoogleFonts.montserrat(
                          fontSize: 15, color: CustomColors.darkBlue),
                    ),
                  ],
                ),
              )),
    );
  }
}
