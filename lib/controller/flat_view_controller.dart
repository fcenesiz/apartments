import 'package:apartments/di/app_module.dart';
import 'package:apartments/model/fee.dart';
import 'package:apartments/model/flat.dart';
import 'package:get/get.dart';

import '../model/building.dart';

class FlatViewContoller extends GetxController{

  var buildingName = "".obs;
  var buildingNo = 0.obs;
  var ownerName = "".obs;
  var no = 0.obs;
  var fees = <Fee>[].obs;

  late Flat _flat;
  late Building _building;

  @override
  void onInit() {
    setVariablesByArguments();
    refleshFees();
    super.onInit();
  }

  void setVariablesByArguments(){
    var list = (Get.arguments as List);
    _flat = list[0] as Flat;
    _building = list[1] as Building;
  
    buildingName.value = _building.name;
    buildingNo.value = _building.no;
    ownerName.value = _flat.ownerName;
    no.value = _flat.no;
  }

  Future<void> refleshFees({Fee? updatedFee}) async{

    if(updatedFee != null){
      var fee = fees.firstWhere((element) => element.month == updatedFee.month);
      int feeIdx = fees.indexOf(fee);
       _flat.fees[feeIdx] = updatedFee;
      await AppModule.hiveHelper.buildingsBox.get(_building.key)!.save();
    }
    fees.assignAll(_flat.fees);
  }



}