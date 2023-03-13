import 'dart:io';

import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:e_commerce_task/views/add_item/add_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightSize = (MediaQuery.of(context).size.height -
        appBar(context).preferredSize.height -
        MediaQuery.of(context).padding.top);
    final widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(context),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: heightSize,
              width: widthSize,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 9,
                    child: Consumer<ItemsModel>(
                        builder: (context, itemModel, child) {
                      itemModel.getItems();
                      return ListView.builder(
                        itemCount: itemModel.items.length,
                        itemBuilder: (_, index) {
                          final isHaveImage =
                              (itemModel.items[index].image != null &&
                                  itemModel.items[index].image!.isNotEmpty);
                          return Container(
                            width: widthSize,
                            height: 120,
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                            child: Text(
                                                "${itemModel.items[index].name}")),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        FittedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${itemModel.items[index].sku}"),
                                              Text(
                                                  "${itemModel.items[index].description}"),
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
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          );
                        },
                      );
                    }),
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
                      child: Consumer<ItemsModel>(builder: (_, itemModel, __) {
                        return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddItemScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add, size: 20),
                                SizedBox(width: 4),
                                Text("Add Item",
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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
