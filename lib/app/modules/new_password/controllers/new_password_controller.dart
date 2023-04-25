import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/controllers/page_index_controller.dart';
import 'package:fresensi/app/data/company_data.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:fresensi/widgets/toast/custom_toast.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  final pageIndexController = Get.put(PageIndexController());

  TextEditingController passC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();

  RxBool newPassObs = true.obs;
  RxBool newPassCObs = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (passC.text.isNotEmpty && confirmPassC.text.isNotEmpty) {
      if (passC.text == confirmPassC.text) {
        isLoading.value = true;
        if (passC.text != CompanyData.defaultPassword) {
          _updatePassword();
          isLoading.value = false;
        } else {
          CustomToast.errorToast('ERROR', 'You must change your password');
          isLoading.value = false;
        }
      } else {
        CustomToast.errorToast('ERROR', 'Password does not match');
      }
    } else {
      CustomToast.errorToast('ERROR', 'You must fill all form');
    }
  }

  void _updatePassword() async {
    try {
      String email = auth.currentUser!.email!;
      await auth.currentUser!.updatePassword(passC.text);
      // re-login
      await auth.signOut();
      await auth.signInWithEmailAndPassword(email: email, password: passC.text);
      Get.offAllNamed(Routes.home);

      pageIndexController.changePage(0);
      CustomToast.successToast('SUCCESS', 'Success update password');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomToast.errorToast(
            'ERROR', 'Password too weak, you need at least six characters');
      }
    } catch (e) {
      CustomToast.errorToast('ERROR', 'Such error : ${e.toString()}');
    }
  }
}
