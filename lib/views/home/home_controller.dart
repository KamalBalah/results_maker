import 'dart:io';
import 'dart:ui';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:results_maker/utils/local_db_keys.dart';
import 'package:results_maker/services/settings_service.dart';

import '../../utils/languages/app_strings.dart';
import 'create_pdf.dart';

class HomeController extends GetxController {
  late Map<String, Sheet> sheets;
  bool isFileSelected = false;
  String? selectedSheetKey;
  late Sheet selectedSheet;
  bool isRTL = true;
  late bool isArabic = true;
  late Excel excel;
  final String pageOrientationKey = "pageOrientationValue";
  final String exportingKey = "exportingKey";

  bool exporting = false;
  pdf.PageOrientation pageOrientationLandscape = pdf.PageOrientation.landscape;
  pdf.PageOrientation pageOrientationPortrait = pdf.PageOrientation.portrait;
  pdf.PageOrientation pageOrientationValue = pdf.PageOrientation.landscape;

  void onPageOrientationValueChanged(pdf.PageOrientation? value) async {
    pageOrientationValue = value ?? pdf.PageOrientation.landscape;
    if (value == pdf.PageOrientation.landscape) {
      await GetStorage(LocalDBKeys.appSettings)
          .write(LocalDBKeys.pageOrientation, true);
    } else {
      await GetStorage(LocalDBKeys.appSettings)
          .write(LocalDBKeys.pageOrientation, false);
    }

    update([pageOrientationKey]);
  }

  @override
  void onInit() async {
    super.onInit();
    isArabic = Get.find<SettingsService>().getLocale().languageCode == "ar"
        ? true
        : false;

    pageOrientationValue = ((GetStorage(LocalDBKeys.appSettings)
                .read(LocalDBKeys.pageOrientation) as bool?) ??
            true)
        ? pdf.PageOrientation.landscape
        : pdf.PageOrientation.portrait;
    update();
  }

  void exportData() async {
    exporting = true;
    update([exportingKey]);
    CreatePDF createPDF = CreatePDF(
      listData: selectedSheet.rows,
      orientation: pageOrientationValue,
    );

    await Future.delayed(const Duration(milliseconds: 200));
    await createPDF.createPDF();
    exporting = false;
    update([exportingKey]);
  }

  void onChangeLang(bool isArabic) {
    if (isArabic) {
      Get.find<SettingsService>().updateLocale(const Locale("ar"));
    } else {
      Get.find<SettingsService>().updateLocale(const Locale("en"));
    }
    this.isArabic = isArabic;
    update();
  }

  void onChangeRTL(bool isRTL) {
    this.isRTL = isRTL;
    update();
  }

  Future<FilePickerResult?> selectFile(List<String>? allowedExtensions) async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      allowMultiple: false,
    );
  }

  void openFile() async {
    FilePickerResult? pickedFile = await selectFile(['xlsx']);
    if (pickedFile == null) {
      return;
    }
    String path = pickedFile.files.first.path!;
    sheets = await readExcelFile(File(path));
    isFileSelected = true;
    onSheetSelected(sheets.keys.toList().first);
    update();
  }

  Future<Map<String, Sheet>> readExcelFile(File file) async {
    excel = Excel.decodeBytes(await file.readAsBytes());
    Map<String, Sheet> sheets = excel.tables;
    return sheets;
  }

  void onSheetSelected(String? selectedSheetKey) async {
    this.selectedSheetKey = selectedSheetKey;
    excel.copy(selectedSheetKey!, "tempSheet");
    excel.save();
    selectedSheet = excel.sheets["tempSheet"]!;
    addTotal();
    update();
  }

  void addTotal() {
    selectedSheet.insertColumn(selectedSheet.maxCols);
    selectedSheet.insertColumn(selectedSheet.maxCols);

    updateCellFromSelectedSheet(
      columnIndex: selectedSheet.maxCols - 1,
      rowIndex: 0,
      value: AppStrings.total.tr,
    );

    updateCellFromSelectedSheet(
      columnIndex: selectedSheet.maxCols - 2,
      rowIndex: 0,
      value: AppStrings.average.tr,
    );

    for (int i = 1; i < selectedSheet.maxRows; i++) {
      int total = sumTotal(i);

      updateCellFromSelectedSheet(
        columnIndex: selectedSheet.maxCols - 2,
        rowIndex: i,
        value: (total / (selectedSheet.maxCols - 4)).toStringAsFixed(2),
      );
      updateCellFromSelectedSheet(
        columnIndex: selectedSheet.maxCols - 1,
        rowIndex: i,
        value: total,
      );
    }
  }

  int sumTotal(int i) {
    int total = 0;
    for (int j = 2; j < selectedSheet.rows[i].length - 2; j++) {
      total += int.parse(selectedSheet.rows[i][j]?.value.toString() ?? "0");
    }
    return total;
  }

  void updateCellFromSelectedSheet({
    required int columnIndex,
    required int rowIndex,
    required dynamic value,
  }) {
    selectedSheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: columnIndex,
        rowIndex: rowIndex,
      ),
      value,
    );
  }
}
