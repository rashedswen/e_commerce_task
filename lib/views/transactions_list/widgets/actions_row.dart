import 'package:e_commerce_task/models/item.dart';
import 'package:e_commerce_task/models/transaction.dart';
import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionsRow extends StatelessWidget {
  const ActionsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ItemsModel>(builder: (context, itemModel, child) {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  itemModel.addTransaction(Transactions(
                    id: 1,
                    type: "outbound",
                    quantity: 6,
                    inboudAt: null,
                    outboundAt: DateTime.now(),
                    itemId: "2",
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.north, size: 20),
                      SizedBox(width: 4),
                      Text("Send", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  itemModel.addTransaction(Transactions(
                    id: 1,
                    type: "inbound",
                    quantity: 6,
                    inboudAt: DateTime.now(),
                    outboundAt: DateTime.now().add(const Duration(days: 1)),
                    itemId: "2",
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.south,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text("Receive", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
