import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresensi/app/modules/add_employee/controllers/add_employee_controller.dart';
import 'package:fresensi/theme/app_color.dart';
import 'package:fresensi/widgets/form/custom_input.dart';
import 'package:get/get.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  const AddEmployeeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Employee',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
          CustomInput(
            controller: controller.idNumberC,
            label: 'Employee ID',
            hint: '1000000001',
            maxLength: 10,
          ),
          CustomInput(
            controller: controller.nameC,
            label: 'Full Name',
            hint: 'John Doe',
          ),
          CustomInput(
            controller: controller.emailC,
            label: 'Email',
            hint: 'agus.kumaha@email.com',
          ),
          CustomInput(
            controller: controller.jobC,
            label: 'Job',
            hint: 'Employee Job',
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.addEmployee();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  (controller.isLoading.isFalse)
                      ? 'Submit'
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
