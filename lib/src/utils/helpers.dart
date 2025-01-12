import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(final String contact) async {
  final Uri telUrl = Uri.parse("tel:$contact");
  if (await canLaunchUrl(telUrl)) {
    await launchUrl(telUrl);
  }
}
