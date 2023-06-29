import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> findLocalPath(TargetPlatform platform) async {
  if (platform == TargetPlatform.android) {
    return "/sdcard/download/";
  } else {
    var directory = await getApplicationDocumentsDirectory();
    return directory.path + Platform.pathSeparator + 'Download';
  }
}