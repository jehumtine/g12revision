import 'package:get/get.dart';
import 'package:g12revision/screens/main_page.dart';

class AppRoutes {
  static List<GetPage> pages() => [
        // home screen

        GetPage(name: MainPage.routeName, page: () => const MainPage()),
        //          GetPage(name: Payments.routeName, page: () => const  Payments()),
      ];
}
