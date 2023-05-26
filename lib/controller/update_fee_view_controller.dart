import 'package:apartments/controller/flat_view_controller.dart';
import 'package:apartments/model/fee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateFeeViewController extends GetxController {
  final FlatViewContoller _flatViewContoller = Get.put(FlatViewContoller());

  TextEditingController realizedQtyController = TextEditingController();

  late Fee fee;
  var sMonth = "".obs;
  var month = 1.obs;
  var year = 2023.obs;

  @override
  void onInit() {
    super.onInit();
    setValuesByArguments();
    realizedQtyController.addListener(
      () {
        if (realizedQtyController.text.isNotEmpty && double.parse(realizedQtyController.text) > fee.quantity) {
        realizedQtyController.text = fee.quantity.toString();
        }
      },
    );
  }

  void updateFee() async {
    if (realizedQtyController.text.isEmpty) return;
    fee.realizedQuantity = double.parse(realizedQtyController.text);
    fee.month = month.value;
    fee.year = year.value;
    await _flatViewContoller.refleshFees(updatedFee: fee);
    Get.back();
  }

  void setValuesByArguments() {
    fee = Get.arguments as Fee;
    month.value = fee.month;
    year.value = fee.year;
    if (fee.realizedQuantity != 0.0) {
      realizedQtyController.text = fee.realizedQuantity.toInt().toString();
    }
  }

  void setRealizedQtyToMax() {
    realizedQtyController.text = fee.quantity.toString();
  }
}
