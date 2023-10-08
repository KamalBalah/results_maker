import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_bar/menu_bar.dart';

import '../../../utils/languages/app_strings.dart';
import '../home_controller.dart';

class CustomMenuBarWidget extends GetView<HomeController> {
  const CustomMenuBarWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MenuBarWidget(
      barButtonStyle: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          alignment: Alignment.center),
      barStyle: MenuStyle(
        shape: MaterialStateProperty.all(LinearBorder.none),
      ),
      menuButtonStyle:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
      barButtons: [
        BarButton(
          text: Text(
            AppStrings.file.tr,
            style: const TextStyle(color: Colors.white),
          ),
          submenu: SubMenu(
            menuItems: [
              MenuButton(
                onTap: controller.openFile,
                text: Text(
                  AppStrings.openExcelFile.tr,
                ),
              ),
              MenuButton(
                text: SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.language.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Switch(
                        value: controller.isArabic,
                        onChanged: controller.onChangeLang,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
      child: child,
    );
  }
}
