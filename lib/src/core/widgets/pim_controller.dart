import 'package:flutter/material.dart';

class PimController extends TextEditingController {
  final String id;
  String? created;

  PimController({
    required this.id,
    required super.text,
    this.created,
  });

  String get digits => text;
}
