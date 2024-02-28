import 'package:url_launcher/url_launcher.dart';

class Handlers {

  void openWhatsapp({String phone = '+94785250119'}) async {


    var uri = Uri.parse('https://wa.me/$phone?Text=Hello Developer');

    launchUrl(uri);

  }

  void emailto() async {
    String mail = 'fahhamohmad17@gamil.com';

    final Uri url = Uri(
      scheme: 'mailto',
      path: 'fahhamohmad17@gamil.com',
    );

    await launchUrl(url);
  }

}