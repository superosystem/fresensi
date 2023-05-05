import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fresensi/app/data/constants.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  Rx isLoading = false.obs;
  RxString officeDistance = "-".obs;
  Timer? timer;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (Get.currentRoute == Routes.HOME) {
        _getDistanceToOffice().then((value) {
          officeDistance.value = value;
        });
      }
    });
  }

  // Get user data
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection('employee').doc(uid).snapshots();
  }

  // Get last presence data
  Stream<QuerySnapshot<Map<String, dynamic>>> streamLastPresence() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("employee")
        .doc(uid)
        .collection("presence")
        .orderBy("date", descending: true)
        .limitToLast(5)
        .snapshots();
  }

  // Get Today Presence data
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTodayPresence() async* {
    String uid = auth.currentUser!.uid;
    String todayDocId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    yield* firestore
        .collection("employee")
        .doc(uid)
        .collection("presence")
        .doc(todayDocId)
        .snapshots();
  }

  // Get device in area
  Future<String> _getDistanceToOffice() async {
    if (kDebugMode) {
      print('Getting in Area');
    }
    Map<String, dynamic> determinePosition = await _determinePosition();
    if (!determinePosition["error"]) {
      Position position = determinePosition["position"];
      double distance = Geolocator.distanceBetween(areaOffice['latitude'],
          areaOffice['longitude'], position.latitude, position.longitude);
      if (distance > 1000) {
        return "${(distance / 1000).toStringAsFixed(2)}km";
      } else {
        return "${distance.toStringAsFixed(2)}m";
      }
    } else {
      return "-";
    }
  }

  // Acquire the current position of the device
  Future<Map<String, dynamic>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Get.rawSnackbar(
        title: 'GPS is off',
        message: 'You need to turn on gps',
        duration: const Duration(seconds: 3),
      );
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return {
          "message":
              "Can not process because you declined the location request",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Location permissions are permanently denied, we cannot request permissions.",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return {
      "position": position,
      "message": "Get your device location",
      "error": false,
    };
  }

  void launchOfficeOnMap() {
    try {
      MapsLauncher.launchCoordinates(
        areaOffice['latitude'],
        areaOffice['longitude'],
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      ToastCustom.errorToast('Problem Occurred', 'Can not open your maps');
    }
  }
}
