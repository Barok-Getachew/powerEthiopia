import 'package:url_launcher/url_launcher.dart';

// To open a URL:
void launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(url),
    );
  } else {
    throw 'Could not launch $url';
  }
}

// To dial a phone number:
Future<void> launchPhone(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
