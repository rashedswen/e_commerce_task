import 'dart:developer';

import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required this.widthSize,
    required this.heightSize,
  });

  final double widthSize;
  final double heightSize;

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsModel>(builder: (_, itemModel, __) {
      itemModel.transactionsList();
      log(itemModel.transactionsList().length.toString());
      return itemModel.transactionsList().isEmpty
          ? SizedBox(
              height: heightSize,
              width: widthSize,
              child: const Center(
                child: Text("No Transactions"),
              ),
            )
          : ListView.builder(
              itemCount: itemModel.transactions.length,
              itemBuilder: (context, index) {
                return Container(
                  width: widthSize,
                  height: heightSize * 0.2,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Row(children: [
                      FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Name"),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("PRO-SA2"),
                                Text("6 x 320 ml"),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "12.13 SR",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      FittedBox(
                        child: FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    itemModel.transactionsList()[index].type ==
                                            "inbound"
                                        ? "Stock In"
                                        : "Stock Out",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    itemModel.transactionsList()[index].type ==
                                            "inbound"
                                        ? Icons.south
                                        : Icons.north,
                                    size: 36,
                                    color: itemModel
                                                .transactionsList()[index]
                                                .type ==
                                            "inbound"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "20/01/2022",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]);
                  }),
                );
              },
            );
    });
  }
}
