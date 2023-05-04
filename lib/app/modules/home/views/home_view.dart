import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresensi/app/controllers/page_index_controller.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:fresensi/app/data/constants.dart';
import 'package:fresensi/app/widgets/convex_appbar_custom.dart';
import 'package:fresensi/app/widgets/presence_card_custom.dart';
import 'package:fresensi/app/widgets/presence_tile_custom.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageIndexC = Get.find<PageIndexController>();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
              children: [
                const SizedBox(height: 16),
                // SECTION 1 - welcome
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 42,
                          height: 42,
                          child: Image.network(
                            (user["avatar"] == null || user['avatar'] == "")
                                ? "$defaultAvatarUrl + ${user['name']}"
                                : user['avatar'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.secondarySoft,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user["name"],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // SECTION 2 - card
                PresenceCardCustom(user: user),
                // SECTION 3 - last location
                // last location
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 24, left: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 2),
                      Text(
                        "Stasiun Luar Angkasa",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.secondarySoft,
                        ),
                      ),
                    ],
                  ),
                ),
                // SECTION 4 - distance & map
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 84,
                          decoration: BoxDecoration(
                            color: AppColor.primaryExtraSoft,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                child: const Text(
                                  'Distance from Office',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              Text(
                                "120 KM",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 84,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.primaryExtraSoft,
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/map.png'),
                                fit: BoxFit.cover,
                                opacity: 0.3,
                              ),
                            ),
                            child: const Text(
                              'Open in Maps',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // SECTION 5 - presence history
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Presence History",
                        style: TextStyle(
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Show All"),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return PresenceTileCustom();
                  },
                ),
                SizedBox(height: 30),
              ],
            );
          }else{
            return const Center(child: Text("Problem Occurred"));
          }
        }
      ),
      extendBody: true,
      bottomNavigationBar: ConvexAppBarCustom(pageIndexC.pageIndex.value),
    );
  }
}
