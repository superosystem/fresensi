import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fresensi/app/widgets/dialog_custom.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

class PresenceController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  presence() async {
    isLoading.value = true;
    // Acquire current position of the device
    Map<String, dynamic> determinePosition = await _determinePosition();
    if (!determinePosition['error']) {
      // get position
      Position position = determinePosition["position"];
      if (kDebugMode) {
        print("LAT: ${position.latitude}, LONG: ${position.longitude}");
      }

      // get address from lat and long
      List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      String address = "${placeMarks.first.street}, ${placeMarks.first.subLocality}, ${placeMarks.first.locality} ${placeMarks.first.country}";

      // update location (on fire store)
      await updatePosition(position, address);
      isLoading.value = false;
    }else{
      isLoading.value = false;
      ToastCustom.errorToast("Problem Occurred", determinePosition["message"]);

      if (kDebugMode) {
        print(determinePosition["error"]);
      }
    }
  }

  // update location on fire store
  Future<void> updatePosition(Position position, String address) async {
    String uid = auth.currentUser!.uid;
    await firestore.collection("employee").doc(uid).update({
      "position": {
        "latitude": position.latitude,
        "longitude": position.longitude,
      },
      "address": address,
    });
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
      // return Future.error('Location services are disabled.');
      return {
        "position": null,
        "message": "Location services are disabled",
        "error": true,
      };
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
        // return Future.error('Location permissions are denied');
        return {
          "position": null,
          "message": "Location permissions are denied",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "position": null,
        "message": "Location permissions are permanently denied, we cannot request permissions",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    return {
      "position": position,
      "message": "Get the location of your device",
      "error": false,
    };
  }
}