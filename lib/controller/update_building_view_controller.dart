import 'package:apartments/di/app_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/building.dart';

class UpdateBuildingViewController extends GetxController{

  TextEditingController qtyController = TextEditingController();

  late Building _building;

  @override
  void onInit() {
    setValuesByArguments();
    super.onInit();
  }

  void updateBuilding() async{
    var updatedBuilding = AppModule.hiveHelper.buildingsBox.get(_building.key)!;
    updatedBuilding.quantity = double.parse(qtyController.text);
    updatedBuilding.save();
    Get.back();
  }

  void setValuesByArguments(){
    _building = Get.arguments as Building;
    qtyController.text = _building.quantity.toString();
  }

}