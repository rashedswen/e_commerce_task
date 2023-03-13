import 'package:e_commerce_task/models/item.dart';
import 'package:e_commerce_task/models/transaction.dart';
import 'package:e_commerce_task/util/const.dart';
import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:e_commerce_task/views/items_list/items_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(TransactionsAdapter());
  await Hive.openBox<Item>(itemsBox);
  await Hive.openBox<Transactions>(transactionsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemsModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const ItemsList(),
      ),
    );
  }
}
