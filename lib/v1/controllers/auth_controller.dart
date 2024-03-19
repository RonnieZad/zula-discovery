import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zula/v1/utils/typography.dart';

class AuthController extends GetxController {
  final _userCredential = FirebaseAuth.instance;

  // create a getter stream
  Stream<User?> get onAuthStateChanged => _userCredential.authStateChanges();

  ///guest login using annonymous login by firebase
  guestLogin(context) async {
    try {
      await _userCredential.signInAnonymously();
      debugPrint("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Column(
                children: [paragraph(text: e.code)],
              ),
            );
          });
      switch (e.code) {
        case "operation-not-allowed":
          debugPrint("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          debugPrint("Unknown error.");
      }
    }
  }

  guestLogout() {
    try {
      FirebaseAnalytics.instance.logEvent(name: 'App Sign out');
      _userCredential.signOut();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          debugPrint("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          debugPrint("Unknown error.");
      }
    }
  }
}
