import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:fresensi/app/widgets/input_custom.dart';
import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHANGE PASSWORD',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: AppColor.white,
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
          Obx(
            () => InputCustom(
              controller: controller.currentPassC,
              label: 'Old Password',
              hint: '*************',
              obsecureText: controller.oldPassObs.value,
              suffixIcon: IconButton(
                icon: (controller.oldPassObs.value != false)
                    ? SvgPicture.asset('assets/icons/show.svg')
                    : SvgPicture.asset('assets/icons/hide.svg'),
                onPressed: () {
                  controller.oldPassObs.value = !(controller.oldPassObs.value);
                },
              ),
            ),
          ),
          Obx(
            () => InputCustom(
              controller: controller.newPassC,
              label: 'New Password',
              hint: '******************',
              obsecureText: controller.newPassObs.value,
              suffixIcon: IconButton(
                icon: (controller.newPassObs.value != false)
                    ? SvgPicture.asset('assets/icons/show.svg')
                    : SvgPicture.asset('assets/icons/hide.svg'),
                onPressed: () {
                  controller.newPassObs.value = !(controller.newPassObs.value);
                },
              ),
            ),
          ),
          Obx(
            () => InputCustom(
              controller: controller.confirmNewPassC,
              label: 'Confirm New Password',
              hint: '******************',
              obsecureText: controller.newPassCObs.value,
              suffixIcon: IconButton(
                icon: (controller.newPassCObs.value != false)
                    ? SvgPicture.asset('assets/icons/show.svg')
                    : SvgPicture.asset('assets/icons/hide.svg'),
                onPressed: () {
                  controller.newPassCObs.value =
                      !(controller.newPassCObs.value);
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.updatePassword();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  (controller.isLoading.isFalse)
                      ? 'Change Password'
                      : 'Loading...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
