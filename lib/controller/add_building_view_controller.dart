import 'package:apartments/controller/buildings_view_controller.dart';
import 'package:apartments/model/building.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBuildingViewController extends GetxController{

  BuildingsViewController _buildingsViewController = Get.put(BuildingsViewController());

  TextEditingController nameController = TextEditingController();
  TextEditingController noController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  void createBuilding(){
    if(nameController.text.isEmpty || noController.text.isEmpty)
      return;
    var building = Building();
    building.name =   nameController.text;
    building.no = int.parse(noController.text);
    building.quantity = double.parse(qtyController.text);
    _buildingsViewController.refleshList(recent: building);
    Get.back();
  }
  
  @override
  void onInit() {
    super.onInit();
  }

}