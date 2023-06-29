import 'dart:io';

import 'package:apartments/other/functions.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supercharged/supercharged.dart';

import '../../di/app_module.dart';
import '../constants.dart';

class General {
  void updateFlatsSheet(Sheet sheet, int columnIdx, int rowIdx, String value) {
    sheet
        .cell(
          CellIndex.indexByColumnRow(columnIndex: columnIdx, rowIndex: rowIdx),
        )
        .value = value;
  }

  // Flats
  void prepareFlatsToExport(
      {required Excel excel, required String buildingName}) async {
    // building sheet
    var flats = AppModule.hiveHelper.buildingsBox.values
        .firstWhere((element) => element.name == buildingName)
        .flats;
    var sheet = excel[excel.getDefaultSheet().toString()];

    // header
    updateFlatsSheet(sheet, 0, 0, "Ad Soyad");
    updateFlatsSheet(sheet, 1, 0, "Ödenen");
    updateFlatsSheet(sheet, 2, 0, "Kalan");
    updateFlatsSheet(sheet, 3, 0, "Toplam");

    for (int i = 0; i < flats.length; i++) {
      // ownerName
      updateFlatsSheet(sheet, 0, i + 1, flats[i].ownerName);
      // realizedQuantity
      updateFlatsSheet(sheet, 1, i + 1,
          flats[i].fees.sumByDouble((p0) => p0.realizedQuantity).toString());
      // remaining quantity
      updateFlatsSheet(
          sheet,
          2,
          i + 1,
          (flats[i].fees.sumByDouble((p0) => p0.quantity) -
                  flats[i].fees.sumByDouble((p0) => p0.realizedQuantity))
              .toString());

      // total quantity
      updateFlatsSheet(sheet, 3, i + 1,
          flats[i].fees.sumByDouble((p0) => p0.quantity).toString());
    }
  }

  void prepareFlatsToExport2(
      {required Excel excel, required String buildingName}) async {
    // building sheet
    var flats = AppModule.hiveHelper.buildingsBox.values
        .firstWhere((element) => element.name == buildingName)
        .flats;
    var sheet = excel[excel.getDefaultSheet().toString()];

    // header
    updateFlatsSheet(sheet, 0, 0, "Yıl");
    updateFlatsSheet(sheet, 1, 0, "Ad Soyad");
    updateFlatsSheet(sheet, 2, 0, "Ödenen");
    updateFlatsSheet(sheet, 3, 0, "Kalan");
    updateFlatsSheet(sheet, 4, 0, "Toplam");

    var years = [];

    for (var element in flats[0].fees) {
      if (!years.contains(element.year)) {
        years.add(element.year);
      }
    }
    years.sort();

    var idx = 1;
    for (var year in years) {
      if (year > years[0]) {
        idx += flats.length + 1;
      }
      for (int i = 0; i < flats.length; i++) {
        // year
        updateFlatsSheet(sheet, 0, i + idx, year.toString());
        // ownerName
        updateFlatsSheet(sheet, 1, i + idx, flats[i].ownerName);
        // realizedQuantity
        var realizedQuantity = flats[i]
            .fees
            .filter((element) => element.year == year)
            .sumByDouble((p0) => p0.realizedQuantity);
        if (realizedQuantity < 0.0) realizedQuantity = 0.0;
        updateFlatsSheet(sheet, 2, i + idx, realizedQuantity.toString());

        // remaining quantity
        var remainingQty = flats[i]
            .fees
            .filter((element) => element.year == year && element.quantity > 0.0)
            .sumByDouble((p0) => p0.quantity - p0.realizedQuantity);
        print(remainingQty);
        updateFlatsSheet(sheet, 3, i + idx, remainingQty.toString());

        // total quantity
        var totalQty = flats[i].fees.filter((element) => element.year == year && element.quantity > 0.0).sumByDouble((p0) => p0.quantity);
        updateFlatsSheet(sheet, 4, i + idx, totalQty.toString());
      }
    }
  }

  void exportAllFlats(
      {required Function(Excel excel, String buildingName) onReady}) {
    var apartments = AppModule.hiveHelper.buildingsBox.values.toList();
    for (var i = 0; i < apartments.length; i++) {
      var excel = Excel.createExcel();
      updateHeaderStyles(excel[excel.getDefaultSheet()!]);
      prepareFlatsToExport2(excel: excel, buildingName: apartments[i].name);
      onReady(excel, apartments[i].name);
      export(excel, buildingName: apartments[i].name);
    }
  }

  void updateHeaderStyles(Sheet sheet) {
    CellStyle cellStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontSize: 14);

    // cellStyle.underline = Underline.Single; // or Underline.Double

    for (var i = 0; i < 5; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .cellStyle = cellStyle;
    }
  }

  void export(Excel excel, {required String buildingName}) async {

    var fileBytes = excel.save();
    var dir = await findLocalPath(TargetPlatform.android);

    File('$dir/$buildingName.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
  }


}
