import 'dart:developer';

import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:e_commerce_task/views/add_item/add_transaction.dart';
import 'package:e_commerce_task/views/transaction_details/details_screen_arguments.dart';
import 'package:e_commerce_task/views/transaction_details/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              itemCount: itemModel.transactionsList().length,
              itemBuilder: (_, index) {
                final transactionItem = itemModel.transactionsList()[index];
                return TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        TransactionDetails.routeName,
                        arguments: DetailsScreenArguments(itemModel
                            .transactionsList()[index]
                            .transactionId!));
                  },
                  child: Container(
                    width: widthSize,
                    height: heightSize * 0.2,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Row(children: [
                        FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${transactionItem.name}"),
                              const SizedBox(
                                height: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${transactionItem.sku}"),
                                  Text(
                                      "${transactionItem.quantity} x ${transactionItem.description}"),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${transactionItem.price} SR",
                                style: const TextStyle(
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
                                      itemModel
                                                  .transactionsList()[index]
                                                  .type ==
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
                                      itemModel
                                                  .transactionsList()[index]
                                                  .type ==
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
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          AddTransactionScreen.routeName,
                                          arguments: itemModel
                                              .transactionsList()[index]
                                              .transactionId!);
                                    },
                                    child: const Text("Edit")),
                                Text(
                                  itemModel.transactionsList()[index].type ==
                                          "inbound"
                                      ? DateFormat('dd-MM-yyyy')
                                          .format(transactionItem.inbound!)
                                      : DateFormat('dd-MM-yyyy')
                                          .format(transactionItem.outbound!),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]);
                    }),
                  ),
                );
              },
            );
    });
  }
}
