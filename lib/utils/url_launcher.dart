import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  Future<void> _launchUrlPhone({required String phoneNumber}) async {
    var phoneWithSchema = "tel:$phoneNumber";
    final Uri url = Uri.parse(phoneWithSchema);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void launchPhoneUrlCaller({required String phoneNumber}) {
    _launchUrlPhone(phoneNumber: phoneNumber);
  }

  Future<void> _launchURLHttp({
    required String webAddress,
    required String type,
  }) async {
    var webAddressWithSchema = "https://$webAddress";

    final Uri url = Uri.parse(webAddressWithSchema);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }

    // if (type == "appupdate") {
    //
    // } else if (type == "webpage") {
    //   if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    //     throw 'Could not launch $url';
    //   }
    // } else if (type == "location") {
    //   if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    //     throw 'Could not launch $url';
    //   }
    // }
  }

  void launchWebAddressUrlCaller({
    required String webAddress,
    required String type,
  }) {
    _launchURLHttp(webAddress: webAddress, type: type);
  }
}
