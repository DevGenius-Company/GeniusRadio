import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle smallStyle, mediumStyle, bigStyle;
  final TextAlign align;
  final TextOverflow overflow;

  const ResponsiveText(
      {Key key,
      this.text,
      this.smallStyle,
      @required this.mediumStyle,
      this.bigStyle,
      this.align,
      this.overflow})
      : assert(mediumStyle != null, "medium style shouldn't be null"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: Text(text,
          style: smallStyle ?? mediumStyle,
          textAlign: align,
          overflow: overflow),
      tablet:
          Text(text, style: mediumStyle, textAlign: align, overflow: overflow),
      desktop: Text(text,
          style: bigStyle ?? mediumStyle, textAlign: align, overflow: overflow),
    );
  }
}
