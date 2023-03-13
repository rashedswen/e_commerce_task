import 'dart:collection';
import 'dart:developer';

import 'package:e_commerce_task/models/item.dart';
import 'package:e_commerce_task/models/transaction.dart';
import 'package:e_commerce_task/models/transaction_with_item.dart';
import 'package:e_commerce_task/util/boxes.dart';
import 'package:flutter/foundation.dart';

class ItemsModel extends ChangeNotifier {
  // Transactions Section
  List<Transactions> _transactions = [];

  UnmodifiableListView<Transactions> get transactions {
    return UnmodifiableListView(_transactions);
  }

  List<TransactionWithItem> _transactionsWithItem = [];

  UnmodifiableListView<TransactionWithItem> get transactionsWithItem {
    return UnmodifiableListView(_transactionsWithItem);
  }

  void getTransactions() {
    _transactions = Boxes.getTransactionsBox().values.toList();
  }

  void addTransaction(Transactions transaction) {
    final transactionsss = transaction;
    Boxes.getTransactionsBox().add(transaction);
    notifyListeners();
  }

  void removeTransaction(Transactions transaction) {
    Boxes.getTransactionsBox().delete(transaction);
    notifyListeners();
  }

  // Items Section

  List<Item> _items = [];

  UnmodifiableListView<Item> get items {
    return UnmodifiableListView(_items);
  }

  void getItems() {
    _items = Boxes.getItemsBox().values.toList();
  }

  void addItem(Item item) async {
    final id = await Boxes.getItemsBox().add(item);
    log(id.toString());
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  List<TransactionWithItem> transactionsList() {
    getTransactions();
    final s = Boxes.getTransactionsBox().values.map((transaction) {
      log("${transaction.quantity} quantity");
      final item = Boxes.getItemsBox().values.firstWhere(
        (element) {
          log("${element.key}item");
          log("${transaction.itemId} Transaction");
          log(transaction.itemId.toString());
          log((element.key == transaction.itemId).toString());
          return element.key.toString() == transaction.itemId;
        },
      );
      log(transaction.type!);

      return TransactionWithItem(
          type: transaction.type,
          name: item.name,
          sku: item.sku,
          price: item.price,
          inbound: transaction.type == "inbound"
              ? transaction.inboudAt
              : transaction.outboundAt);
    }).toList();

    _transactionsWithItem = s;
    return s;
  }
}
