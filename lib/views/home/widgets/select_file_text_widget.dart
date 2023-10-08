import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/languages/app_strings.dart';

class SelectFileTextWidget extends StatelessWidget {
  const SelectFileTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(
    child: Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: '${AppStrings.noFileSelected.tr} ',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w400,
            ),
          ),
          // const TextSpan(
          //   text: "Ctrl+O ",
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 26,
          //     fontWeight: FontWeight.w800,
          //   ),
          // ),
          // TextSpan(
          //   text: AppStrings.toOpenFile.tr,
          //   style: const TextStyle(
          //     color: Colors.black,
          //     fontSize: 26,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
        ],
      ),
    ),
    );
  }
}
