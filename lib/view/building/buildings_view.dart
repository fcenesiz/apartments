import 'package:apartments/di/app_module.dart';
import 'package:apartments/view/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controller/building/buildings_view_controller.dart';
import '../../model/building/building.dart';

class BuildingsView extends StatelessWidget {
  final BuildingsViewController _controller =
      Get.put(BuildingsViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Binalar"),
        actions: [
          IconButton(
              onPressed: () async {
                await AppModule.permissionHelper
                    .requestPermission([Permission.storage]);
                try {
                  AppModule.excelHelper.exportGeneral(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                    children: [
                      Text("Rapor "),
                      Text(
                        "Indirilenler",
                        style: TextStyle(color: Colors.amber),
                      ),
                      Text(" klaörüne kaydedildi!")
                    ],
                  )));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Hata: $e", style: TextStyle(color: Colors.redAccent),),
                    ),
                  );
                }
              },
              icon: Icon(Icons.output)),
          IconButton(
              onPressed: () {
                Get.toNamed("/about");
              },
              icon: Icon(Icons.question_mark))
        ],
      ),
      body: Obx(
        () => Center(
          child: (_controller.buildings.isEmpty)
              ? Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/add_building");
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                      child: Text(
                        "Bina Ekle",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              : BuildingsWidget(_controller),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.toNamed("/add_building");
        },
      ),
    );
  }
}

Widget BuildingsWidget(BuildingsViewController controller) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: controller.buildings
          .map(
            (building) => BuildingWidget(building),
          )
          .toList(),
    ),
  );
}

Widget BuildingWidget(Building building) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: InkWell(
      onTap: () {
        Get.toNamed("/flats", arguments: building);
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              building.name,
              style: listTextStyle,
            )
          ],
        ),
      ),
    ),
  );
}
