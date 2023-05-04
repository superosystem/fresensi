import 'package:flutter/material.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PresenceTileCustom extends StatelessWidget {

  const PresenceTileCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
        padding: EdgeInsets.only(left: 24, top: 20, right: 29, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check In",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "12:00",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check Out",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "12:00",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "Wed, May 4 2023",
              style: TextStyle(
                fontSize: 10,
                color: AppColor.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}