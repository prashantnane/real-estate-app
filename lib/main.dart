// import 'package:amplify_api/amplify_api.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_storage_s3/amplify_storage_s3.dart';
// import 'package:revaugment/utils/constants/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

import 'constants/routes.dart';
// import 'data/migration/fireabseToHive.dart';
// import 'data/models/hive/colorHive.dart';
// import 'data/models/hive/imagePreview.dart';
// import 'data/models/hive/metadata.dart';
// import 'data/models/hive/product.dart';
// import 'data/models/hive/product3DAssetHive.dart';
import 'firebase_options.dart';


void _initHiveDB() async {

  if (!kIsWeb) {
    // final documentsDirectory = await getApplicationDocumentsDirectory();
    // Hive.init(documentsDirectory.path);
  }
}

Future<void> main() async {


  // print(await ArCoreController.checkArCoreAvailability());
  // print('\nAR SERVICES INSTALLED?');
  // print(await ArCoreController.checkIsArCoreInstalled());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) {
    // final documentsDirectory = await getApplicationDocumentsDirectory();
    // Hive.init(documentsDirectory.path);
  }
  // Hive.registerAdapter(ChairHiveAdapter());
  // Hive.registerAdapter(ImagePreviewHiveAdapter());
  // // Hive.registerAdapter(AuditFieldsAdapter());
  // Hive.registerAdapter(ProductHiveAdapter());
  // Hive.registerAdapter(ColorHiveAdapter());
  // Hive.registerAdapter(Product3DAssetAdapter());
  // Hive.registerAdapter(MetadataHiveAdapter());
  // await Hive.openBox<ProductHive>(HiveBoxes.productBox);
  // await Hive.openBox<ImagePreviewHive>(HiveBoxes.imagePreviewBox);
  // await DataMigration().migrateData();
  runApp(
      const MyApp()
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute: AppRoutes.SPLASH,
      // onGenerateRoute: (settings) => generateRoute(settings),
      // routes: getApplicationRoutes(),
    );
  }
}
