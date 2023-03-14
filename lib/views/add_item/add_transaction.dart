import 'dart:developer';

import 'package:e_commerce_task/models/transaction.dart';
import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:e_commerce_task/views/transactions_list/widgets/e_commerce_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key, this.transactionId}) : super(key: key);

  static const routeName = "/addTransaction";

  final int? transactionId;

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  String _typeController = "inbound";
  final _quantityController = TextEditingController();

  int itemId = 0;
  int selectedItemId = 0;
  DateTime? inboundDate ;
  DateTime? outboundDate;

  @override
  Widget build(BuildContext context) {
    final heightSize = (MediaQuery.of(context).size.height -
        appBar().preferredSize.height -
        MediaQuery.of(context).padding.top);
    final widthSize = MediaQuery.of(context).size.width;

    if (widget.transactionId != null && _quantityController.text.isEmpty) {
      final transaction = context.read<ItemsModel>().transactions.firstWhere(
          (element) => element.key == widget.transactionId,
          orElse: () => Transactions(type: "", quantity: 0, itemId: ""));
      _typeController = transaction.type!;
      _quantityController.text = transaction.quantity.toString();
      itemId = int.parse(transaction.itemId!);
      outboundDate = transaction.outboundAt;
      inboundDate = transaction.inboudAt;
      log("recall");
    }
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ItemsModel>(builder: (context, itemModel, child) {
                itemModel.getItems();
                return itemModel.items.isEmpty
                    ? const Center(
                        child: Text("No Items"),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: itemModel.items.length,
                        itemBuilder: (_, index) {
                          final isSelected =
                              itemId == itemModel.items[index].key;
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                selectedItemId = index;
                                itemId = (itemModel.items[index].key as int);
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                    height: heightSize * 0.05,
                                    decoration: BoxDecoration(
                                      color: !isSelected
                                          ? Colors.white
                                          : Colors.amber,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                    ),
                                    child: Center(
                                        child: Text(
                                            itemModel.items[index].name!))),
                                const SizedBox(
                                  height: 8,
                                )
                              ],
                            ),
                          );
                        });
              }),
            ),
            DropdownButton<String>(
              items: const [
                DropdownMenuItem(
                  value: "inbound",
                  child: Text("inbound"),
                ),
                DropdownMenuItem(
                  value: "outbound",
                  child: Text("outbound"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _typeController = value.toString();
                });
              },
              hint: const Text("Select Type"),
              value: _typeController,
            ),
            InputRow(nameController: _quantityController, label: "quantity"),
            const SizedBox(
              height: 16,
            ),
            const Spacer(),
            Consumer<ItemsModel>(builder: (_, itemModel, __) {
              return ElevatedButton(
                child: const Text("Add Item"),
                onPressed: () {
                  final transaction = Transactions(
                    id: widget.transactionId,
                    itemId: itemId.toString(),
                    type: _typeController,
                    inboudAt: _typeController.trim() == "inbound"
                        ? DateTime.now()
                        : inboundDate,
                    outboundAt: _typeController.trim() == "outbound"
                        ? DateTime.now()
                        : outboundDate,
                    quantity: int.parse(_quantityController.text),
                  );
                  log("${itemId}add");
                  log("${transaction.itemId}add");
                  itemModel.addTransaction(transaction);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Add Transaction'),
      centerTitle: true,
    );
  }
}

class InputRow extends StatelessWidget {
  const InputRow({
    super.key,
    required TextEditingController nameController,
    required this.label,
  }) : _nameController = nameController;

  final TextEditingController _nameController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: EcommerceField(
            label: label,
            controller: _nameController,
            onChanged: (value) {
              
            },
          ),
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
