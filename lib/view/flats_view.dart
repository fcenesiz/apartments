import 'package:apartments/controller/flats_view_controller.dart';
import 'package:apartments/view/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import '../model/building.dart';
import '../model/flat.dart';

class FlatsView extends StatelessWidget {
  final FlatsViewController _controller = Get.put(FlatsViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_controller.getBuilding()!.name}"),),
      body: Center(
        child: FlatsWidget(_controller),
      ),
      floatingActionButton: ExpandableFab(
        distance: 75,
        fanAngle: 75,
        children: [
          FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.edit),
            onPressed: () {
              Get.toNamed("/update_building", arguments: _controller.getBuilding());
            },
          ),
          FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.add),
            onPressed: () {
              Get.toNamed("/add_flat");
            },
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
    );
  }
}

Widget FlatsWidget(FlatsViewController controller) {
  return Obx(
    () => SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: controller.flats
            .map((flat) => FlatWidget(flat, controller.getBuilding()!))
            .toList(),
      ),
    ),
  );
}

Widget FlatWidget(Flat flat, Building building) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: InkWell(
      onTap: () {
        Get.toNamed("/flat", arguments: [flat, building]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              flat.ownerName,
              style: listTextStyle,
            ),
            Text(
              flat.no.toString(),
              style: listTextStyle,
            ),
          ],
        ),
      ),
    ),
  );
}
