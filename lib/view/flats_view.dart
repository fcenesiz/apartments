import 'package:apartments/controller/flats_view_controller.dart';
import 'package:apartments/view/components.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import '../model/building/building.dart';
import '../model/flat.dart';

class FlatsView extends StatelessWidget {
  final FlatsViewController _controller = Get.put(FlatsViewController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _controller.closeExpandableFAB();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("${_controller.getBuilding()!.name}"),
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (_controller.flats.isEmpty)
                  ? const SizedBox()
                  : Row(
                      children: [
                        SizedBox(
                          width: 260,
                          height: 200,
                          child: DChartPie(
                            data: _controller.pieData,
                            labelFontSize: 14,
                            pieLabel: (pieData, index) =>
                                "₺${(pieData["measure"] as double).toInt()}",
                            fillColor: ((pieData, index) => pieData["color"]),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: YearSelectorView(_controller),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _controller.pieData
                                  .map((element) => Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: element["color"],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(element["domain"]),
                                            )
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
              FlatsWidget(_controller),
            ],
          ),
        ),
        floatingActionButton: ExpandableFab(
          key: _controller.getFabKey(),
          distance: 75,
          fanAngle: 75,
          children: [
            FloatingActionButton(
              heroTag: null,
              child: const Icon(Icons.edit),
              onPressed: () {
                Get.toNamed("/update_building",
                    arguments: _controller.getBuilding());
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
      ),
    );
  }
}

Widget FlatsWidget(FlatsViewController controller) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: controller.flats
          .map((flat) => FlatWidget(flat, controller.getBuilding()!))
          .toList(),
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

Widget YearSelectorView(FlatsViewController contoller) {
  return DropdownButton<String>(
      itemHeight: null,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
      iconSize: 24,
      underline: SizedBox(),
      focusColor: Colors.white,
      value: contoller.selectedYear.value,
      isDense: true,
      items: contoller.years.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(color: Colors.deepPurple),
          ),
        );
      }).toList(),
      onChanged: contoller.changeYear);
}
