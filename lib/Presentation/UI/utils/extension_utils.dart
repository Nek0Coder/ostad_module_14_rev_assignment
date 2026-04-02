import 'package:flutter/material.dart';

extension WidgetUtil on Widget {
  Widget withPadding(double x) {
    return Padding(padding: .all(x), child: this);
  }

  Widget centered() {
    return Center(child: this);
  }

  Widget expanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }
}

extension SpacingX on num {
  Widget get hb => SizedBox(height: toDouble());

  Widget get wb => SizedBox(width: toDouble());

  Widget get pad => Padding(padding: .all(toDouble()));
}

TextSpan textSpan(
  String text, {
  FontWeight? fontWeight,
  double? fontSize,
  Color? color,
  FontStyle? fontStyle,
}) {
  return TextSpan(
    text: text,
    style: TextStyle(
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: (fontSize) ?? 18,
      color: (color) ?? Colors.black,
      fontStyle: (fontStyle) ?? FontStyle.normal,
    ),
  );
}

Widget styledText(
  BuildContext context,
  TextAlign textAlign,
  List<InlineSpan> spans,
) {
  return Text.rich(TextSpan(children: spans), textAlign: textAlign);
}
// --- String Logic Extensions ---
// extension StringUtils on String {
//   ///email format.
//   bool get isValidEmail => contains('@') && contains('.');

//   /// Capitalize the first letter of a string.
//   String capitalize() => length > 0 ?'${this[0].toUpperCase()}${substring(1)}' : this;
// }
