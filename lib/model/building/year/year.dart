
import 'package:hive/hive.dart';

part 'year.g.dart';

@HiveType(typeId: 3)
class Year extends HiveObject {

  @HiveField(0)
  late int number;

  @HiveField(1)
  late int offsetMonth;

  @HiveField(2)
  late double feeQuantity;

}