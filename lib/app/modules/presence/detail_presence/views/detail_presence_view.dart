import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:fresensi/app/widgets/presence_tile_custom.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/detail_presence_controller.dart';

class DetailPresenceView extends GetView<DetailPresenceController> {
  const DetailPresenceView({Key? key}) : super(key: key);

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
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.secondaryExtraSoft, width: 1),
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
                          "08:00 AM",
                          style: TextStyle(color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // PRESENCE DATE
                    Text(
                      "Wed, Mei 4 2025",
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
                  "Outside area presence",
                  style: TextStyle(color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                Text(
                  'Address',
                  style: TextStyle(color: AppColor.white),
                ),
                const SizedBox(height: 4),
                Text(
                 "Stasiun Luar Angkasa",
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
              border: Border.all(color: AppColor.primary, width: 1),
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
                          "05:00 PM",
                          style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      "Wed, Mei 4 2023",
                      style: TextStyle(color: AppColor.secondary),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'status',
                  style: TextStyle(color: AppColor.secondary),
                ),
                const SizedBox(height: 4),
                Text(
                  "Outside area presence",
                  style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                Text(
                  'Address',
                  style: TextStyle(color: AppColor.secondary),
                ),
                const SizedBox(height: 4),
                Text(
                  "Stasiun Luar Angkasa",
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
