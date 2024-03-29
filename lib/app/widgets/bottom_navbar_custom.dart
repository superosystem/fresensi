import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresensi/app/controllers/page_index_controller.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:get/get.dart';

class BottomNavBarCustom extends GetView<PageIndexController> {
  const BottomNavBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 97,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Stack(
        alignment: const FractionalOffset(.5, 1.0),
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.secondaryExtraSoft, width: 1),
                ),
              ),
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(0),
                        child: SizedBox(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: (controller.pageIndex.value == 0)
                                    ? SvgPicture.asset(
                                        'assets/icons/home-active.svg')
                                    : SvgPicture.asset('assets/icons/home.svg'),
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      margin: const EdgeInsets.only(top: 24),
                      alignment: Alignment.center,
                      child: Text(
                        'Presence',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(2),
                        child: SizedBox(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: (controller.pageIndex.value == 2)
                                    ? SvgPicture.asset(
                                        'assets/icons/profile-active.svg')
                                    : SvgPicture.asset(
                                        'assets/icons/profile.svg'),
                              ),
                              Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            child: Obx(
              () => SizedBox(
                width: 64,
                height: 64,
                child: FloatingActionButton(
                  onPressed: () => controller.changePage(1),
                  elevation: 0,
                  child: (controller.presenceController.isLoading.isFalse)
                      ? SvgPicture.asset(
                          'assets/icons/fingerprint.svg',
                          colorFilter:
                              ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: AppColor.white,
                          ),
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
