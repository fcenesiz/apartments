import 'package:apartments/controller/building/year/update_year_view_controller.dart';
import 'package:apartments/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../components.dart';

class UpdateYearView extends StatelessWidget {
  final UpdateYearViewController _controller =
      Get.put(UpdateYearViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aidat Belirle"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${_controller.number.value}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Obx(
                          () => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 0.5,
                                    spreadRadius: 0.001,
                                  ),
                                ],
                                color: const Color.fromARGB(255, 237, 226, 255),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton<String>(
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: Colors.deepPurple),
                                iconSize: 42,
                                underline: SizedBox(),
                                value: _controller.offsetMonth.value,
                                items: months.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                    ),
                                  );
                                }).toList(),
                                onChanged: _controller.setMonth),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "yukarıdaki tarihten itibaren belirlenecek olan",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextField(
                      controller: _controller.quantityController,
                      decoration: const InputDecoration(
                          labelText: "Aidat tutarı",
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
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: ElevatedButton(
                onPressed: _controller.createYear,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: const Text(
                    "Tamamla",
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
