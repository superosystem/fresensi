import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/data/constants.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (passwordC.text.isNotEmpty) {
      if (passwordC.text != defaultPasswordUser) {
        // get email and replace password to auto login
        String email = auth.currentUser!.email!;
        String password = passwordC.text;

        try {
          // update password
          await auth.currentUser!.updatePassword(passwordC.text);
          // sign out
          await auth.signOut();
          // auto login
          await auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (err) {
          if (err.code == 'weak-password') {
            if (kDebugMode) {
              print("The password provided is too weak");
            }
            Get.snackbar(
                "Problem occurred", "The password provided is too weak");
          }
        } catch (err) {
          if (kDebugMode) {
            print("SOME ERROR: $err");
          }
          Get.snackbar("Problem occurred", "Error ");
        }
      } else {
        Get.snackbar("Problem occurred", "Try to use other password");
      }
    } else {
      Get.snackbar("Problem occurred", "New Password field can not be empty");
    }
  }
}
