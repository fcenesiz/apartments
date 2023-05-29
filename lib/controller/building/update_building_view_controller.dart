import 'package:apartments/controller/flats_view_controller.dart';
import 'package:apartments/di/app_module.dart';
import 'package:apartments/model/fee.dart';
import 'package:apartments/other/constants.dart';
import 'package:get/get.dart';
import 'package:supercharged/supercharged.dart';

import '../../model/building/building.dart';
import '../../model/building/year/year.dart';

class UpdateBuildingViewController extends GetxController {
  final FlatsViewController _flatsViewContoller =
      Get.put(FlatsViewController());

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
    updatedBuilding.save();
    _flatsViewContoller.refleshList();
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
        addYearToFlats(recent);
      } else {
        building.years[idx] = recent;
        updateFlatsByYear(recent);
      }
      years.assignAll(building.years);
    }
  }

  void addYearToFlats(Year year) {
    for (var flat in building.flats) {
      for (var i = 0; i < months.length; i++) {
        Fee fee = Fee()
          ..month = i
          ..year = year.number;
        if (i >= year.offsetMonth) {
          fee.quantity = year.feeQuantity;
          fee.realizedQuantity = 0.0;
        } else {
          fee.quantity = -1;
          fee.realizedQuantity = -1;
        }
        flat.fees.add(fee);
      }
    }
  }

  void updateFlatsByYear(Year year) {
    for (var flat in building.flats) {
      var fees =
          flat.fees.filter((element) => element.year == year.number).toList();
      for (var i = 0; i < months.length; i++) {
        var fee = fees.firstWhere((element) => element.month == i);
        if (i >= year.offsetMonth) {
          fee.quantity = year.feeQuantity;
          if (fee.realizedQuantity < 0.0) fee.realizedQuantity = 0.0;
        } else {
          //fee.quantity = -1;
          //fee.realizedQuantity = -1;
        }
      }
    }
  }
}
