import 'package:url_launcher/url_launcher.dart';

class LinkParser {
  LinkParser._();
  static void launchGoolgeMapsNavigation(
      double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps?q=${latitude},${longitude}&travelmode=driving';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static void launchWhatsappHelpCenter() async {
    const url =
        'https://wa.me/256702703612?text=Hi Zula Team, I need assistance on.....';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static void launchWhatsappWithLink(String? link) async {
    final facebookUrl = 'https://api.whatsapp.com/send?text=$link';
    if (link != null) {
      if (await canLaunchUrl(Uri.parse(facebookUrl))) {
        await launchUrl(Uri.parse(facebookUrl));
      } else {
        throw 'Could not launch $facebookUrl';
      }
    } else {}
  }

  static void launchSMSWithLink(String? link) async {
    final smsUrl = 'sms:?body=$link';
    if (link != null) {
      if (await canLaunchUrl(Uri.parse(smsUrl))) {
        await launchUrl(Uri.parse(smsUrl));
      } else {
        throw 'Could not launch $smsUrl';
      }
    } else {}
  }
}
