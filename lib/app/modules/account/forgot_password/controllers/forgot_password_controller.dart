import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> resetPassword() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try{
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.back();
        ToastCustom.successToast("Success", "Reset password link has been send to your email");
      }catch(e) {
        if (kDebugMode) {
          print("ERROR: ${e.toString()}");
        }
        ToastCustom.errorToast("Error", "Can not send reset password link to your email");
      }
    }else{
      ToastCustom.errorToast("Problem occurred", "Email can not be empty");
    }
  }
}
