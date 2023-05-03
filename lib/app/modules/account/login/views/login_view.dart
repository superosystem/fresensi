import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 30 / 100,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                gradient: AppColor.primaryGradient,
                image: const DecorationImage(
                  image: AssetImage('assets/images/pattern-1-1.png'),
                  fit: BoxFit.cover,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Open Source\nFresensi App",
                  style: TextStyle(
                      fontSize: 28,
                      color: AppColor.white,
                      fontFamily: 'poppins',
                      height: 150 / 100,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 70 / 100,
            width: MediaQuery.of(context).size.width,
            color: AppColor.white,
            padding: const  EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: TextField(
                    style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                    maxLines: 1,
                    controller: controller.emailC,
                    decoration: InputDecoration(
                      label: Text(
                        "Email",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          fontSize: 14,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      hintText: "agus.kumaha@email.com",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondarySoft,
                      ),
                    ),
                  ),
                ),
                Material(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 1, color: AppColor.secondaryExtraSoft),
                    ),
                    child: Obx(
                      () => TextField(
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'poppins'),
                        maxLines: 1,
                        controller: controller.passwordC,
                        obscureText: controller.obsecureText.value,
                        decoration: InputDecoration(
                          label: Text(
                            "Password",
                            style: TextStyle(
                              color: AppColor.secondarySoft,
                              fontSize: 14,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: InputBorder.none,
                          hintText: "*************",
                          suffixIcon: IconButton(
                            icon: (controller.obsecureText != false)
                                ? SvgPicture.asset('assets/icons/show.svg')
                                : SvgPicture.asset('assets/icons/hide.svg'),
                            onPressed: () {
                              controller.obsecureText.value =
                                  !(controller.obsecureText.value);
                            },
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            color: AppColor.secondarySoft,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        backgroundColor: AppColor.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        (controller.isLoading.isFalse)
                            ? 'Log In'
                            : 'Loading...',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 4),
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColor.secondarySoft
                    ),
                    child: const Text("Forgot your password?"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
