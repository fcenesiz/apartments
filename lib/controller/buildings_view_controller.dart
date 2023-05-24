import 'package:apartments/di/app_module.dart';
import 'package:get/get.dart';
import '../model/building.dart';

class BuildingsViewController extends GetxController {
  var buildings = [].obs;
  

  @override
  void onInit() {
    refleshList();
    super.onInit();
  }

  void refleshList({Building? recent}) {
    if(recent != null){
      AppModule.hiveHelper.buildingsBox.add(recent);
    }
    buildings.assignAll(AppModule.hiveHelper.buildingsBox.values);
  }

}
