import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late FirebaseAuth auth;

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.login);
  }
}
