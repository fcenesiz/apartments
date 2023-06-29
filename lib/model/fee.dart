import 'package:hive/hive.dart';

part 'fee.g.dart';

@HiveType(typeId :2)
class Fee extends HiveObject{

  @HiveField(0)
  late double quantity;

  @HiveField(1)
  late double realizedQuantity = 0.0;

  @HiveField(2)
  late int month;
  
  @HiveField(3)
  late int year;


}