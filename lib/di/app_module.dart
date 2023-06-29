import 'package:apartments/other/excel/excel_hepler.dart';
import 'package:apartments/other/hive_helper.dart';
import 'package:apartments/other/permission_helper.dart';

class AppModule {
  static final HiveHelper _hiveHelper = HiveHelper();
  static HiveHelper get hiveHelper => _hiveHelper;

  static final ExcelHelper _excelHepler = ExcelHelper();
  static ExcelHelper get excelHelper => _excelHepler;

  static final PermissionHelper _permissionHelper = PermissionHelper();
  static PermissionHelper get permissionHelper => _permissionHelper;
}
