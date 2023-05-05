import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presence_controller.dart';

class DetailPresenceView extends GetView<DetailPresenceController> {
  final Map<String, dynamic> presenceData = Get.arguments;

  DetailPresenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DETAIL PRESENCE',
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
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          // CHECKING
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: AppColor.success,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.success, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Check In',
                          style: TextStyle(color: AppColor.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          (presenceData["in"] == null)
                              ? "-"
                              : DateFormat.jm().format(
                                  DateTime.parse(presenceData["in"]["date"])),
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // PRESENCE DATE
                    Text(
                      DateFormat.yMMMMEEEEd()
                          .format(DateTime.parse(presenceData["date"])),
                      style: TextStyle(color: AppColor.white),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Status',
                  style: TextStyle(color: AppColor.white),
                ),
                const SizedBox(height: 4),
                Text(
                  'Outside area presence',
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                Text(
                  'Address',
                  style: TextStyle(color: AppColor.white),
                ),
                const SizedBox(height: 4),
                Text(
                  (presenceData["in"] == null)
                      ? "-"
                      : "${presenceData["in"]["address"]}",
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // CHECKOUT
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.error, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Check out',
                          style: TextStyle(color: AppColor.secondary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          (presenceData["out"] == null)
                              ? "-"
                              : DateFormat.jm().format(
                                  DateTime.parse(presenceData["out"]["date"])),
                          style: TextStyle(
                              color: AppColor.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      DateFormat.yMMMMEEEEd()
                          .format(DateTime.parse(presenceData["date"])),
                      style: TextStyle(color: AppColor.secondary),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Status',
                  style: TextStyle(color: AppColor.secondary),
                ),
                const SizedBox(height: 4),
                Text(
                  (presenceData["out"]?["in_area"] == true)
                      ? "In area presence"
                      : "Outside area presence",
                  style: TextStyle(
                      color: AppColor.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                Text(
                  'Address',
                  style: TextStyle(color: AppColor.secondary),
                ),
                const SizedBox(height: 4),
                Text(
                  (presenceData["out"] == null)
                      ? "-"
                      : "${presenceData["out"]["address"]}",
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
