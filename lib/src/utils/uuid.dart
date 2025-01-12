import 'package:cuid2/cuid2.dart';

String uuid() => cuidConfig(length: 8).gen();
