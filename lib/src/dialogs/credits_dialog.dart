import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genius_radio/src/widgets/responsive_avatar.dart';
import 'package:genius_radio/src/widgets/responsive_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreditsDialogState();
}

class _CreditsDialogState extends State<CreditsDialog> {
  String emanuelDescription="Amo i Computer e Programmare. Ho realizzato il mio sogno co-fondando DevGenius.it e creando un fantastico team che ci permette di aiutare quotidianamente i nostri clienti!";
  String giorgioDescription="Public speaker in italian tech community. Recently I've done some talks about git, docker, communities and frontend ecosystem. Author and maintainer of open source project VsCode Jira Plugin.";
  String francescoDescription="22 yrs old man graduated in I.T.I.S L. DI Maggio and certificated in Cisco CCNA. Passion for programming in every language.";
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

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
                      text: "Developed By",
                      mediumStyle: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(26, 41, 75, 1)),
                      bigStyle: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(26, 41, 75, 1)),
                    ),
                    SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Spacer(),
                            ResponsiveAvatar("assets/avatars/emanuel.jpg"),
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
                                        text: "Emanuel Tesoriello",
                                        mediumStyle: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(26, 41, 75, 1)),
                                        bigStyle: GoogleFonts.montserrat(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(26, 41, 75, 1)),
                                      ),
                                      IconButton(
                                        icon: Icon(FontAwesomeIcons.linkedin),
                                        color: Color.fromRGBO(15, 118, 168, 1),
                                        onPressed: () => _launchURL(
                                            "https://www.linkedin.com/in/emanuel-tesoriello-developer/"),
                                      ),
                                    ],
                                  ),
                                  ResponsiveText(
                                    text: emanuelDescription,
                                    smallStyle: TextStyle(fontSize: 0),
                                    mediumStyle: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color:
                                        Color.fromRGBO(26, 41, 75, 1)),
                                    bigStyle: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color:
                                        Color.fromRGBO(26, 41, 75, 1)),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Spacer(),
                            ResponsiveAvatar("assets/avatars/giorgio.jpg"),
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
                                        text: "Giorgio Boa",
                                        mediumStyle: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(26, 41, 75, 1)),
                                        bigStyle: GoogleFonts.montserrat(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(26, 41, 75, 1)),
                                      ),
                                      IconButton(
                                        icon: Icon(FontAwesomeIcons.linkedin),
                                        color: Color.fromRGBO(15, 118, 168, 1),
                                        onPressed: () => _launchURL(
                                            "https://www.linkedin.com/in/giorgio-boa-3ba717139/"),
                                      ),
                                    ],
                                  ),
                                  ResponsiveText(
                                    text: giorgioDescription,
                                    smallStyle: TextStyle(fontSize: 0),
                                    mediumStyle: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color:
                                        Color.fromRGBO(26, 41, 75, 1)),
                                    bigStyle: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color:
                                        Color.fromRGBO(26, 41, 75, 1)),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Spacer(),
                            ResponsiveAvatar("assets/avatars/francesco.jpg"),
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
                                        text: "Francesco La Forgia",
                                        mediumStyle: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(26, 41, 75, 1)),
                                        bigStyle: GoogleFonts.montserrat(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(26, 41, 75, 1)),
                                      ),
                                      IconButton(
                                        icon: Icon(FontAwesomeIcons.linkedin),
                                        color: Color.fromRGBO(15, 118, 168, 1),
                                        onPressed: () => _launchURL(
                                            "https://www.linkedin.com/in/francesco-la-forgia-808a6b151/"),
                                      ),
                                    ],
                                  ),
                                  ResponsiveText(
                                    text: francescoDescription,
                                    smallStyle: TextStyle(fontSize: 0),
                                    mediumStyle: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color:
                                        Color.fromRGBO(26, 41, 75, 1)),
                                    bigStyle: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color:
                                        Color.fromRGBO(26, 41, 75, 1)),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    ResponsiveText(
                      text: "Sponsored by DevGenius and ItalianCoders",
                      mediumStyle: GoogleFonts.montserrat(
                          fontSize: 10, color: Color.fromRGBO(26, 41, 75, 1)),
                      bigStyle: GoogleFonts.montserrat(
                          fontSize: 15, color: Color.fromRGBO(26, 41, 75, 1)),
                    ),
                  ],
                ),
              )),
    );
  }
}
