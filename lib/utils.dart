import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_hive_generator/json_hive_generator.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(final String contact) async {
  final Uri telUrl = Uri.parse("tel:$contact");
  if (await canLaunchUrl(telUrl)) {
    await launchUrl(telUrl);
  }
}

extension ImportExport<E> on Box<E> {
  Future<void> exportTo(String filePath) async {
    return await HiveExporter<E>(this, "$filePath/${name}.json").export();
  }

  // Future<void> importFrom(String filePath) async {
  //   final file = File("$filePath/${name}.json");
  //   final jsonEvents = await file.readAsString();
  //   final events = json.decode(jsonEvents) as List<E>;
  //   await clear();

  //   final obj = events.cast<E>();

  //   print(Map.fromIterable(
  //     obj,
  //     key: (o) => o.id,
  //   ).toString());

  //   // await addAll(events.cast<E>());
  //   // return await HiveImporter<E>(this, "$filePath/${name}.json").import();
  // }
}
