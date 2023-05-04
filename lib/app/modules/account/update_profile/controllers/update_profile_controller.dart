import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;

  final Map<String, dynamic> user = Get.arguments;
  TextEditingController idC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    idC.text = user['id'];
    nameC.text = user['name'];
    emailC.text = user['email'];
  }

  Future<void> updateProfile() async {
    // get uid user
    String uid = auth.currentUser!.uid;

    if (idC.text.isNotEmpty && nameC.text.isNotEmpty && emailC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        // update data
        Map<String, dynamic> data = {
          "name": nameC.text,
        };
        // on update data
        await firestore.collection("employee").doc(uid).update(data);

        Get.back();
        ToastCustom.successToast("Success", "Profile has been changed");
      }catch(e) {
        ToastCustom.errorToast("Problem Occurred", "Can not update profile");
        if (kDebugMode) {
          print("ERROR: ${e.toString()}");
        }
      }finally{
        isLoading.value = false;
      }
      ToastCustom.errorToast("Problem Occurred", "You must fill all form");
    }
  }

}
