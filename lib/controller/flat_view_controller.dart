import 'package:apartments/controller/flats_view_controller.dart';
import 'package:apartments/di/app_module.dart';
import 'package:apartments/model/fee.dart';
import 'package:apartments/model/flat.dart';
import 'package:get/get.dart';
import 'package:supercharged/supercharged.dart';

import '../model/building/building.dart';

class FlatViewContoller extends GetxController {
  var buildingName = "".obs;
  var buildingNo = 0.obs;
  var ownerName = "".obs;
  var no = 0.obs;
  var selectedYear = 0.obs;

  var fees = <Fee>[].obs;
  var years = <int>[];

  late Flat _flat;
  late Building _building;

  final FlatsViewController _flatsViewController =
      Get.put(FlatsViewController());

  @override
  void onInit() {
    setVariablesByArguments();
    refleshFees();
    super.onInit();
  }

  void setVariablesByArguments() {
    var list = (Get.arguments as List);
    _flat = list[0] as Flat;
    _building = list[1] as Building;
    buildingName.value = _building.name;
    buildingNo.value = _building.no;
    ownerName.value = _flat.ownerName;
    no.value = _flat.no;
    selectedYear.value =
        _flat.fees.maxBy((a, b) => a.year.compareTo(b.year))!.year;
    years.addAll(_building.years.map((e) => e.number));
  }

  Future<void> refleshFees({Fee? updatedFee}) async {
    if (updatedFee != null) {
      _flat.fees
          .firstWhere((element) =>
              element.month == updatedFee.month &&
              element.year == updatedFee.year)
          .realizedQuantity = updatedFee.realizedQuantity;
    }

    fees.assignAll(
        _flat.fees.filter((element) => element.year == selectedYear.value));
  }

  void changeYear(int? year) {
    selectedYear.value = year!;
    fees.assignAll(
        _flat.fees.filter((element) => element.year == selectedYear.value));
  }

  void deleteFlat() {
    var deletedFlat = AppModule.hiveHelper.buildingsBox
        .get(_building.key)!
        .flats
        .removeWhere((element) =>
            element.no == _flat.no && element.ownerName == _flat.ownerName);
    _flatsViewController.refleshList();
    Get.back();
  }

  void onBack() {
    _flatsViewController.refleshList();
    Get.back();
  }
}
