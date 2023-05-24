import 'package:apartments/controller/update_building_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'components.dart';

class UpdateBuildingView extends StatelessWidget {

  final UpdateBuildingViewController _controller = Get.put(UpdateBuildingViewController());

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
                padding: const EdgeInsets.all(64.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _controller.qtyController,
                      decoration: InputDecoration(
                          labelText: "Yeni aidat tutarı",
                          contentPadding: EdgeInsets.all(8)),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
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
