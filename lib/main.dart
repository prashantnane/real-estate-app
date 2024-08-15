import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';


// import 'data/migration/fireabseToHive.dart';
// import 'data/models/hive/colorHive.dart';
// import 'data/models/hive/imagePreview.dart';
// import 'data/models/hive/metadata.dart';
// import 'data/models/hive/product.dart';
// import 'data/models/hive/product3DAssetHive.dart';
import 'Ui/login_screen.dart';
import 'data/cubits/auth/auth_cubit.dart';
import 'data/cubits/auth/login_cubit.dart';
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
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: MaterialApp(
        home: LoginScreen(),
        routes: {
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }

}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginInitial) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<LoginCubit>().logout(
                );
              },
            ),
          ],
        ),
        body: Center(child: Text('Welcome!')),
      ),
    );
  }
}
