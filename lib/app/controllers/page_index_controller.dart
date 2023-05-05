import 'package:fresensi/app/controllers/presence_controller.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:get/get.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  final presenceController = Get.put(PresenceController());

  void changePage(int index) async {
    pageIndex.value = index;
    switch (index) {
      case 1:
        presenceController.presence();
        break;
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }
}