import 'package:flutter/material.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:fresensi/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PresenceTileCustom extends StatelessWidget {
  final Map<String, dynamic> presenceData;

  const PresenceTileCustom({super.key, required this.presenceData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.DETAIL_PRESENCE, arguments: presenceData),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColor.primaryExtraSoft,
          ),
        ),
        padding: const EdgeInsets.only(left: 24, top: 20, right: 29, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Check In',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      (presenceData["in"] == null) ? "-" : DateFormat.jm().format(DateTime.parse(presenceData["in"]["date"])),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Check Out',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      (presenceData["out"] == null) ? "-" : DateFormat.jm().format(DateTime.parse(presenceData["out"]["date"])),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              DateFormat.yMMMMEEEEd().format(DateTime.parse(presenceData["date"])),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColor.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}