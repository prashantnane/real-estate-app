import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:real_estate_app/extension/sized_box_extensions.dart';

import '../constants/routes.dart';
import '../utils/themes/app_colors.dart';
import '../widgets/deviceInfo.dart';
import '../widgets/widget_function.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<String> loadingMessages = [
    "Hang tight! We're migrating data securely.",
    "Almost there! Your data is being processed.",
    "Just a moment! We're setting things up for you.",
    "Thanks for your patience!",
    "We'll be done shortly."
  ];
  int currentMessageIndex = 0;
  Timer? timer;
  double progress = 0.0;
  bool dataMigrated = true;

  @override
  void initState() {
    super.initState();
    startTimerForSplash();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      setState(() {
        currentMessageIndex =
            (currentMessageIndex + 1) % loadingMessages.length;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimerForSplash() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Check internet connectivity
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      _showNoInternetDialog();
      return;
    }

    // Perform data migration
    setState(() {
      progress = 0.0;
    });
    // await _migrateData();

    // Navigate based on user authentication and validity
    if (auth.currentUser == null) {
      Navigator.of(context).pushNamed(AppRoutes.SIGNIN);
    } else {
      // Box metadataBox = await Hive.openBox(HiveBoxes.metaData);
      // String? username = auth.currentUser!.email;
      // DateTime? userValidity = metadataBox.get(HiveAttributes.validityLocal);
      // DateTime datetime = DateTime.parse(userValidity.toString());
      // String formattedDate =
      //     "${_twoDigits(datetime.day)}/${_twoDigits(datetime.month)}/${datetime.year}";

      // if (auth.currentUser!.isAnonymous ||
      //     (userValidity ?? DateTime.now()).isBefore(DateTime.now())) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     backgroundColor: AppColors.yellowColor,
      //     content: const Text(
      //         style: TextStyle(color: black),
      //         'User validity expired. Contact Admin!'),
      //   ));
      //   Navigator.of(context).pushNamed(AppRoutes.SIGNIN);
      // } else {
      //   Navigator.of(context).pushNamed(
      //     AppRoutes.HOME,
      //     arguments: {"name": username ?? "", "validity": formattedDate ?? ""},
      //   );
      // }
    }
  }

  String _twoDigits(int n) {
    return n >= 10 ? "$n" : "0$n";
  }

  // Future<void> _migrateData() async {
  //   await DataMigration().migrateData(
  //     onProgress: (step, totalSteps) {
  //       setState(() {
  //         progress = step / totalSteps;
  //         log('progress done: $progress');
  //       });
  //     },
  //   );
  // }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Internet'),
        content: Text('Please check your internet connection and try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              startTimerForSplash(); // Retry connection and migration
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: DeviceInfo.deviceWidth(),
            height: DeviceInfo.deviceHeight(),
            color: Colors.white,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(DeviceInfo.deviceHeight() * 0.35),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    "assets/image/png/rev_logo_final.png",
                  ),
                ),
                10.kH,
                Text(
                  'Welcome To RevAugment',
                  style: TextStyle(
                      fontSize: 24, color: dark, fontWeight: FontWeight.bold),
                ),
                10.kH,
                dataMigrated
                    ? AnimatedSwitcher(
                        duration: Duration(seconds: 1),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(scale: animation, child: child);
                        },
                        child: Text(
                          loadingMessages[currentMessageIndex],
                          key: ValueKey<int>(currentMessageIndex),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              color: darkGrey,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : const SizedBox(),
                5.kH,
                dataMigrated
                    ? SizedBox(
                        width: screenWidth <= 600 ? 250 : 300,
                        height: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: LinearProgressIndicator(
                            backgroundColor: lightGrey,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.blueColor),
                            value: progress,
                          ),
                        ),
                      )
                    : const SizedBox(),
                30.kH,
                dataMigrated
                    ? Text(
                        'Please do not turn off the Internet',
                        style: TextStyle(fontSize: 12),
                      )
                    : SizedBox(),
                addVerticalSpace(50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
