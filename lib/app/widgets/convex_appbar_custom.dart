import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/controllers/page_index_controller.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:get/get.dart';

class ConvexAppBarCustom extends GetView<PageIndexController> {
  final pageIndexC = Get.find<PageIndexController>();

  final int index;

  ConvexAppBarCustom(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: AppColor.primary,
      style: TabStyle.fixedCircle,
      items: const [
        TabItem(icon: Icons.home, title: "Home"),
        TabItem(icon: Icons.fingerprint, title: "Attend"),
        TabItem(icon: Icons.person, title: "Profile"),
      ],
      initialActiveIndex: index,
      onTap: (int index) => pageIndexC.changePage(index),
    );
  }
}
