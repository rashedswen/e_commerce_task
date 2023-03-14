import 'dart:developer' as dev;
import 'dart:io';

import 'package:e_commerce_task/models/item.dart';
import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:e_commerce_task/views/transactions_list/widgets/e_commerce_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key, this.itemId}) : super(key: key);
  static const routeName = "/add_item";

  final int? itemId;

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _skuController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _image;

  @override
  Widget build(BuildContext context) {
    final heightSize = (MediaQuery.of(context).size.height -
        appBar().preferredSize.height -
        MediaQuery.of(context).padding.top);
    final widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(),
      body: Consumer<ItemsModel>(builder: (context, itemModel, child) {
        if (widget.itemId != null) {
          final item = itemModel.items.firstWhere(
              (element) => element.key == widget.itemId,
              orElse: () => Item(
                  name: "", price: 0, sku: "", description: "", image: ""));
          _nameController.text = item.name!;
          _priceController.text = item.price.toString();
          _skuController.text = item.sku!;
          _descriptionController.text = item.description!;
          _image = item.image;
        }
        return Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
          child: Column(
            children: [
              InputRow(nameController: _nameController, label: "Name"),
              const SizedBox(
                height: 16,
              ),
              InputRow(nameController: _priceController, label: "Price"),
              const SizedBox(
                height: 16,
              ),
              InputRow(nameController: _skuController, label: "SKU"),
              const SizedBox(
                height: 16,
              ),
              InputRow(
                  nameController: _descriptionController, label: "Description"),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Text(
                    "Image",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  _image != null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Image.file(File(_image!), fit: BoxFit.contain))
                      : TextButton(
                          onPressed: () async {
                            final image = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            // Check if the user canceled the picker
                            if (image == null) return;

                            // Get the image Path
                            final applicationDirectory =
                                await getApplicationDocumentsDirectory();
                            final path = applicationDirectory.path;
                            final fileName = basename(image.path);
                            final saveFilePath = "$path/$fileName";

                            await image.saveTo(saveFilePath);
                            dev.log(image.path);
                            setState(() {
                              _image = saveFilePath;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: const [
                                Icon(Icons.image),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Upload Image"),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
              const Spacer(),
              Consumer<ItemsModel>(builder: (context, itemModel, child) {
                return ElevatedButton(
                  child: const Text("Add Item"),
                  onPressed: () {
                    itemModel.addItem(
                      Item(
                        name: _nameController.text,
                        price: double.parse(_priceController.text),
                        sku: _skuController.text,
                        description: _descriptionController.text,
                        image: _image,
                      ),
                    );
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      }),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Add Item'),
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
            onChanged: (value) {},
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
