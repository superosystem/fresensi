import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresensi/app/data/app_color.dart';
import 'package:fresensi/app/widgets/presence_tile_custom.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/presences_controller.dart';

class PresencesView extends GetView<PresencesController> {
  const PresencesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'PRESENCES',
            style: TextStyle(
              color: AppColor.secondary,
              fontSize: 14,
            ),
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: [
            Container(
              width: 44,
              height: 44,
              margin: const EdgeInsets.only(bottom: 8, top: 8, right: 8),
              child: ElevatedButton(
                onPressed: () {
                  Get.dialog(
                    Dialog(
                      child: Container(
                        height: 372,
                        child: SfDateRangePicker(
                          headerHeight: 50,
                          headerStyle: const DateRangePickerHeaderStyle(textAlign: TextAlign.center),
                          monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                          selectionMode: DateRangePickerSelectionMode.range,
                          selectionColor: AppColor.primary,
                          rangeSelectionColor: AppColor.primary.withOpacity(0.2),
                          viewSpacing: 10,
                          showActionButtons: true,
                          onCancel: () => Get.back(),
                          onSubmit: (data) {
                            if (data != null) {
                              PickerDateRange range = data as PickerDateRange;
                              if (range.endDate != null) {
                                controller.pickDate(
                                    range.startDate!, range.endDate!);
                              }
                            }
                            //else skip
                          },
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: SvgPicture.asset('assets/icons/filter.svg'),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: AppColor.secondaryExtraSoft,
            ),
          ),
        ),
        body: ListView.separated(
            itemCount: 100,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(20),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return SizedBox();
            }
        )
    );
  }
}
