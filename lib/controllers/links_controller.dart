import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkController extends GetxController {
  static LinkController instance = Get.put(LinkController());

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
  

  // open play store
  void shareApp() {
    Share.share(
        'https://play.google.com/store/apps/details?id=com.Transcended.com');
  }

  // update app
  void openPlayStore() {
    _launch('https://play.google.com/store/apps/details?id=com.Transcended.com');
  }
  // about us
  void aboutUs() {
    _launch(
        'https://transcendedinstitute.com/about-us/');
  }
   // blog
  void blog() {
    _launch(
        'https://transcendedinstitute.com/blog/');
  }

  // privacy policy app
  void privacyPolicy() {
    _launch(
        'https://github.com/Estudiee/Estudiee-privacy-policy/blob/main/README.md');
  }

  // contact developer
  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'admin@transcendedinstitute.com',
    );
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {
    // ignore: deprecated_member_use
    if (!await launch(
      url,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      Fluttertoast.showToast(msg: 'Cache Cleared');
    }
  }

  Future<void> deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}
