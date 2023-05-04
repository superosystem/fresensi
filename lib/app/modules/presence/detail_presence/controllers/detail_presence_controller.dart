import 'package:get/get.dart';

class DetailPresenceController extends GetxController {
  DateTime? start;
  DateTime end = DateTime.now();

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;

    update();
    Get.back();
  }
}
