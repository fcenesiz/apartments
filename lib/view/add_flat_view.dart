import 'package:apartments/controller/add_flat_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'components.dart';

class AddFlatView extends StatelessWidget {
  
  final AddFlatViewController _controller = Get.put(AddFlatViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daire Ekle"),
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
                          labelText: "Daire sahibi",
                          contentPadding: EdgeInsets.all(8)),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      controller: _controller.noController,
                      decoration: InputDecoration(
                          labelText: "Daire numarası",
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
                onPressed: _controller.createFlat,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    "Daireyi Ekle",
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
