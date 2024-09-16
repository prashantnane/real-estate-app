import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/Ui/profile_screen.dart';
import 'package:real_estate_app/Ui/widgets/blur_page_route.dart';
import 'package:real_estate_app/utils/Extensions/extensions.dart';
import 'package:real_estate_app/utils/responsiveSize.dart';

import '../app/app_theme.dart';
import '../app/routes.dart';
import '../data/cubits/auth/login_cubit.dart';
import '../data/cubits/system/app_theme_cubit.dart';
import '../utils/AppIcon.dart';
import '../utils/constant.dart';
import '../utils/hive_utils.dart';
import '../utils/ui_utils.dart';
import 'AddPropertyScreen.dart';
import 'MyPropertiesScreen.dart';
import 'chat_screen.dart';
import 'home_screen.dart';

List<int> navigationStack = [0];


ScrollController homeScreenController = ScrollController();
ScrollController chatScreenController = ScrollController();
ScrollController sellScreenController = ScrollController();
ScrollController rentScreenController = ScrollController();
ScrollController profileScreenController = ScrollController();

List<ScrollController> controllerList = [
  homeScreenController,
  chatScreenController,
  // if (propertyScreenCurrentPage == 0) ...[
  //   sellScreenController
  // ] else ...[
  //   rentScreenController
  // ],
  profileScreenController
];

class MainActivity extends StatefulWidget {
  @override
  State<MainActivity> createState() => _MainActivityState();

  static Route route(RouteSettings routeSettings) {
    return BlurredRouter(
        builder: (_) => MainActivity());
  }
}

class _MainActivityState extends State<MainActivity> {
  // String name = (HiveUtils.getUserDetails().name) ?? "";
  int currtab = 0;
  final List _pageHistory = [];
  late PageController pageCntrlr;
  DateTime? currentBackPressTime;

  @override
  void dispose() {
    pageCntrlr.dispose();
    super.dispose();
  }

  late List<Widget> pages = [
    HomeScreen(),
    const ChatListScreen(),
    const AddPropertyScreen(),
    const MyPropertiesScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPageController();
  }

  void addHistory(int index) {
    List<int> stack = navigationStack;
    // if (stack.length > 5) {
    //   stack.removeAt(0);
    // } else {
    if (stack.last != index) {
      stack.add(index);
      navigationStack = stack;
    }

    setState(() {});
  }

  void initPageController() {
    print('inside initPageController');
    pageCntrlr = PageController(initialPage: 0)
      ..addListener(() {
        _pageHistory.insert(0, pageCntrlr.page);
      });
  }

