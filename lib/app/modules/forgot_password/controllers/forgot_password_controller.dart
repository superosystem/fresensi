import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/widgets/toast/custom_toast.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  Future<void> sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      if (kDebugMode) {
        print("called");
      }
      try {
        if (kDebugMode) {
          print("success");
        }
        auth.sendPasswordResetEmail(email: emailC.text);
        Get.back();
        CustomToast.successToast("SUCCESS", "We've send password reset link to your email");
      } catch (e) {
        CustomToast.errorToast("ERROR", "Cant send password reset link to your email. Error because : ${e.toString()}");
      } finally {
        isLoading.value = false;
      }
    } else {
      CustomToast.errorToast("ERROR", "Email must be filled");
    }
  }
}
