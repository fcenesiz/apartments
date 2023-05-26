import 'package:apartments/model/building/year/year.dart';
import 'package:apartments/model/fee.dart';
import 'package:apartments/model/flat.dart';
import 'package:hive/hive.dart';

import '../model/building/building.dart';

class HiveHelper {
  // boxes
  static const BOX_BUILDINGS = "buildings";

  late Box<Building> buildingsBox;

  Future<void> openBuildingsBox() async {
    Hive.registerAdapter(BuildingAdapter());
    Hive.registerAdapter(FeeAdapter());
    Hive.registerAdapter(FlatAdapter());
    Hive.registerAdapter(YearAdapter());
    buildingsBox = await Hive.openBox<Building>(BOX_BUILDINGS);
  }
}
