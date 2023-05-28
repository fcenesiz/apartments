import 'package:apartments/controller/flats_view_controller.dart';
import 'package:apartments/model/flat.dart';
import 'package:apartments/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/building/year/year.dart';
import '../model/fee.dart';

class AddFlatViewController extends GetxController {
  FlatsViewController _flatsViewController = Get.put(FlatsViewController());

  TextEditingController nameController = TextEditingController();
  TextEditingController noController = TextEditingController();

  void createFlat() {
    if (nameController.text.isEmpty || noController.text.isEmpty) return;
    var flat = Flat();
    flat.ownerName = nameController.text;
    flat.no = int.parse(noController.text);

    for (var nextYear in _flatsViewController.building!.years) {
      flat.fees.addAll(createDefaultFees(nextYear));
    }

    _flatsViewController.refleshList(recent: flat);
    Get.back();
  }

  List<Fee> createDefaultFees(Year year) {
    var fees = <Fee>[];

    for (var i = 0; i < months.length; i++) {
      var fee = Fee();
      bool isInternal = year.offsetMonth <= i;
      fee.quantity = isInternal ? year.feeQuantity : -1.0;
      fee.realizedQuantity = isInternal ? 0.0 : -1.0;
      fee.month = i;
      fee.year = year.number;
      fees.add(fee);
    }
    return fees;
  }
}
