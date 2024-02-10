import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vybe/firebase_options.dart';
import 'package:vybe/v1/controllers/auth_controller.dart';
import 'package:vybe/v1/pager.dart';
import 'package:vybe/v1/screens/get_started_page.dart';
import 'package:vybe/v1/screens/homepage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return MaterialApp(
      title: 'Zula',
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (snapshot.data == null) {
                    return const GetStartedPage();
                  } else {
                    return const AppCanvas();
                  }
                }
              }),
        ),
      ),
    );
  }
}