  @override
  Widget build(BuildContext context) {
    return
      // BlocListener<LoginCubit, LoginState>(
      // listener: (context, state) {
      //   if (state is LoginInitial) {
      //     Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
      //   }
      // },
      // child:
      // AnnotatedRegion(
      //   value: SystemUiOverlayStyle(
      //       systemNavigationBarDividerColor: Colors.transparent,
      //       // systemNavigationBarColor: Theme.of(context).colorScheme.secondaryColor,
      //       systemNavigationBarIconBrightness:
      //       context.watch<AppThemeCubit>().state.appTheme == AppTheme.dark
      //           ? Brightness.light
      //           : Brightness.dark,
      //       //
      //       statusBarColor: Theme.of(context).colorScheme.secondaryColor,
      //       statusBarBrightness:
      //       context.watch<AppThemeCubit>().state.appTheme == AppTheme.dark
      //           ? Brightness.dark
      //           : Brightness.light,
      //       statusBarIconBrightness:
      //       context.watch<AppThemeCubit>().state.appTheme == AppTheme.dark
      //           ? Brightness.light
      //           : Brightness.dark),
      //   child: WillPopScope(
      //     onWillPop: () async {
      //       ///Navigation history
      //       print('this is pageCntrlr: $pageCntrlr');
      //       print('this is pages: $pages');
      //       int length = navigationStack.length;
      //       if (length == 1 && navigationStack[0] == 0) {
      //         DateTime now = DateTime.now();
      //         if (currentBackPressTime == null ||
      //             now.difference(currentBackPressTime!) >
      //                 const Duration(seconds: 2)) {
      //           currentBackPressTime = now;
      //           // Fluttertoast.showToast(
      //           //   msg: "pressAgainToExit".translate(context),
      //           // );
      //           return Future.value(false);
      //         }
      //       } else {
      //         //This will put our page on previous page.
      //         int secondLast = navigationStack[length - 2];
      //         navigationStack.removeLast();
      //         pageCntrlr.jumpToPage(secondLast);
      //         setState(() {});
      //         return false;
      //       }
      //
      //       return Future.value(true);
      //     },
      //     child:
    Scaffold(
            backgroundColor: context.color.primaryColor,
            bottomNavigationBar:
               bottomBar(),
            body: Stack(
              children: <Widget>[
                PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageCntrlr,
                  // onPageChanged: onItemSwipe,
                  children: pages,
                ),
                // if (Constant.maintenanceMode == "1")
                  Container(
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                SizedBox(
                  width: double.infinity,
                  height: context.screenHeight,
                  child: Stack(
                    children: [
                      // AnimatedBuilder(
                      //     animation: _forRentController,
                      //     builder: (context, c) {
                      //       return Positioned(
                      //         bottom: _rentTween.value,
                      //         left: (context.screenWidth / 2) - (181 / 2),
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             GuestChecker.check(onNotGuest: () {
                      //               Constant.addProperty.addAll(
                      //                   {"propertyType": PropertyType.rent});
                      //               Navigator.pushNamed(
                      //                 context,
                      //                 AppRoutes.addCustomerScreen,
                      //               );
                      //             });
                      //           },
                      //           child: Container(
                      //               width: 181,
                      //               height: 44,
                      //               decoration: BoxDecoration(
                      //                   border: Border.all(
                      //                     color: context.color.borderColor,
                      //                     width: 1.5,
                      //                   ),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: context.color.teritoryColor
                      //                           .withOpacity(0.4),
                      //                       offset: const Offset(0, 3),
                      //                       blurRadius: 10,
                      //                       spreadRadius: 0,
                      //                     )
                      //                   ],
                      //                   color: context.color.teritoryColor,
                      //                   borderRadius:
                      //                       BorderRadius.circular(22)),
                      //               alignment: Alignment.center,
                      //               child: Row(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 children: [
                      //                   // UiUtils.getSvg(AppIcons.forRent),
                      //                   Icon(
                      //                     Icons.person_add_alt_1,
                      //                     color: Colors.white,
                      //                     size: 22,
                      //                   ),
                      //                   SizedBox(
                      //                     width: 7.rw(context),
                      //                   ),
                      //                   Text(UiUtils.getTranslatedLabel(
                      //                           context, "For Customer"))
                      //                       .color(context.color.buttonColor),
                      //                 ],
                      //               )),
                      //         ),
                      //       );
                      //     }),
                      // AnimatedBuilder(
                      //     animation: _forSellAnimationController,
                      //     builder: (context, c) {
                      //       return Positioned(
                      //         bottom: _sellTween.value,
                      //         left: (context.screenWidth / 2) - 128 / 2,
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             GuestChecker.check(onNotGuest: () {
                      //               Constant.addProperty.addAll(
                      //                 {
                      //                   "propertyType": PropertyType.sell,
                      //                 },
                      //               );
                      //
                      //               Navigator.pushNamed(
                      //                 context,
                      //                 Routes.selectPropertyTypeScreen,
                      //               );
                      //             });
                      //           },
                      //           child: Container(
                      //             width: 128,
                      //             height: 44,
                      //             decoration: BoxDecoration(
                      //                 border: Border.all(
                      //                   color: context.color.borderColor,
                      //                   width: 1.5,
                      //                 ),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: context.color.teritoryColor
                      //                         .withOpacity(0.4),
                      //                     offset: const Offset(0, 3),
                      //                     blurRadius: 10,
                      //                     spreadRadius: 0,
                      //                   )
                      //                 ],
                      //                 color: context.color.teritoryColor,
                      //                 borderRadius: BorderRadius.circular(22)),
                      //             alignment: Alignment.center,
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 // UiUtils.getSvg(AppIcons.forSale),
                      //                 Icon(
                      //                   Icons.sell,
                      //                   color: Colors.white,
                      //                   size: 20,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 7.rw(context),
                      //                 ),
                      //                 Text(UiUtils.getTranslatedLabel(
                      //                         context, "forSell"))
                      //                     .color(context.color.buttonColor),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     }),
                    ],
                  ),
                )
              ],
            ),
          );
      //   ),
      // );
    // );
  }

  void onItemTapped(int index) {
    currtab = index;
    pageCntrlr.jumpToPage(currtab);
    setState(() {});
  }
  // void onItemSwipe(int index) {
  //   addHistory(index);
  //
  //   if (index == 0) {
  //     FirebaseAnalytics.instance
  //         .setCurrentScreen(screenName: AnalyticsRoutes.home);
  //   } else if (index == 1) {
  //     FirebaseAnalytics.instance
  //         .setCurrentScreen(screenName: AnalyticsRoutes.chatList);
  //   } else if (index == 3) {
  //     FirebaseAnalytics.instance
  //         .setCurrentScreen(screenName: AnalyticsRoutes.properties);
  //   } else if (index == 4) {}
  //   FocusManager.instance.primaryFocus?.unfocus();
  //   isReverse?.value = true;
  //   _forSellAnimationController.reverse();
  //   _forRentController.reverse();
  //
  //   if (index != 1) {
  //     context.read<SearchPropertyCubit>().clearSearch();
  //
  //     if (SearchScreenState.searchController.hasListeners) {
  //       SearchScreenState.searchController.text = "";
  //     }
  //   }
  //   searchbody = {};
  //   setState(() {
  //     currtab = index;
  //   });
  //   pageCntrlr.jumpToPage(currtab);
  // }

  BottomAppBar bottomBar() {
    return BottomAppBar(
      notchMargin: 0,
      color: context.color.primaryColor,
      shape: const CircularNotchedRectangle(),
      child: Container(
        color: context.color.primaryColor,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildBottomNavigationbarItem(0, AppIcons.home,
                  UiUtils.getTranslatedLabel(context, "homeTab")),
              buildBottomNavigationbarItem(1, AppIcons.chat,
                  UiUtils.getTranslatedLabel(context, "chat")),
              // const SizedBox(
              //   width: 100,
              //   height: 100,
              //   child: RiveAnimation.asset(
              //     "",
              //     artboard: "Add",
              //   ),
              // ),

              // Transform(
              //   transform: Matrix4.identity()..translate(0.toDouble(), -20),
              //   child: GestureDetector(
              //     onTap: () async {
              //       if (isReverse?.value == true) {
              //         isReverse?.value = false;
              //         showSellRentButton = true;
              //         _forRentController.forward();
              //         _forSellAnimationController.forward();
              //       } else {
              //         showSellRentButton = false;
              //         isReverse?.value = true;
              //         _forRentController.reverse();
              //         _forSellAnimationController.reverse();
              //       }
              //       // setState(() {});
              //     },
              //     child: SizedBox(
              //         width: 60.rw(context),
              //         height: 66,
              //         child: artboard == null
              //             ? Container()
              //             : Rive(artboard: artboard!)),
              //   ),
              // ),

              buildBottomNavigationbarItem(3, AppIcons.properties,
                  UiUtils.getTranslatedLabel(context, "properties")),
              buildBottomNavigationbarItem(4, AppIcons.profile,
                  UiUtils.getTranslatedLabel(context, "profileTab"))
            ]),
      ),
    );
  }

  Widget buildBottomNavigationbarItem(
      int index,
      String svgImage,
      String title,
      ) {
    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => onItemTapped(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

          UiUtils.getSvg(svgImage, color: currtab == index ? context.color.teritoryColor : context.color.textLightColor),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
          ).color(currtab == index ? context.color.teritoryColor : context.color.textLightColor),
          ],
          ),
        ),
      ),
    );
  }

}