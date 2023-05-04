import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;

  final Map<String, dynamic> user = Get.arguments;
  final ImagePicker picker = ImagePicker();
  XFile? image;

  TextEditingController idC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
    idC.text = user['id'];
    nameC.text = user['name'];
    emailC.text = user['email'];
    jobC.text = user['job'];
  }

  Future<void> updateProfile() async {
    // get uid user
    String uid = auth.currentUser!.uid;

    if (idC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        // update data
        Map<String, dynamic> data = {
          'name': nameC.text,
          'job': jobC.text,
        };
        if (image != null) {
          // upload avatar image to storage
          File file = File(image!.path);
          String ext = image!.name.split('.').last;
          String upDir = '$uid/avatar.$ext';
          // on upload avatar
          await storage.ref(upDir).putFile(file);
          String avatarUrl = await storage.ref(upDir).getDownloadURL();

          data.addAll({'avatar': avatarUrl});
        }

        // on update data
        await firestore.collection('employee').doc(uid).update(data);

        image = null;
        Get.back();
        ToastCustom.successToast('Success', 'Profile has been changed');
      } catch (e) {
        ToastCustom.errorToast('Problem Occurred', 'Can not update profile');
        if (kDebugMode) {
          print('ERROR: ${e.toString()}');
        }
      } finally {
        isLoading.value = false;
      }
    }else{
      ToastCustom.errorToast('Problem Occurred', 'You must fill all form');
    }
  }

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kDebugMode) {
        print(image!.path);
      }
      if (kDebugMode) {
        print(image!.name.split('.').last);
      }
    }
    update();
  }

  void deleteAvatar() async {
    String uid = auth.currentUser!.uid;
    try {
      await firestore.collection('employee').doc(uid).update({
        'avatar': FieldValue.delete(),
      });
      Get.back();

      Get.snackbar('Success', 'Account has been deleted');
    } catch (e) {
      Get.snackbar(
          'Problem Occurred', 'Can not delete avatar. Karena ${e.toString()}');
    } finally {
      update();
    }
  }
}
