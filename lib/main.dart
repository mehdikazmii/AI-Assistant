import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'apis/app_write.dart';
import 'helper/ad_helper.dart';
import 'helper/global.dart';
import 'helper/pref.dart';
import 'screen/splash_screen.dart';
import 'screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive
  await Pref.initialize();

  // for app write initialization
  AppWrite.init();

  // for initializing facebook ads sdk
  AdHelper.init();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AI Assistant',
      debugShowCheckedModeBanner: false,
      themeMode: Pref.defaultTheme,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.teal,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ), // Change AppBar text color to white
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.teal),
          bodyMedium: TextStyle(color: Colors.teal),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.teal,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20), // Change AppBar text color to white
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

extension AppTheme on ThemeData {
  //light text color
  Color get lightTextColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black54;

  //button color
  Color get buttonColor => brightness == Brightness.dark
      ? Colors.cyan.withOpacity(.5)
      : Colors.teal; // Change button color to teal
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';

// import 'apis/app_write.dart';
// import 'helper/ad_helper.dart';
// import 'helper/global.dart';
// import 'helper/pref.dart';
// import 'screen/splash_screen.dart';
// import 'screen/home_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // init hivew
//   await Pref.initialize();

//   // for app write initialization
//   AppWrite.init();

//   // for initializing facebook ads sdk
//   AdHelper.init();

//   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   await SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'AI Assistant',
//       debugShowCheckedModeBanner: false,
//       themeMode: Pref.defaultTheme,
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: const AppBarTheme(
//           color: Colors.teal,
//           iconTheme: IconThemeData(color: Colors.white),
//         ),
//         floatingActionButtonTheme: const FloatingActionButtonThemeData(
//           backgroundColor: Colors.teal,
//           foregroundColor: Colors.white,
//         ),
//         textTheme: const TextTheme(
//           bodyLarge: TextStyle(color: Colors.teal),
//           bodyMedium: TextStyle(color: Colors.teal),
//         ),
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         primarySwatch: Colors.teal,
//         scaffoldBackgroundColor: Colors.black,
//         appBarTheme: const AppBarTheme(
//           color: Colors.teal,
//           iconTheme: IconThemeData(color: Colors.white),
//         ),
//         floatingActionButtonTheme: const FloatingActionButtonThemeData(
//           backgroundColor: Colors.teal,
//           foregroundColor: Colors.white,
//         ),
//         textTheme: const TextTheme(
//           bodyLarge: TextStyle(color: Colors.white),
//           bodyMedium: TextStyle(color: Colors.white),
//         ),
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

// extension AppTheme on ThemeData {
//   //light text color
//   Color get lightTextColor =>
//       brightness == Brightness.dark ? Colors.white70 : Colors.black54;

//   //button color
//   Color get buttonColor =>
//       brightness == Brightness.dark ? Colors.cyan.withOpacity(.5) : Colors.blue;
// }
