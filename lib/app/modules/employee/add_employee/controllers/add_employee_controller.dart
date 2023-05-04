import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/data/constants.dart';
import 'package:fresensi/app/widgets/dialog_custom.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:get/get.dart';

class AddEmployeeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateEmployee = false.obs;

  TextEditingController idC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwdAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addEmployee() async {
    if (idC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      DialogAlertCustom.confirmAdmin(
          title: "Admin Confirmation",
          message: "you need to confirm that you are an administrator by inputting your password",
          onConfirm: () async {
            if (isLoadingCreateEmployee.isFalse) {
              await onAddEmployee();
              isLoading.value = false;
            }
          },
          onCancel: () {
            isLoading.value = false;
            Get.back();
          },
          controller: passwdAdminC
      );
    } else {
      isLoading.value = false;
      ToastCustom.errorToast("Problem occurred", "All fields can not be empty");
    }
  }

  Future<void> onAddEmployee() async {
    if (passwdAdminC.text.isNotEmpty) {
      isLoadingCreateEmployee.value = true;
      String emailAdmin = auth.currentUser!.email!;
      // registration auth to firebase
      try {
        // admin getting for authentication firebase
        await auth.signInWithEmailAndPassword(email: emailAdmin, password: passwdAdminC.text);

        // register user to authentication firebase
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: defaultPasswordUser,
        );

        // getting credential user.
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          // store to fire store (employee)
          DocumentReference employee = firestore.collection("employee").doc(uid);
          await employee.set({
            "id": idC.text,
            "name": nameC.text,
            "email": emailC.text,
            "uid": uid,
            "role": defaultRoleUser,
            "avatar": "",
            "created_at": DateTime.now().toIso8601String(),
          });

          // send email verification
          await userCredential.user!.sendEmailVerification();

          // re-login
          // sign out
          await auth.signOut();
          // admin getting for authentication firebase
          await auth.signInWithEmailAndPassword(email: emailAdmin, password: passwdAdminC.text);

          // clearing form
          Get.back(); // close dialog
          Get.back(); // back to home
          ToastCustom.successToast("Success", "New Employee has been added");
          isLoadingCreateEmployee.value = false;
        }
      } on FirebaseAuthException catch (err) {
        isLoadingCreateEmployee.value = false;
        if (err.code == 'weak-password') {
          if (kDebugMode) {
            print("The password provided is too weak");
          }
          ToastCustom.errorToast("Problem occurred", "The password provided is too weak");
        } else if (err.code == 'email-already-in-use') {
          if (kDebugMode) {
            print('The account already exists for that email');
          }
          ToastCustom.errorToast("Problem occurred", "The account already exists for that email");
        } else if (err.code == 'wrong-password') {
          if (kDebugMode) {
            print('Wrong password for that email');
          }
          ToastCustom.errorToast("Problem occurred", "Wrong admin password");
        } else {
          isLoadingCreateEmployee.value = false;
          if (kDebugMode) {
            print('ERROR: $err');
          }
          ToastCustom.errorToast("Problem occurred", "Error");
        }
      }
    } else {
      ToastCustom.errorToast("Problem occurred", "Password admin can not be empty");
    }
  }
}
