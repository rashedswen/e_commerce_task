import 'dart:io';

import 'package:e_commerce_task/models/transaction_with_item.dart';
import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({Key? key, required this.transactionId})
      : super(key: key);

  static const routeName = "/transaction_details";

  final int transactionId;

  @override
  Widget build(BuildContext context) {
    final heightSize = (MediaQuery.of(context).size.height -
        appBar().preferredSize.height -
        MediaQuery.of(context).padding.top);
    final widthSize = MediaQuery.of(context).size.width;
    return Consumer<ItemsModel>(builder: (_, itemsModel, __) {
      final TransactionWithItem transaction =
          itemsModel.getTransactionWithItem(transactionId);
      final isInbound = transaction.type == "inbound";
      return Scaffold(
        appBar: appBar(),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: widthSize,
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: transaction.image == null
                                ? Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                  )
                                : Image.file(
                                    File(transaction.image!),
                                    fit: BoxFit.contain,
                                  )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                  child: Text("${transaction.name}",
                                      style: const TextStyle(fontSize: 24))),
                              const SizedBox(
                                height: 8,
                              ),
                              const Spacer(),
                              FittedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${transaction.sku}",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 18)),
                                    Text("${transaction.description}",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 18)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Consumer<ItemsModel>(builder: (_, itemModel, __) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextColumn(
                            label: "Quantity",
                            value: itemModel
                                .getTransactionWithItem(1)
                                .quantity
                                .toString(),
                          ),
                        ),
                        Expanded(
                          child: TextColumn(
                            label: "Price",
                            value: "${transaction.price} SAR",
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(isInbound ? "Stock In" : "Stock Out"),
                            Icon(isInbound ? Icons.south : Icons.north,
                                size: 36,
                                color: isInbound ? Colors.green : Colors.red),
                          ],
                        ))
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 24,
                  ),
                  StateDate(
                    title: "Inbound",
                    date: transaction.inbound,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StateDate(
                    title: "Outbound",
                    date: transaction.outbound,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Transaction Details'),
      centerTitle: true,
    );
  }
}

class StateDate extends StatelessWidget {
  const StateDate({
    super.key,
    required this.title,
    this.date,
  });

  final String title;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    if (date == null) {
      return Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 20)),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: const [
              Expanded(
                child: TextColumn(
                  label: "Date",
                  value: "Not Set",
                ),
              ),
              Expanded(
                child: TextColumn(
                  label: "Time",
                  value: "Not Set",
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 20)),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: TextColumn(
                  label: "Date", value: DateFormat('dd/MM/yyyy').format(date!)),
            ),
            Expanded(
              child: TextColumn(
                label: "Time",
                value: DateFormat('hh:mm a').format(date!),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        Text(label),
      ],
    );
  }
}
