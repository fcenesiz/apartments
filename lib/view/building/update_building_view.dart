import 'package:apartments/other/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/building/update_building_view_controller.dart';
import '../../model/building/year/year.dart';
import '../components.dart';

class UpdateBuildingView extends StatelessWidget {
  final UpdateBuildingViewController _controller =
      Get.put(UpdateBuildingViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bina Düzenle"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Obx(
                  () => Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          YearsView(_controller.years),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed("/update_year",
                                    arguments: _controller.building);
                              },
                              child: Text("Düzenle"),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed("/add_year",
                                    arguments: _controller.building);
                              },
                              child: Text(
                                  "${_controller.years.last.number + 1} aidatını belirle"),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: ElevatedButton(
                onPressed: _controller.updateBuilding,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    "Tamamla",
                    style: listTextStyle,
                  ),
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget YearsView(List<Year> years) {
  return Align(
    alignment: Alignment.centerRight,
    child: Column(
      children: [
        SizedBox(
          height: years.isNotEmpty ? 64 : 0,
        ),
        ...years
            .map(
              (year) => YearView(year),
            )
            .toList(),
      ],
    ),
  );
}

Widget YearView(Year year) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "${year.number}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text: " yılı için ",
            ),
            TextSpan(
              text: year.offsetMonth.convertMonthToText,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text: " ayından itibaren aidat gideri ",
            ),
            TextSpan(
              text: "₺${year.feeQuantity}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text: " olarak belirlenmiş.",
            ),
          ],
        ),
      ));
}
