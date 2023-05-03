import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/data/constants.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        // signIn with email and password
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passwordC.text,
        );
        // check user credential
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            // check password should not use default password
            if (passwordC.text == defaultPasswordUser) {
              // route new password
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              // Route to home
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Account need verification",
              middleText: "You should verify that email.",
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // send email verification
                      await userCredential.user!.sendEmailVerification();
                      Get.back();

                      ToastCustom.successToast("Success", "Email verification has been send");
                      isLoading.value = false;
                    } catch (err) {
                      if (kDebugMode) {
                        print(err.toString());
                      }
                      ToastCustom.errorToast("Problem occurred", "Can not send email verification");
                    }
                  },
                  child: const Text("Verify Email"),
                ),
              ],
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (err) {
        isLoading.value = false;
        if (err.code == 'user-not-found') {
          if (kDebugMode) {
            print("No user found for that email.");
          }
          ToastCustom.errorToast("Problem occurred", "Email is not registered");
        } else if (err.code == 'wrong-password') {
          if (kDebugMode) {
            print("Wrong password provided for that user.");
          }
          ToastCustom.errorToast(
              "Problem occurred", "Wrong password provided for that user");
        }
      }
    } else {
      ToastCustom.errorToast("Problem occurred", "All fields can not be empty");
    }
  }
}
