import 'package:flutter/material.dart';
import 'package:fresensi/app/modules/home/controllers/home_controller.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fresensi'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.addEmployee),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Und3r_C0nsTr4ct!on',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.logout;

        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
