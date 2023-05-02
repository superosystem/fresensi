import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/data/constants.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:get/get.dart';

class AddEmployeeController extends GetxController {
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
      Get.defaultDialog(
        title: "Admin validation",
        content: Column(
          children: [
            const Text("Type admin password!"),
            TextField(
              autocorrect: false,
              obscureText: true,
              controller: passwdAdminC,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await onAddEmployee();
            },
            child: const Text("SUBMIT"),
          ),
        ],
      );
    } else {
      ToastCustom.errorToast("Problem occurred", "All fields can not be empty");
    }
  }

  Future<void> onAddEmployee() async {
    if (passwdAdminC.text.isNotEmpty) {
      // registration auth to firebase
      try {
        String emailAdmin = auth.currentUser!.email!;

        // admin getting for authentication firebase
        UserCredential adminCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailAdmin,
          password: passwdAdminC.text,
        );

        // register user to authentication firebase
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: defaultPasswordUser,
        );
        // getting credential user.
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          // store to fire store (employee)
          firestore.collection("employee").doc(uid).set({
            "id": idC.text,
            "name": nameC.text,
            "email": emailC.text,
            "uid": uid,
            "created_at": DateTime.now().toIso8601String(),
          });
          // send email verification
          await userCredential.user!.sendEmailVerification();

          // sign out
          await auth.signOut();
          // re-login
          // admin getting for authentication firebase
          UserCredential adminCredential =
              await auth.createUserWithEmailAndPassword(
            email: emailAdmin,
            password: passwdAdminC.text,
          );

          Get.back(); // close dialog
          Get.back(); // back to home
          ToastCustom.successToast("Success", "New Employee has been added");
        }
      } on FirebaseAuthException catch (err) {
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
          ToastCustom.errorToast("Problem occurred", "Password is does not match");
        } else {
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
