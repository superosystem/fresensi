import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool oldPassObs = true.obs;
  RxBool newPassObs = true.obs;
  RxBool newPassCObs = true.obs;

  TextEditingController currentPassC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confirmNewPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePassword() async {
    if (currentPassC.text.isNotEmpty && newPassC.text.isNotEmpty && confirmNewPassC.text.isNotEmpty) {
      if (newPassC.text == confirmNewPassC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;
          // checking if the current password is true
          await auth.signInWithEmailAndPassword(email: emailUser, password: currentPassC.text);
          // update password
          await auth.currentUser!.updatePassword(newPassC.text);

          Get.back();
          ToastCustom.successToast('Success', 'Your password has been changed');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            ToastCustom.errorToast('Problem Occurred', 'Current password is wrong');
          } else {
            ToastCustom.errorToast('Problem Occurred', 'Can not update password because : ${e.code}');
          }
        } catch (e) {
          ToastCustom.errorToast('Problem Occurred', 'Error : ${e.toString()}');
          if (kDebugMode) {
            print(e.toString());
          }
        } finally {
          isLoading.value = false;
        }
      } else {
        ToastCustom.errorToast('Problem Occurred', 'New password and confirm password does not match');
      }
    } else {
      ToastCustom.errorToast('Problem Occurred', 'All form must be filled');
    }
  }
}
