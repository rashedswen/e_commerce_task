import 'package:e_commerce_task/views/add_item/add_item.dart';
import 'package:e_commerce_task/views/items_list/widgets/e_commerce_button.dart';
import 'package:e_commerce_task/views/items_list/widgets/items_list.dart';
import 'package:flutter/material.dart';

class ItemsListScreen extends StatelessWidget {
  const ItemsListScreen({Key? key}) : super(key: key);

  static const routeName = "/items_list";

  @override
  Widget build(BuildContext context) {
    final heightSize = (MediaQuery.of(context).size.height -
        appBar(context).preferredSize.height -
        MediaQuery.of(context).padding.top);
    final widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(context),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SizedBox(
            height: heightSize,
            width: widthSize,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: ItemsList(widthSize: widthSize),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: EcommerceButton(
                      label: "Add Item",
                      icon: Icons.add,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AddItemScreen.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Items'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddItemScreen(),
              ),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
      centerTitle: true,
    );
  }
}
