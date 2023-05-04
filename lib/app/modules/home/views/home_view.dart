import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/controllers/PageIndexController.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:fresensi/app/widgets/bottom_navbar_custom.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageIndexC = Get.find<PageIndexController>();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: AppColor.primary,
        style: TabStyle.fixedCircle,
        items: const [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.fingerprint, title: "Attend"),
          TabItem(icon: Icons.person, title: "Profile"),
        ],
        initialActiveIndex: pageIndexC.pageIndex.value,
        onTap: (int index) => pageIndexC.changePage(index),
      ),
    );
  }
}
