// // ignore_for_file: constant_identifier_names
//
// import 'package:flutter/material.dart';
// import 'package:revaugment/data/models/hive/product.dart';
//
// import 'package:revaugment/pages/chair_store/ImageFilterPage.dart';
// import 'package:revaugment/pages/chair_store/SelectColorPage.dart';
// import 'package:revaugment/pages/expired_user/expiredUserScreen.dart';
// import 'package:revaugment/pages/home/home_screen.dart';
// import 'package:revaugment/pages/search/image_filtering_screen.dart';
// import 'package:revaugment/pages/splash/splash_screen.dart';
//
//
// import '../pages/3d_model/model_viewer_page.dart';
// import '../pages/signin/signin_screen.dart';
//
// class AppRoutes {
//   static const String WELCOME = '/welcome';
//   static const String SPLASH = '/splash';
//   static const String HOME = '/home';
//   static const String EXPIRED = '/expired_user';
//   static const String SEARCH = '/search';
//   static const String FILTER = '/filter';
//   static const String SIGNUP = '/signup';
//   static const String SIGNIN = '/signin';
//   static const String SIGNINPHONE = '/phone_signin';
//   static const String VERIFYPHONE = '/verify_phone';
//   static const String MODELVIEWERPLUS = '/MODELVIEWERPLUS';
//   static const String Flutter3d = '/Flutter3d';
//   static const String CHAIRFORM = '/chair_form';
//   static const String CHAIRCOLORFORM = '/chair_color_form';
//   static const String IMAGEPREVIEWADD = '/imagepreview_add_form';
//   static const String WORKSPACEFORM = '/workspace_form';
//   static const String SELECTMODEL = '/select_model';
//   static const String SELECTCOLOR = '/select_color';
//   static const String IMAGE_FILTER = '/image_filter_screen';
// }
//
// Route<dynamic> generateRoute(RouteSettings routeSettings) {
//   switch (routeSettings.name) {
//     case AppRoutes.HOME:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const HomeScreen(),
//       );
//     case AppRoutes.EXPIRED:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const ExpiredUserScreen(),
//       );
//     case AppRoutes.SEARCH:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const ImageFilteringScreen(),
//       );
//     case AppRoutes.SPLASH:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const SplashScreen(),
//       );
//     case AppRoutes.SIGNIN:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const SignInPage(),
//       );
//   // case AppRoutes.CHAIRFORM:
//   //   return MaterialPageRoute(
//   //     settings: routeSettings,
//   //     builder: (_) => const ChairFormPage(),
//   // //   );
//   // case AppRoutes.IMAGEPREVIEWADD:
//   //   return MaterialPageRoute(
//   //     settings: routeSettings,
//   //     builder: (BuildContext context) => ImagePreviewAddFormPage(context),
//   //   );
//   // case AppRoutes.SELECTMODEL:
//   //   return PageRouteBuilder(
//   //     settings: routeSettings,
//   //     pageBuilder: (context, animation, secondaryAnimation) =>
//   //         const SelectModelPage(),
//   //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   //       const begin = Offset(1.0, 0.0);
//   //       const end = Offset.zero;
//   //       const curve = Curves.ease;
//   //
//   //       var tween =
//   //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//   //       var offsetAnimation = animation.drive(tween);
//   //
//   //       return SlideTransition(
//   //         position: offsetAnimation,
//   //         child: child,
//   //       );
//   //     },
//   //   );
//
//     case AppRoutes.SELECTCOLOR:
//       return PageRouteBuilder(
//         settings: routeSettings,
//         pageBuilder: (context, animation, secondaryAnimation) =>
//         const SelectColorPage(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.ease;
//
//           var tween =
//           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           var offsetAnimation = animation.drive(tween);
//
//           return SlideTransition(
//             position: offsetAnimation,
//             child: child,
//           );
//         },
//       );
//     case AppRoutes.IMAGE_FILTER:
//       return PageRouteBuilder(
//         settings: routeSettings,
//         pageBuilder: (context, animation, secondaryAnimation) =>
//             ImageFilterPage(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.ease;
//
//           var tween =
//           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           var offsetAnimation = animation.drive(tween);
//
//           return SlideTransition(
//             position: offsetAnimation,
//             child: child,
//           );
//         },
//       );
//     case AppRoutes.MODELVIEWERPLUS:
//
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => ModelViewerPage(product :routeSettings.arguments as ProductHive ),
//       );
//
//     default:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const Scaffold(
//           body: Center(
//             child: Text('Screen does not exist!'),
//           ),
//         ),
//       );
//   }
// }
//
// // Map<String, WidgetBuilder> getApplicationRoutes() {
// //   return {
// //     AppRoutes.HOME: (context) => HomeScreen(),
// //     AppRoutes.SEARCH: (context) => ImageFilteringScreen(),
// //     AppRoutes.Flutter3d: (context) => Flutter3dScreen(),
// //     AppRoutes.SPLASH: (context) => const SplashScreen(),
// //     AppRoutes.SIGNIN: (context) => const SplashScreen(),
// //     AppRoutes.MODELVIEWERPLUS: (context) => const ModelViewer(
// //           backgroundColor: Colors.greenAccent,
// //           src: 'assets/models/3072_0705_3.glb',
// //           alt: 'A 3D model of an Elliva Chair',
// //           ar: true,
// //           autoRotate: true,
// //           iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
// //           disableZoom: false,
// //         ),
// //     AppRoutes.CHAIRFORM: (context) => const ChairFormPage(),
// //     AppRoutes.IMAGEPREVIEWADD: (context) => ImagePreviewAddFormPage(context),
// //     AppRoutes.SELECTMODEL: (context) => const SelectModelPage(),
// //     AppRoutes.SELECTCOLOR: (context) => const SelectColorPage(),
// //     AppRoutes.IMAGE_FILTER: (context) => ImageFilterPage(),
// //   };
// // }
