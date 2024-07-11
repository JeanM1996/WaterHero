import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class Uris {
  Future<bool> launchWhatsapp() {
    final url = Platform.isIOS
        ? 'whatsapp://send?phone=+573246224661'
        : 'https://api.whatsapp.com/send/?phone=+573246224661text=Hola&type=phone_number';
    return launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  //launch phone
  Future<bool> launchPhone() {
    final url = Platform.isIOS ? 'tel://+573246224661' : 'tel:+573246224661';
    return launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<bool> launchWhatsappPhone(String phone) {
    final url = Platform.isIOS
        ? 'whatsapp://send?phone=$phone'
        : 'https://api.whatsapp.com/send/?phone=${phone}text=Hola&type=phone_number';
    return launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<bool> launchPhonePhone(String phone) {
    String url;
    url = 'tel:$phone';
    return launchUrl(Uri.parse(url));
  }

  Future<bool> launchEmail(String email) {
    final url = 'mailto:$email';
    return launchUrl(Uri.parse(url));
  }

  Future<bool> launchPrivacyPolicy() {
    const url = 'https://waterhero-3a.web.app/privacy_policy.html';
    return launchUrl(Uri.parse(url));
  }
}

final Uris uris = Uris();
