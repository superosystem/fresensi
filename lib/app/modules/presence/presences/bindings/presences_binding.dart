import 'package:get/get.dart';

import '../controllers/presences_controller.dart';

class PresencesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresencesController>(
      () => PresencesController(),
    );
  }
}
