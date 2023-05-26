import 'package:apartments/di/app_module.dart';

import 'package:get/get.dart';

import '../model/building/building.dart';
import '../model/flat.dart';

class FlatsViewController extends GetxController {
  var flats = [].obs;
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
      flats.assignAll(building!.flats);
      building!.save();
    }
  }

  Building? getBuilding(){
    return building;
  }

  

}
