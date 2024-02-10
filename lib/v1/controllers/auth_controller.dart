import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vybe/v1/utils/typography.dart';

class AuthController extends GetxController {
  final _userCredential = FirebaseAuth.instance;

  // create a getter stream
  Stream<User?> get onAuthStateChanged => _userCredential.authStateChanges();

  ///guest login using annonymous login by firebase
  guestLogin(context) async {
    try {
      await _userCredential.signInAnonymously();
      print("Signed in with temporary account.");

    } on FirebaseAuthException catch (e) {
            showDialog(context: context, builder: (context){
        return Dialog(
          child: Column(
            children: [
              paragraph(text: e.code)
            ],
          ),
        );
      });
      switch (e.code) {
        
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  guestLogout() {
    try {
      _userCredential.signOut();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }
}
