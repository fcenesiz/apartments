
import 'package:apartments/controller/buildings_view_controller.dart';
import 'package:apartments/model/building.dart';
import 'package:apartments/view/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildingsView extends StatelessWidget {
  final BuildingsViewController _controller =
      Get.put(BuildingsViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Binalar"),
      ),
      body: Center(
        child: BuildingsWidget(_controller),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed("/add_building");
        },
      ),
    );
  }
}

Widget BuildingsWidget(BuildingsViewController controller) {
  return Obx(
    () => SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: controller.buildings
            .map(
              (building) => BuildingWidget(building),
            )
            .toList(),
      ),
    ),
  );
}

Widget BuildingWidget(Building building) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
