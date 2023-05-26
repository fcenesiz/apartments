import 'package:apartments/other/extensions.dart';
import 'package:apartments/view/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/building/add_building_view_controller.dart';
import '../../model/building/year/year.dart';

class AddBuildingView extends StatelessWidget {
  final AddBuildingViewController _controller =
      Get.put(AddBuildingViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bina Ekle"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _controller.nameController,
                        decoration: const InputDecoration(
                            labelText: "Bina Adı",
                            contentPadding: EdgeInsets.all(8)),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextField(
                        controller: _controller.noController,
                        decoration: const InputDecoration(
                            labelText: "Bina no",
                            contentPadding: EdgeInsets.all(8)),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      YearsView(_controller.years),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_controller.years.isEmpty) {
                              Get.toNamed("/add_year",
                                  arguments: _controller.building);
                            } else {
                              Get.toNamed("/update_year",
                                  arguments: _controller.building);
                            }
                          },
                          child: Text((_controller.years.isEmpty
                              ? "Aidat belirle"
                              : "Düzenle")),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: ElevatedButton(
                onPressed: _controller.createBuilding,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: const Text(
                    "Binayı Ekle",
                    style: listTextStyle,
                  ),
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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
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
              text: " olarak belirlenecek!",
            ),
          ],
        ),
      ));
}
