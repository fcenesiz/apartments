
import 'package:apartments/other/excel/detailed.dart';
import 'package:apartments/other/excel/general.dart';

import 'package:flutter/material.dart';

class ExcelHelper {
  
  final General _general = General();
  final Detailed _detailed = Detailed();

  void exportGeneral(BuildContext context) async {
    _general.exportAllFlats(onReady: (excel, buildingName) {
      _detailed.exportFlats(excel: excel, buildingName: buildingName);
    });



  }
}
