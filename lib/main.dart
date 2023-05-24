import 'package:apartments/di/app_module.dart';
import 'package:apartments/view/add_building_view.dart';
import 'package:apartments/view/update_building_view.dart';
import 'package:apartments/view/update_fee_view.dart';
import 'package:apartments/view/add_flat_view.dart';
import 'package:apartments/view/buildings_view.dart';
import 'package:apartments/view/flats_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'view/flat_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await AppModule.hiveHelper.openBuildingsBox();
  runApp(ApartmentsApp());
}

class ApartmentsApp extends StatelessWidget {
  const ApartmentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      home: BuildingsView(),
      getPages: [
        GetPage(name: '/buildings', page: () => BuildingsView()),
        GetPage(name: '/add_building', page: () => AddBuildingView()),
        GetPage(name: '/flats', page: () => FlatsView()),
        GetPage(name: '/flat', page: () => FlatView()),
        GetPage(name: '/add_flat', page: () => AddFlatView()),
        GetPage(name: '/update_building', page: () => UpdateBuildingView()),
        GetPage(name: '/update_fee', page: () => UpdateFeeView()),
      ],
    );
  }
}

