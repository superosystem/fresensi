import 'package:fresensi/app/controllers/fresensi_controller.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class PageIndexController extends GetxController {
  final fresensiController = Get.put(FresensiController());
  RxInt pageIndex = 0.obs;

  void changePage(int index) async {
    pageIndex.value = index;
    switch (index) {
      case 1:
        fresensiController.fresensi();
        break;
      case 2:
        Get.offAllNamed(Routes.profile);
        break;
      default:
        Get.offAllNamed(Routes.home);
        break;
    }
  }
}
