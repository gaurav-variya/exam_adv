import 'package:exam_adv/screens/favourite/favourite_page.dart';
import 'package:exam_adv/screens/home/home_page.dart';
import 'package:exam_adv/screens/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static String splash = '/';
  static String home = '/home';
  static String favorite = '/favourite';

  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: home,
      page: () => HomePage(),
    ),
    GetPage(
      name: favorite,
      page: () => FavouritePage(),
    ),
  ];
}
