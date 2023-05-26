import 'package:apartments/model/building/year/year.dart';
import 'package:hive/hive.dart';

import '../flat.dart';

part 'building.g.dart';

@HiveType(typeId: 0)
class Building extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int no;

  @HiveField(2)
  List<Flat> flats = [];

  @HiveField(3)
  late List<Year> years;

  

}
