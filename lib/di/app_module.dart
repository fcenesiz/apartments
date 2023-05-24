
import 'package:apartments/other/hive_helper.dart';

class AppModule{

    static final HiveHelper _hiveHelper = HiveHelper();
    static HiveHelper get hiveHelper => _hiveHelper;

}