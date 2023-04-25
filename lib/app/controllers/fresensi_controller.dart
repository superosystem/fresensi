import 'package:get/get.dart';

class FresensiController extends GetxController {
  RxBool isLoading = false.obs;

  fresensi() async {
    isLoading.value = true;
  }
}
