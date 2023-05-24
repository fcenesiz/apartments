
import 'package:apartments/controller/flats_view_controller.dart';
import 'package:apartments/model/flat.dart';
import 'package:apartments/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/fee.dart';

class AddFlatViewController extends GetxController{

  FlatsViewController _flatsViewController = Get.put(FlatsViewController());

  TextEditingController nameController = TextEditingController();
  TextEditingController noController = TextEditingController();

  void createFlat(){
    if(nameController.text.isEmpty || noController.text.isEmpty)
      return;
    var flat = Flat();
    flat.ownerName =   nameController.text;
    flat.no = int.parse(noController.text);
    flat.fees.assignAll(createDefaultFees(_flatsViewController.building!.quantity));
    _flatsViewController.refleshList(recent: flat);
    Get.back();
  }
  
  List<Fee> createDefaultFees(double quantity){

    var fees = <Fee>[];
    var year = DateTime.now().year;

    for (var i = 0; i < months.length; i++) {
      var fee = Fee();
      fee.quantity = quantity;
      fee.realizedQuantity = 0.0;
      fee.month = i;
      fee.sMonth = months[i];
      fee.year = year;
      fees.add(fee);
    }
    return fees;
  }

}