import 'package:apartments/di/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'package:get/get.dart';
import 'package:supercharged/supercharged.dart';

import '../model/building/building.dart';
import '../model/flat.dart';

class FlatsViewController extends GetxController {
  var flatCount = 0.obs;
  var totalFee = 0.0.obs;
  var paidFee = 0.0.obs;
  var dueFee = 0.0.obs;
  var flats = <Flat>[].obs;
  var pieData = <Map<String, dynamic>>[].obs;
  var selectedYear = "Tümü".obs;
  var years = <String>[];
  var fabOpen = false.obs;
  final _fabKey = GlobalKey<ExpandableFabState>();
  late Building? building;

  @override
  void onInit() {
    building = Get.arguments as Building;
    refleshList();
    super.onInit();
  }

  void refleshList({Flat? recent}) {
    if (building != null) {
      if (recent != null) {
        var _building = AppModule.hiveHelper.buildingsBox.get(building!.key);
        _building?.flats.add(recent);
      }
      building!.save();
      flats.assignAll(building!.flats);
      flats.sort(
        (a, b) => a.no.compareTo(b.no),
      );

      selectedYear.value = "Tümü";
      years.clear();
      years.add(selectedYear.value);
      years.addAll(building!.years.map((e) => e.number.toString()).toList());
      calculateFees();
    }
  }

  void calculateFees() {
    totalFee.value = 0;
    paidFee.value = 0;

    for (var flat in flats) {
      for (var fee in flat.fees) {
        if (selectedYear.value == "Tümü") {
          totalFee.value += (fee.quantity > 0.0) ? fee.quantity : 0.0;
          paidFee.value += (fee.quantity > 0.0) ? fee.realizedQuantity : 0.0;
        } else {
          if (fee.year == selectedYear.value.toInt()) {
            totalFee.value += (fee.quantity > 0.0) ? fee.quantity : 0.0;
            paidFee.value += (fee.quantity > 0.0) ? fee.realizedQuantity : 0.0;
          }
        }
      }
    }

    dueFee.value = totalFee.value - paidFee.value;
    pieData.clear();
    pieData.add(
      {
        "domain": "Ödenmiş",
        "color": Color(0xff47B39C),
        "measure": (paidFee.value),
      },
    );
    pieData.add(
      {
        "domain": "Kalan",
        "color": Color(0xffEC6B56),
        "measure": (dueFee.value),
      },
    );
  }

  void changeYear(String? year) {
    selectedYear.value = year!;
    calculateFees();
  }

  void closeExpandableFAB() {
    if (_fabKey.currentState!.isOpen) {
      _fabKey.currentState!.toggle();
    }
  }

  Building? getBuilding() {
    return building;
  }

  GlobalKey<ExpandableFabState> getFabKey() {
    return _fabKey;
  }
}
