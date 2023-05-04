import 'package:flutter/cupertino.dart';
import 'package:fresensi/app/data/app_color.dart';

class PresenceCardCustom extends StatelessWidget {
  const PresenceCardCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: AssetImage('assets/images/pattern-1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SECTION JOB TITLE
          Text(
            "Tester",
            style: TextStyle(
              color: AppColor.white,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          // ID EMPLOYEE
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            child: Text(
              "1234567890",
              style: TextStyle(
                color: AppColor.white,
                fontFamily: 'poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          // CHECKING - CHECKOUT BOX
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              color: AppColor.primarySoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // CHECKING
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          "Check In",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                      Text(
                        "TODAY",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.5,
                  height: 24,
                  color: AppColor.white,
                ),
                // CHECKOUT
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          "Check In",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                      Text(
                        "TODAY",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
