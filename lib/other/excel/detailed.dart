import 'dart:io';

import 'package:apartments/other/extensions.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supercharged/supercharged.dart';

import '../../di/app_module.dart';
import '../constants.dart';

class Detailed {
  // Flats
  void exportFlats({required Excel excel, required String buildingName}) async {
    // building sheet
    var flats = AppModule.hiveHelper.buildingsBox.values
        .firstWhere((element) => element.name == buildingName)
        .flats;
    var sheet = excel["Detaylar"];

    updateHeaderStyles(sheet);

    // header
    updateFlatsSheet(sheet, 0, 0, "Yıl");
    updateFlatsSheet(sheet, 1, 0, "Ay");
    updateFlatsSheet(sheet, 2, 0, "Ad Soyad");
    updateFlatsSheet(sheet, 3, 0, "Ödenen");
    updateFlatsSheet(sheet, 4, 0, "Kalan");
    updateFlatsSheet(sheet, 5, 0, "Aidat");

    var idx = 1;
    for (int i = 0; i < flats.length; i++) {
      var fees = flats[i].fees.filter((element) => element.quantity > 1.0).toList();
      if (i > 0) idx += fees.length + 1;
      
      for (var j = 0; j < fees.length; j++) {
        updateFlatsSheet(sheet, 0, j + idx, fees[j].year.toString());
        updateFlatsSheet(sheet, 1, j + idx, fees[j].month.convertMonthToText);
        updateFlatsSheet(sheet, 2, j + idx, flats[i].ownerName);
        updateFlatsSheet(
            sheet, 3, j + idx, fees[j].realizedQuantity.toString());
        updateFlatsSheet(sheet, 4, j + idx,
            (fees[j].quantity - fees[j].realizedQuantity).toString());
        updateFlatsSheet(sheet, 5, j + idx, fees[j].quantity.toString());
      }
    }
  }

  void updateFlatsSheet(Sheet sheet, int columnIdx, int rowIdx, String value) {
    sheet
        .cell(
          CellIndex.indexByColumnRow(columnIndex: columnIdx, rowIndex: rowIdx),
        )
        .value = value;
  }

  void updateHeaderStyles(Sheet sheet) {
    CellStyle cellStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontSize: 14);

    for (var i = 0; i < 6; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .cellStyle = cellStyle;
    }
  }
}
