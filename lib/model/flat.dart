import 'package:hive/hive.dart';

import 'fee.dart';

part 'flat.g.dart';

@HiveType(typeId: 1)
class Flat extends HiveObject{

  @HiveField(0)
  late String ownerName;

  @HiveField(1)
  late int no;

  @HiveField(2)
  List<Fee> fees = [];

}