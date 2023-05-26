import 'package:apartments/di/app_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/building/building.dart';
import '../../model/building/year/year.dart';

class UpdateBuildingViewController extends GetxController {
  late Building building;
  var years = <Year>[].obs;

  @override
  void onInit() {
    setValuesByArguments();
    refleshYearList();
    super.onInit();
  }

  void updateBuilding() async {
    var updatedBuilding = AppModule.hiveHelper.buildingsBox.get(building.key)!;
    // TODO:
    //updatedBuilding.quantity = double.parse(qtyController.text);
    updatedBuilding.save();
    Get.back();
  }

  void setValuesByArguments() {
    building = Get.arguments as Building;
    years.assignAll(building.years);
  }

  void refleshYearList({Year? recent}) {
    if (recent != null) {
      int idx = building.years
          .indexWhere((element) => recent.number == element.number);
      if (idx == -1) {
        building.years.add(recent);
      } else {
        building.years[idx] = recent;
      }
      years.assignAll(building.years);
    }
  }
}
