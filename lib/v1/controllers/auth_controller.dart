import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:zula/v1/services/api_service.dart';
import 'package:zula/v1/utils/typography.dart';

class AuthController extends GetxController {
  final _userCredential = FirebaseAuth.instance;

  // create a getter stream
  Stream<User?> get onAuthStateChanged => _userCredential.authStateChanges();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  var profilePic = ''.obs;
  var phoneNumber = '-'.obs;
  var name = ''.obs;
  var emailAddress = ''.obs;
  var lastSignInDate = ''.obs;

  @override
  onInit() {
    super.onInit();

    profilePic.value = GetStorage().read('profilePic') ?? '';
    phoneNumber.value = GetStorage().read('phoneNumber') ?? '-';
    name.value = GetStorage().read('name') ?? '';
    emailAddress.value = GetStorage().read('emailAddress') ?? '';
    lastSignInDate.value = GetStorage().read('lastSignInDate') ?? '';
  }

  privateServerAuth({required String emailAddress, required String name}) {
    try {
      ApiService.postRequest(
          endPoint: '/account_registration',
          service: Services.authentication,
          body: {
            "role": "client",
            "email_address": emailAddress,
            "password": emailAddress,
            "name": name,
          }).then((response) async {
        if (response['payload']['status'] >= 200 &&
            response['payload']['status'] <= 300) {
          log(response['payload']['data'].toString());

          GetStorage().write('token', response['payload']['token']);
          GetStorage().write('user_id', response['payload']['data']['id']);
          GetStorage().write(
              'user_phone_number', response['payload']['data']['phone_number']);
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        privateServerAuth(emailAddress: user.email!, name: user.displayName!);
        GetStorage().write('profilePic', user.photoURL ?? '');
        GetStorage().write('name', user.displayName ?? '');
        GetStorage().write('phoneNumber', user.phoneNumber ?? '-');
        GetStorage().write('emailAddress', user.email ?? '');
        GetStorage().write(
            'lastSignInDate',
            DateFormat('EEE, MM, yyyy')
                .format(user.metadata.lastSignInTime!)
                .toString());
        profilePic.value = GetStorage().read('profilePic') ?? '';
        phoneNumber.value = GetStorage().read('phoneNumber') ?? '-';
        name.value = GetStorage().read('name') ?? '';
        emailAddress.value = GetStorage().read('emailAddress') ?? '';
        lastSignInDate.value = GetStorage().read('lastSignInDate') ?? '';
      }

      // Use the user object for further operations or navigate to a new screen.
    } catch (e) {
      print(e.toString());
    }
  }

  ///guest login using annonymous login by firebase
  guestLogin(context) async {
    try {
      await _userCredential.signInAnonymously();
      debugPrint("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      print(e);
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
      FirebaseAnalytics.instance.logEvent(name: 'AppSignOut');
      _userCredential.signOut();
      googleSignIn.signOut();
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
