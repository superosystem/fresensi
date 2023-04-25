import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/data/company_data.dart';
import 'package:fresensi/widgets/dialog/custom_alert_dialog.dart';
import 'package:fresensi/widgets/toast/custom_toast.dart';
import 'package:get/get.dart';

class AddEmployeeController extends GetxController {
  @override
  onClose() {
    idNumberC.dispose();
    nameC.dispose();
    emailC.dispose();
    adminPassC.dispose();
  }

  RxBool isLoading = false.obs;
  RxBool isLoadingCreateEmployee = false.obs;

  TextEditingController idNumberC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController adminPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  String getDefaultPassword() {
    return CompanyData.defaultPassword;
  }

  String getDefaultRole() {
    return CompanyData.defaultRole;
  }

  Future<void> addEmployee() async {
    if (idNumberC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        jobC.text.isNotEmpty) {
      isLoading.value = true;
      CustomAlertDialog.confirmAdmin(
        title: 'CONFIRMATION',
        message:
            'You need to confirm that you are an administrator by input your password',
        onCancel: () {
          isLoading.value = false;
          Get.back();
        },
        onConfirm: () async {
          if (isLoadingCreateEmployee.isFalse) {
            await createEmployeeData();
            isLoading.value = false;
          }
        },
        controller: adminPassC,
      );
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'You need to fill all form');
    }
  }

  createEmployeeData() async {
    if (adminPassC.text.isNotEmpty) {
      isLoadingCreateEmployee.value = true;
      String adminEmail = auth.currentUser!.email!;
      try {
        //checking if the pass is match
        await auth.signInWithEmailAndPassword(
          email: adminEmail,
          password: adminPassC.text,
        );
        //get default password
        String defaultPassword = getDefaultPassword();
        String defaultRole = getDefaultRole();
        // if the password is match, then continue the create user process
        UserCredential employeeCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: defaultPassword,
        );

        if (employeeCredential.user != null) {
          String uid = employeeCredential.user!.uid;
          DocumentReference employee = db.collection("employee").doc(uid);
          await employee.set({
            "employee_id": idNumberC.text,
            "name": nameC.text,
            "email": emailC.text,
            "role": defaultRole,
            "job": jobC.text,
            "created_at": DateTime.now().toIso8601String(),
          });

          // send email verification
          await employeeCredential.user!.sendEmailVerification();

          //need to logout because the current user is changed after adding new user
          auth.signOut();
          // need to re-login to admin account
          await auth.signInWithEmailAndPassword(
            email: adminEmail,
            password: adminPassC.text,
          );

          // clear form
          Get.back(); //close dialog
          Get.back(); //close form screen
          CustomToast.successToast('SUCCESS', 'Success adding employee');

          isLoadingCreateEmployee.value = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingCreateEmployee.value = false;
        if (e.code == 'weak-password') {
          if (kDebugMode) {
            print('The password provided is too weak.');
          }
          CustomToast.errorToast('ERROR', 'Default password too short');
        } else if (e.code == 'email-already-in-use') {
          if (kDebugMode) {
            print('The account already exists for that email.');
          }
          CustomToast.errorToast('ERROR', 'Employee already exist');
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast('ERROR', 'Wrong password');
        } else {
          CustomToast.errorToast('ERROR', 'Such error : ${e.code}');
        }
      } catch (e) {
        isLoadingCreateEmployee.value = false;
        CustomToast.errorToast('ERROR', 'Such error : ${e.toString()}');
      }
    } else {
      CustomToast.errorToast('ERROR', 'You need to input password');
    }
  }
}
