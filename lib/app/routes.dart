// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:real_estate_app/Ui/main_activity.dart';

import '../Ui/home_screen.dart';
import '../Ui/login_screen.dart';
import '../Ui/splash_screen.dart';
import '../main.dart';

class AppRoutes {
  static const String WELCOME = '/welcome';
  static const String SPLASH = '/splash';
  static const String HOME = '/home';
  static const String EXPIRED = '/expired_user';
  static const String SEARCH = '/search';
  static const String FILTER = '/filter';
  static const String SIGNUP = '/signup';
  static const String LOGIN = '/signin';
  static const String MAIN = '/main_activity';
}

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AppRoutes.HOME:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => HomeScreen(),
      );
    case AppRoutes.SPLASH:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );
    case AppRoutes.LOGIN:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => LoginScreen(),
      );
      case AppRoutes.MAIN:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => MainActivity(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}

// Map<String, WidgetBuilder> getApplicationRoutes() {
//   return {
//     AppRoutes.HOME: (context) => HomeScreen(),
//     AppRoutes.SEARCH: (context) => ImageFilteringScreen(),
//     AppRoutes.Flutter3d: (context) => Flutter3dScreen(),
//     AppRoutes.SPLASH: (context) => const SplashScreen(),
//     AppRoutes.SIGNIN: (context) => const SplashScreen(),
//     AppRoutes.MODELVIEWERPLUS: (context) => const ModelViewer(
//           backgroundColor: Colors.greenAccent,
//           src: 'assets/models/3072_0705_3.glb',
//           alt: 'A 3D model of an Elliva Chair',
//           ar: true,
//           autoRotate: true,
//           iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
//           disableZoom: false,
//         ),
//     AppRoutes.CHAIRFORM: (context) => const ChairFormPage(),
//     AppRoutes.IMAGEPREVIEWADD: (context) => ImagePreviewAddFormPage(context),
//     AppRoutes.SELECTMODEL: (context) => const SelectModelPage(),
//     AppRoutes.SELECTCOLOR: (context) => const SelectColorPage(),
//     AppRoutes.IMAGE_FILTER: (context) => ImageFilterPage(),
//   };
// }
