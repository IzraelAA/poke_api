

import 'package:flutter/cupertino.dart';

/// use pokemon text style
class AppTextStyle {
  static TextStyle pokemonHeader({Color color = const Color(0xfffbfbfb)}) {
    return TextStyle(
      fontFamily: 'Pokemon',
      fontSize: 24,
      color: color,
    );
  }

  static TextStyle pokemonTitle({Color color = const Color(0xfffbfbfb)}) {
    return TextStyle(
      fontFamily: 'Pokemon',
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle pokemonSubTitle({Color color = const Color(0xfffbfbfb)}) {
    return TextStyle(
      fontSize: 18,
      fontFamily: 'Pokemon',
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle pokemonStatLabel({Color color = const Color(0xfffbfbfb)}) {
    return TextStyle(
      fontSize: 16,
      fontFamily: 'Pokemon',
      fontWeight: FontWeight.w400,
      color: Color(0xff333333),
    );
  }

  static TextStyle pokemonBody({Color color = const Color(0xff666666)}) {
    return TextStyle(
      fontSize: 14,
      fontFamily: 'Pokemon',
      fontWeight: FontWeight.w400,
      color: color,
    );
  }
}
