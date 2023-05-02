import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/data/constants.dart';
import 'package:get/get.dart';

class AddEmployeeController extends GetxController {
  TextEditingController idC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addEmployee() async {
    if (idC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      // registration auth to firebase
      try {
        // register to authentication firebase
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: defaultPasswordUser,
        );
        // getting credential user.
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          // store to firestore (employee)
          firestore.collection("employee").doc(uid).set({
            "id": idC.text,
            "name": nameC.text,
            "email": emailC.text,
            "uid": uid,
            "createdAt": DateTime.now().toIso8601String(),
          });
        }

      } on FirebaseAuthException catch (err) {
        if (err.code == 'weak-password') {
          if (kDebugMode) {
            print("The password provided is too weak");
          }
          Get.snackbar("Problem occurred", "The password provided is too weak");
        } else if (err.code == 'email-already-in-use') {
          if (kDebugMode) {
            print('The account already exists for that email');
          }
          Get.snackbar(
              "Problem occurred", "The account already exists for that email");
        }
      }
    } else {
      Get.snackbar("Problem occurred", "All fields can not be empty");
    }
  }
}
