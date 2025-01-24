import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

extension CompanionAsyncValueExt<T> on AsyncValue<T> {
  Widget onData({
    required Widget Function(T value) whenData,
    Widget Function()? whenEmpty,
  }) {
    return when(
      loading: () => const CircularProgressIndicator().centered(),
      error: (err, stack) => err.toString().text.makeCentered(),
      data: (T data) {
        if (data is List<dynamic>) {
          if (data.isEmpty && whenEmpty != null) {
            return whenEmpty();
          }
        }
        return whenData(data);
      },
    );
  }
}

extension CompanionStringExt on String {
  Color toColor() {
    return Color(int.tryParse("0x${substring(1)}")!);
  }
}
