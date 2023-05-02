import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      try {
        // signIn with email and password
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passwordC.text,
        );
        // check user credential
        if(userCredential.user != null) {
          if(userCredential.user!.emailVerified == true) {
            // Route to home
            Get.offAllNamed(Routes.HOME);
          }else{
            Get.defaultDialog(
              title: "Account need verification",
              middleText: "You should verify that email."
            );
          }
        }

      } on FirebaseAuthException catch (err) {
        if (err.code == 'user-not-found') {
          if (kDebugMode) {
            print("No user found for that email.");
          }
          Get.snackbar("Problem occurred", "Email is not registered");
        } else if (err.code == 'wrong-password') {
          if (kDebugMode) {
            print("Wrong password provided for that user.");
          }
          Get.snackbar(
              "Problem occurred", "Wrong password provided for that user");
        }
      }
    } else {
      Get.snackbar("Problem occurred", "All fields can not be empty");
    }
  }
}
