import 'package:apartments/model/building/year/year.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/building/building.dart';
import 'buildings_view_controller.dart';

class AddBuildingViewController extends GetxController {
  BuildingsViewController _buildingsViewController =
      Get.put(BuildingsViewController());

  TextEditingController nameController = TextEditingController();
  TextEditingController noController = TextEditingController();

  late Building building;

  var years = <Year>[].obs;

  @override
  void onInit() {
    building = Building()..years = [];
    super.onInit();
  }

  void createBuilding() {
    if (nameController.text.isEmpty || noController.text.isEmpty) return;
    building
      ..name = nameController.text
      ..no = int.parse(noController.text);
    _buildingsViewController.refleshList(recent: building);
    Get.back();
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
