import 'dart:io';

import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:e_commerce_task/views/add_item/add_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    super.key,
    required this.widthSize,
  });

  final double widthSize;

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsModel>(builder: (context, itemModel, child) {
      itemModel.getItems();
      return ListView.builder(
        itemCount: itemModel.items.length,
        itemBuilder: (_, index) {
          final isHaveImage = (itemModel.items[index].image != null &&
              itemModel.items[index].image!.isNotEmpty);
          return TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddItemScreen.routeName,
                  arguments: itemModel.items[index].key);
            },
            child: Container(
              width: widthSize,
              height: 120,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Expanded(
                  flex: 2,
                  child: isHaveImage
                      ? Image.file(
                          File(itemModel.items[index].image!),
                          fit: BoxFit.contain,
                        )
                      : Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(child: Text("${itemModel.items[index].name}")),
                      const SizedBox(
                        height: 8,
                      ),
                      FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${itemModel.items[index].sku}"),
                            Text("${itemModel.items[index].description}"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      FittedBox(
                        child: Text(
                          "${itemModel.items[index].price} SAR",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      );
    });
  }
}
