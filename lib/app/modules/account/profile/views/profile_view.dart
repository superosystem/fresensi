import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresensi/app/controllers/PageIndexController.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:fresensi/app/data/constants.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:fresensi/app/widgets/convex_appbar_custom.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageIndexC = Get.find<PageIndexController>();

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            // getting user data
            Map<String, dynamic> user = snapshot.data!.data()!;
            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 36),
                // SECTION 1 - profile
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: AppColor.secondarySoft,
                        child: Image.network(
                          (user["avatar"] == null || user['avatar'] == "")
                              ? "$defaultAvatarUrl + ${user['name']}"
                              : user['avatar'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 4),
                      child: Text(
                        user['name'].toString().toUpperCase(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      user["email"],
                      style: TextStyle(color: AppColor.secondarySoft),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // SECTION 2 - menu
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      MenuTile(
                        onTap: () =>
                            Get.toNamed(Routes.UPDATE_PROFILE, arguments: user),
                        icon: SvgPicture.asset(
                          'assets/icons/profile-1.svg',
                        ),
                        title: 'Change Profile',
                      ),
                      MenuTile(
                        onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                        icon: SvgPicture.asset(
                          'assets/icons/password.svg',
                        ),
                        title: 'Change Password',
                      ),
                      (user['role'] == 'admin')
                          ? MenuTile(
                              onTap: () => Get.toNamed(Routes.ADD_EMPLOYEE),
                              icon: SvgPicture.asset(
                                'assets/icons/people.svg',
                              ),
                              title: 'New Employee',
                            )
                          : const SizedBox(),
                      MenuTile(
                        onTap: () async {
                          await controller.logout();
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/logout.svg',
                        ),
                        title: 'Logout',
                      ),
                      Container(
                        height: 1,
                        color: AppColor.primaryExtraSoft,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("Can not found."));
          }
        },
      ),
      extendBody: true,
      bottomNavigationBar: ConvexAppBarCustom(pageIndexC.pageIndex.value),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;

  const MenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColor.secondaryExtraSoft,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: const EdgeInsets.only(right: 24),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft,
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:
                      (isDanger == false) ? AppColor.secondary : AppColor.error,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                colorFilter: ColorFilter.mode(
                    (isDanger == false) ? AppColor.secondary : AppColor.error,
                    BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
