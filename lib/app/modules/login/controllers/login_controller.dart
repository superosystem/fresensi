import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/controllers/page_index_controller.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:fresensi/widgets/dialog/custom_alert_dialog.dart';
import 'package:fresensi/widgets/toast/custom_toast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final pageIndexController = Get.put(PageIndexController());
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  checkDefaultPassword() {
    if (passC.text == 'passwd123') {
      Get.toNamed(Routes.newPassword);
    } else {
      Get.offAllNamed(Routes.home);
      pageIndexController.changePage(0);
    }
  }

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
          email: emailC.text.trim(),
          password: passC.text,
        );

        if (credential.user != null) {
          if (credential.user!.emailVerified) {
            isLoading.value = false;
            checkDefaultPassword();
          } else {
            CustomAlertDialog.showFresensiAlert(
              title: "Email not yet verified",
              message: "Are you want to send email verification?",
              onCancel: () => Get.back(),
              onConfirm: () async {
                try {
                  await credential.user!.sendEmailVerification();
                  Get.back();
                  CustomToast.successToast(
                      "SUCCESS", "We've send email verification to your email");
                  isLoading.value = false;
                } catch (e) {
                  CustomToast.errorToast("Error",
                      "Cant send email verification. Error because : ${e.toString()}");
                }
              },
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          CustomToast.errorToast("Error", "Account not found");
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast("ERROR", "Wrong Password");
        }
      } catch (e) {
        CustomToast.errorToast("ERROR", "Error because : ${e.toString()}");
      }
    } else {
      CustomToast.errorToast(
          "ERROR", "You need to fill email and password form");
    }
  }
}
