import 'package:e_commerce_task/models/item.dart';
import 'package:e_commerce_task/models/transaction.dart';
import 'package:e_commerce_task/util/const.dart';
import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:e_commerce_task/views/add_item/add_item.dart';
import 'package:e_commerce_task/views/add_item/add_transaction.dart';
import 'package:e_commerce_task/views/items_list/items_list.dart';
import 'package:e_commerce_task/views/transaction_details/details_screen_arguments.dart';
import 'package:e_commerce_task/views/transaction_details/transaction_details.dart';
import 'package:e_commerce_task/views/transactions_list/transactions_list_screen.dart';
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
        onGenerateRoute: (settings) {
          if (settings.name == TransactionsListScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) => const TransactionsListScreen(),
            );
          }
          if (settings.name == ItemsListScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) => const ItemsListScreen(),
            );
          }
          if (settings.name == AddTransactionScreen.routeName) {
            final args = settings.arguments as int?;

            return MaterialPageRoute(
              builder: (context) => AddTransactionScreen(
                transactionId: args,
              ),
            );
          }
          if (settings.name == AddItemScreen.routeName) {
            final args = settings.arguments as int;

            return MaterialPageRoute(
              builder: (context) => AddItemScreen(
                itemId: args,
              ),
            );
          }
          if (settings.name == TransactionDetails.routeName) {
            final args = settings.arguments as DetailsScreenArguments;

            return MaterialPageRoute(
              builder: (context) => TransactionDetails(
                transactionId: args.transactionId,
              ),
            );
          }
          return null;
        },
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const TransactionsListScreen(),
      ),
    );
  }
}
