import 'package:apartments/controller/building/add_building_view_controller.dart';
import 'package:apartments/controller/building/update_building_view_controller.dart';
import 'package:apartments/model/building/year/year.dart';
import 'package:apartments/other/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:supercharged/supercharged.dart';

import '../../../model/building/building.dart';

class AddYearViewController extends GetxController {
  final AddBuildingViewController _addBuildingViewController =
      Get.put(AddBuildingViewController());

  final UpdateBuildingViewController _updateBuildingViewController =
      Get.put(UpdateBuildingViewController());

  var number = 0.obs;
  TextEditingController quantityController = TextEditingController();

  late Building building;

  late Year _year;
  RxString offsetMonth = months[0].obs;
  late String from;

  void createYear() {
    _year
      ..number = number.value
      ..offsetMonth = months.indexOf(offsetMonth.value)
      ..feeQuantity = quantityController.text.toDouble()!;

    
    if (from == "/add_building") {
      _addBuildingViewController.refleshYearList(recent: _year);
    }
    if (from == "/update_building") {
      _updateBuildingViewController.refleshYearList(recent: _year);
    }
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    setValuesByArguments();
    super.onInit();
  }

  void setValuesByArguments() {
    building = Get.arguments as Building;
    from = Get.previousRoute;
    var years = building.years;
    _year = Year();
    number.value = years.isEmpty ? DateTime.now().year : years.last.number + 1;
  }

  void setMonth(String? month) {
    offsetMonth.value = month!;
  }
}
