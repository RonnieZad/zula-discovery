import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zula/firebase_options.dart';
import 'package:zula/v1/controllers/auth_controller.dart';
import 'package:zula/v1/pager.dart';
import 'package:zula/v1/screens/get_started_page.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    // Ensure that widget binding is initialized before running the app
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    // Preserve the native splash screen until manual removal
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    // Initialize local storage for the app
    await GetStorage.init();

    try {
      await Firebase.initializeApp();
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
      // set observer
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
    } catch (e) {
      print("Failed to initialize Firebase: $e");
    }

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // Lock the device orientation to portrait mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Customize system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Make status bar transparent
          systemNavigationBarColor:
              Color(0xFFFFB6B9), // Set navigation bar color
          systemNavigationBarIconBrightness:
              Brightness.light, // Navigation bar icons' brightness
          statusBarIconBrightness:
              Brightness.light), // Status bar icons' brightness
    );

    runApp(
      const MyApp(),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
  // Run the app
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // add setCurrentScreeninstead of initState because might not always give you the
    // expected results because initState() is called before the widget
    // is fully initialized, so the screen might not be visible yet.
    FirebaseAnalytics.instance.logAppOpen();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return MaterialApp(
      title: 'Zula Vibe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(20, 45, 66, 1)),
        useMaterial3: true,
      ),
      home: ScreenUtilInit(
        designSize: const Size(475, 910),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (c, w) => GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          },
          child: StreamBuilder<User?>(
              stream: authController.onAuthStateChanged,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const AppCanvas();
                } else {
                  return const GetStartedPage();
                }
              }),
        ),
      ),
    );
  }
}
