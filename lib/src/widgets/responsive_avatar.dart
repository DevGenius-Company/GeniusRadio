import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveAvatar extends StatelessWidget {
  final String url;

  const ResponsiveAvatar(this.url,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: CircleAvatar(
          radius: 25,
          foregroundColor: Colors.transparent,
          backgroundImage: AssetImage(url),
        ),
        tablet: CircleAvatar(
          radius: 35,
          foregroundColor: Colors.transparent,
          backgroundImage: AssetImage(url),
        ),
        desktop: CircleAvatar(
          radius: 50,
          foregroundColor: Colors.transparent,
          backgroundImage: AssetImage(url),
        ));
  }
}
