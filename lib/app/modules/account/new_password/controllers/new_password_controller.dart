import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/data/constants.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool newPassObs = true.obs;
  RxBool newPassCObs = true.obs;

  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (passwordC.text.isNotEmpty && confirmPassC.text.isNotEmpty) {
      if (passwordC.text == confirmPassC.text) {
        isLoading.value = true;
        if (passwordC.text != defaultPasswordUser) {
          _onUpdatePassword();
          isLoading.value = false;
        } else {
          ToastCustom.errorToast(
              "Problem occurred", "You must change your password");
          isLoading.value = false;
        }
      } else {
        ToastCustom.errorToast("Problem occurred", "Password does not match");
      }
    } else {
      ToastCustom.errorToast("Problem occurred", "New Password field can not be empty");
    }
  }

  void _onUpdatePassword() async {
    try {
      // get email and replace password to auto login
      String email = auth.currentUser!.email!;
      String password = passwordC.text;
      // update password
      await auth.currentUser!.updatePassword(passwordC.text);
      // sign out
      await auth.signOut();
      // auto login / re-login
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.offAllNamed(Routes.HOME);
      ToastCustom.successToast("Success", "Password has been changed");
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        if (kDebugMode) {
          print("The password provided is too weak");
        }
        ToastCustom.errorToast("Problem occurred", "The password too weak, you need at least six characters");
      }
    } catch (err) {
      if (kDebugMode) {
        print("SOME ERROR: $err");
      }
      ToastCustom.errorToast("Problem occurred", "Error ");
    }
  }
}
