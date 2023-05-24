import 'package:apartments/controller/add_building_view_controller.dart';
import 'package:apartments/view/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddBuildingView extends StatelessWidget {
  final AddBuildingViewController _controller =
      Get.put(AddBuildingViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bina Ekle"),
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
                      controller: _controller.nameController,
                      decoration: InputDecoration(
                          labelText: "Bina Adı",
                          contentPadding: EdgeInsets.all(8)),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      controller: _controller.noController,
                      decoration: InputDecoration(
                          labelText: "Bina no",
                          contentPadding: EdgeInsets.all(8)),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),SizedBox(
                      height: 32,
                    ),
                    TextField(
                      controller: _controller.qtyController,
                      decoration: InputDecoration(
                          labelText: "Bina aidatı",
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
                onPressed: _controller.createBuilding,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    "Binayı Ekle",
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
