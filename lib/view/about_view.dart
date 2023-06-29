import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/about_controller.dart';

// açıklama: Apartman Yönetimi Uygulaması, modern ve etkili bir apartman yönetim deneyimi sunmayı hedefleyen kullanıcı dostu bir platformdur. Apartman sakinlerinin günlük yaşamını kolaylaştırmak ve iletişim süreçlerini geliştirmek için tasarlanmıştır. Bu uygulama sayesinde apartman sakinleri, yöneticiler ve tüm paydaşlar arasında sorunsuz bir etkileşim sağlamayı amaçlıyoruz.

class AboutView extends StatelessWidget {

  final AboutController _controller = Get.put(AboutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hakkında"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: Image.asset("assets/images/logo.png"),
              ),
              const Text(
                "Şirket",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      height: 24,
                      width: 24,
                      "assets/images/cerbeta_logo.png",
                    ),
                  ),
                  Text("Cerbeta"),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  _launchUrl("https://www.cerbeta.com");
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.link,
                      size: 28,
                    ),
                    Text(
                      "www.cerbeta.com",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(
                      width: 28,
                      height: 28,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Geliştirici",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              InkWell(
                onTap: () {
                  _launchUrl(
                      "https://www.linkedin.com/in/ahmet-fatih-çenesiz-a820b3183/");
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.link,
                      size: 28,
                    ),
                    Text(
                      "Ahmet Fatih Çenesiz",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(
                      width: 24,
                      height: 24,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
