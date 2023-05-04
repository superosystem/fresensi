import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fresensi/app/data/constants.dart';
import 'package:fresensi/app/widgets/dialog_custom.dart';
import 'package:fresensi/app/widgets/toast_custom.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      Position position = determinePosition['position'];
      if (kDebugMode) {
        print('LAT: ${position.latitude}, LONG: ${position.longitude}');
      }

      // get address from lat and long
      List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      String address = '${placeMarks.first.street}, ${placeMarks.first.subLocality}, ${placeMarks.first.locality} ${placeMarks.first.country}';
      // get area
      double distance = Geolocator.distanceBetween(areaOffice['latitude'], areaOffice['longitude'], position.latitude, position.longitude);

      // update location (on fire store)
      await _updatePosition(position, address);
      // presence (store to database/ fire store)
      await _onPresence(position, address, distance);
      isLoading.value = false;
    } else {
      isLoading.value = false;
      ToastCustom.errorToast('Problem Occurred', determinePosition['message']);

      if (kDebugMode) {
        print(determinePosition['error']);
      }
    }
  }

  // process presence
  Future<void> _onPresence(Position position, String address, double distance) async {
    String uid = auth.currentUser!.uid;
    String todayDocId =
        DateFormat.yMd().format(DateTime.now()).replaceAll('/', '-');
    // setup presence collection
    CollectionReference<Map<String, dynamic>> presenceCollection = firestore.collection('employee').doc(uid).collection('presence');
    QuerySnapshot<Map<String, dynamic>> snapshotPreference = await presenceCollection.get();

    // check your device in area
    bool inArea = false;
    if (distance <= 200) {
      inArea = true;
    }
    // do presence
    if (snapshotPreference.docs.isEmpty) {
      // CASE: Never do presence -> set check in presence
      _firstPresence(presenceCollection, todayDocId, position, address, distance, inArea);
    } else {
      // CASE: Did presence -> has do presence in/out today?
      DocumentSnapshot<Map<String, dynamic>> todayDoc = await presenceCollection.doc(todayDocId).get();
      // already presence before ( another day ) -> have been check in today or check out?
      if (todayDoc.exists == true) {
        Map<String, dynamic>? dataPresenceToday = todayDoc.data();
        // CASE : already check in
        if (dataPresenceToday?['out'] != null) {
          // CASE : already check in and check out
          ToastCustom.successToast('Success', 'You already check in and check out');
        } else {
          // CASE : already check in and not yet check out ( check out )
          _checkoutPresence(presenceCollection, todayDocId, position, address, distance, inArea);
        }
      } else {
        // case : not yet check in today
        _checkInPresence(presenceCollection, todayDocId, position, address, distance, inArea);
      }
    }
  }

  _checkInPresence(
      CollectionReference<Map<String, dynamic>> presenceCollection,
      String todayDocId,
      Position position,
      String address,
      double distance,
      bool inArea,
      ) async {
    DialogAlertCustom.showPresenceAlert(
      title: 'Are you want to check in?',
      message: 'you need to confirm before you\ncan do presence now',
      onCancel: () => Get.back(),
      onConfirm: () async {
        await presenceCollection.doc(todayDocId).set(
          {
            'date': DateTime.now().toIso8601String(),
            'in': {
              'date': DateTime.now().toIso8601String(),
              'latitude': position.latitude,
              'longitude': position.longitude,
              'address': address,
              'in_area': inArea,
              'distance': distance,
            }
          },
        );
        Get.back();
        ToastCustom.successToast('Success', 'You are check in');
      },
    );
  }

  // CHECK OUT
  _checkoutPresence(
      CollectionReference<Map<String, dynamic>> presenceCollection,
      String todayDocId,
      Position position,
      String address,
      double distance,
      bool inArea,
      ) async {
    DialogAlertCustom.showPresenceAlert(
      title: 'Are you want to check out?',
      message: 'You need to confirm before you\ncan do presence now!',
      onCancel: () => Get.back(),
      onConfirm: () async {
        await presenceCollection.doc(todayDocId).update(
          {
            'out': {
              'date': DateTime.now().toIso8601String(),
              'latitude': position.latitude,
              'longitude': position.longitude,
              'address': address,
              'in_area': inArea,
              'distance': distance,
            }
          },
        );
        Get.back();
        ToastCustom.successToast('Success', 'You are check out');
      },
    );
  }

  // first presence
  void _firstPresence(
      CollectionReference<Map<String, dynamic>> presenceCollection,
      String todayDocId,
      Position position,
      String address,
      double distance,
      bool inArea,
      ) async {
    DialogAlertCustom.showPresenceAlert(
      title: 'Are you want to check in?',
      message: 'You need to confirm before you can do presence now!',
      onCancel: () => Get.back(),
      onConfirm: () async {
        await presenceCollection.doc(todayDocId).set(
          {
            'date': DateTime.now().toIso8601String(),
            'in': {
              'date': DateTime.now().toIso8601String(),
              'latitude': position.latitude,
              'longitude': position.longitude,
              'address': address,
              'in_area': inArea,
              'distance': distance,
            }
          },
        );
        Get.back();
        ToastCustom.successToast('Success', 'You are check in');
      },
    );
  }

  // update location on fire store
  Future<void> _updatePosition(Position position, String address) async {
    String uid = auth.currentUser!.uid;
    await firestore.collection('employee').doc(uid).update({
      'position': {
        'latitude': position.latitude,
        'longitude': position.longitude,
      },
      'address': address,
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
        'position': null,
        'message': 'Location services are disabled',
        'error': true,
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
          'position': null,
          'message': 'Location permissions are denied',
          'error': true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        'position': null,
        'message':
            'Location permissions are permanently denied, we cannot request permissions',
        'error': true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return {
      'position': position,
      'message': 'Get the location of your device',
      'error': false,
    };
  }
}
