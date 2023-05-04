import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:fresensi/app/widgets/input_custom.dart';
import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHANGE PROFILE',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile();
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primary,
              ),
              child:
                  Text((controller.isLoading.isFalse) ? 'Done' : 'Loading...'),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          // SECTION 1 - Profile Picture
          // SECTION 2 - Profile User
          InputCustom(
            controller: controller.idC,
            label: "ID",
            hint: "EMP1010101",
            disabled: true,
            margin: const EdgeInsets.only(bottom: 16, top: 42),
          ),
          InputCustom(
            controller: controller.nameC,
            label: "Full Name",
            hint: "Your Full Name",
          ),
          InputCustom(
            controller: controller.emailC,
            label: "Email",
            hint: "agus.kumaha@email.com",
            disabled: true,
          ),
        ],
      ),
    );
  }
}
