import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:e_commerce_task/views/add_item/add_transaction.dart';
import 'package:e_commerce_task/views/items_list/widgets/e_commerce_button.dart';
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
              child: EcommerceButton(
                label: "Send",
                icon: Icons.north,
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddTransactionScreen.routeName);
                },
              ) 
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: EcommerceButton(
                label: "Receive",
                color: Colors.green,
                icon: Icons.south,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddTransactionScreen.routeName);
                },
              ) 
            ),
          ],
        );
      }),
    );
  }
}
