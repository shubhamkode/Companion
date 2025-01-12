import 'dart:ui';

extension ColorExt on String {
  Color colorFromHex() {
    return Color(int.tryParse("0x${substring(1)}")!);
  }
}
