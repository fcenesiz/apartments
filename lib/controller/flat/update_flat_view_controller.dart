import 'package:apartments/controller/flat/flat_view_controller.dart';
import 'package:apartments/di/app_module.dart';
import 'package:apartments/model/flat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supercharged/supercharged.dart';

class UpdateFlatViewController extends GetxController{

  final FlatViewContoller _flatViewContoller = Get.put(FlatViewContoller());
  var nameController = TextEditingController();
  var noController = TextEditingController();

  late Flat _flat;

  @override
  void onInit() {
    setVariablesByArguments();
    super.onInit();
  }

  void updateFlat() {
    _flat
      ..ownerName = nameController.text
      ..no = noController.text.toInt()!;
    _flatViewContoller.refreshByUpdatedData(_flat.ownerName, _flat.no);
    Get.back();
  }

  void setVariablesByArguments(){
    _flat = Get.arguments as Flat;
    nameController.text = _flat.ownerName;
    noController.text = _flat.no.toString();
  }

}