import 'package:apartments/controller/flat_view_controller.dart';
import 'package:apartments/other/extensions.dart';
import 'package:apartments/view/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';

import '../model/fee.dart';

class FlatView extends StatelessWidget {
  final FlatViewContoller _controller = Get.put(FlatViewContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daire ${_controller.no}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        child: CircleAvatar(
                          radius: 41,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            //backgroundColor: Colors.yellowAccent,
                            radius: 40,
                            child: Text(
                              _controller.ownerName.value.initials,
                              style: listTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _controller.ownerName.value,
                            style: listTextStyle,
                          ),
                          Text(
                            "${_controller.buildingName}, ${_controller.buildingNo.value}/${_controller.no.value}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                    "${_controller.fees[0].year} yılı aidat bedeli: ₺${_controller.fees.firstWhere((element) => element.quantity > 0).quantity}"),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white30,
              width: double.infinity,
              alignment: Alignment.center,
              child: (_controller.fees.length > 0)
                  ? FeesView(_controller.fees)
                  : Text("Aidatlar"),
            ),
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        children: [
          FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.edit),
            onPressed: () {},
          ),
          FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
    );
  }
}

Widget FeesView(List<Fee> fees) {
  return SingleChildScrollView(
    child: Obx(
      () => Column(
        children: fees
            .map(
              (fee) => Card(
                child: InkWell(
                  onTap: () {
                    Get.toNamed("/update_fee", arguments: fee);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            fee.month.convertMonthToText,
                            style: listTextStyle,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                (fee.quantity < 0)
                                    ? "-"
                                    : (fee.realizedQuantity == 0)
                                        ? "Ödeme giriniz"
                                        : (fee.realizedQuantity != fee.quantity)
                                            ? "₺${fee.realizedQuantity}"
                                            : "Ödendi",
                                style: (fee.realizedQuantity > 0 &&
                                        fee.realizedQuantity == fee.quantity)
                                    ? TextStyle(
                                        color: Colors.green,
                                        fontSize: listTextStyle.fontSize)
                                    : (fee.realizedQuantity > 0)
                                        ? TextStyle(
                                            color: Colors.orange,
                                            fontSize: listTextStyle.fontSize)
                                        : listTextStyle,
                                textAlign: TextAlign.end,
                              ),
                              (fee.realizedQuantity > 0 &&
                                      fee.realizedQuantity == fee.quantity)
                                  ? const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ),
  );
}
