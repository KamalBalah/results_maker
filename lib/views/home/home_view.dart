import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:results_maker/views/home/widgets/custom_menubar_widget.dart';
import 'package:results_maker/views/home/widgets/dropdown_sheet_widget.dart';
import 'package:results_maker/views/home/widgets/select_file_text_widget.dart';
import 'package:results_maker/views/home/widgets/sheet_table_widget.dart';

import '../../utils/languages/app_strings.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const String route = "/HomeView";

  @override
  Widget build(BuildContext context) {
    return CustomMenuBarWidget(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<HomeController>(
            builder: (HomeController context) {
              return controller.isFileSelected
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(AppStrings.sheets.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 150,
                                  child: DropDownSheetWidget(
                                    onSheetSelected: controller.onSheetSelected,
                                    selectedSheet: controller.selectedSheetKey,
                                    sheets: controller.sheets.keys.toList(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                Text(AppStrings.textDirection.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Switch(
                                    value: controller.isRTL,
                                    onChanged: controller.onChangeRTL),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                Text(AppStrings.pageOrientation.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                GetBuilder<HomeController>(
                                    id: controller.pageOrientationKey,
                                    builder: (context) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Radio<pdf.PageOrientation>(
                                                  value: controller
                                                      .pageOrientationLandscape,
                                                  groupValue: controller
                                                      .pageOrientationValue,
                                                  onChanged: controller
                                                      .onPageOrientationValueChanged),
                                              Text(AppStrings
                                                  .pageOrientationLandscape.tr),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio<pdf.PageOrientation>(
                                                  value: controller
                                                      .pageOrientationPortrait,
                                                  groupValue: controller
                                                      .pageOrientationValue,
                                                  onChanged: controller
                                                      .onPageOrientationValueChanged),
                                              Text(AppStrings
                                                  .pageOrientationPortrait.tr),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                            const Expanded(child: SizedBox.shrink()),
                            GetBuilder<HomeController>(
                                id: controller.exportingKey,
                                builder: (_) {
                                  return ElevatedButton(
                                    onPressed: controller.exporting
                                        ? null
                                        : controller.exportData,
                                    child: Text(
                                      AppStrings.export.tr,
                                    ),
                                  );
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SheetTableWidget(
                          listData: controller.selectedSheet.rows,
                          isRTL: controller.isRTL,
                        ),
                      ],
                    )
                  : const SelectFileTextWidget();
            },
          ),
        ),
      ),
    );
  }
}
