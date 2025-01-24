import 'package:url_launcher/url_launcher.dart';

Future<void> makeCallTo(final String contact) async {
  if (contact.isEmpty) {
    return;
  }
  final Uri telUrl = Uri.parse("tel:+91 $contact");
  if (await canLaunchUrl(telUrl)) {
    await launchUrl(telUrl);
  }
}
