import 'dart:collection';

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
    if (transaction.id != null) {
      Boxes.getTransactionsBox().put(transaction.id, transaction);
    } else {
      Boxes.getTransactionsBox().add(transaction);
    }
    notifyListeners();
  }

  void removeTransaction(Transactions transaction) {
    Boxes.getTransactionsBox().delete(transaction.key);
    notifyListeners();
  }

  // Items Section

  List<Item> _items = [];

  UnmodifiableListView<Item> get items {
    return UnmodifiableListView(_items);
  }

  List<Item> getItems() {
    return _items = Boxes.getItemsBox().values.toList();
  }

  void addItem(Item item) {
    if (item.id != null) {
      Boxes.getItemsBox().put(item.id, item);
    } else {
      Boxes.getItemsBox().add(item);
    }
    notifyListeners();
  }

  void removeItem(Item item) {
    Boxes.getItemsBox().delete(item.key);
    notifyListeners();
  }

  List<TransactionWithItem> transactionsList({String productName = ""}) {
    getTransactions();
    final s = Boxes.getTransactionsBox().values.map((transaction) {
      final item = Boxes.getItemsBox().values.firstWhere(
        (element) {
          element.name == _productName;
          return element.key.toString() == transaction.itemId.toString();
        },
      );

      return TransactionWithItem(
        transactionId: (transaction.key as int),
        type: transaction.type,
        name: item.name,
        sku: item.sku,
        price: item.price,
        quantity: transaction.quantity,
        description: item.description,
        inbound: transaction.inboudAt,
        outbound: transaction.outboundAt,
      );
    }).toList();

    _transactionsWithItem = _productName.isNotEmpty
        ? s
            .where((value) {
              if (value.name == null) return false;
              return value.name!
                  .toLowerCase()
                  .contains(_productName.toLowerCase());
            })
            .toList()
            .where((element) {
              if (element.type == null) return false;
              return element.type!.toLowerCase() == _type.toLowerCase();
            })
            .toList()
        : _type.isNotEmpty
            ? s
                .where((element) => element.type!.toLowerCase() == _type)
                .toList()
            : s;
    return _transactionsWithItem;
  }

  String _productName = "";

  void searchTransactions(String productName) {
    _productName = productName;
    notifyListeners();
  }

  String _type = "";
  String _sortBy = "";

  void sortTransactions(String type, String sortBy) {
    _sortBy = sortBy;
    _type = type;
    if (type == "inbound") {
      _transactionsWithItem
          .where((element) => element.type!.toLowerCase() == "inbound");
    }
    if (type == "outbound") {
      _transactionsWithItem
          .where((element) => element.type!.toLowerCase() == "outbound");
    }
    if (sortBy == "quantityAsec") {
      _transactionsWithItem
          .sort((a, b) => a.quantity!.compareTo(b.transactionId!));
    } else if (sortBy == "quantityDesc") {
      _transactionsWithItem
          .sort((a, b) => b.quantity!.compareTo(a.transactionId!));
    } else if (sortBy == "dateAsec") {
      _transactionsWithItem.sort((a, b) => a.outbound!.compareTo(b.inbound!));
    } else if (sortBy == "dateDesc") {
      _transactionsWithItem.sort((a, b) => b.outbound!.compareTo(a.inbound!));
    }
    notifyListeners();
  }

  TransactionWithItem getTransactionWithItem(int transactionId) {
    final transaction = Boxes.getTransactionsBox().get(transactionId);
    final item = Boxes.getItemsBox().get(int.parse(transaction!.itemId!));
    return TransactionWithItem(
      type: transaction.type,
      name: item?.name,
      sku: item?.sku,
      price: item?.price,
      quantity: transaction.quantity,
      description: item?.description,
      inbound: transaction.inboudAt,
      outbound: transaction.outboundAt,
      image: item?.image,
    );
  }
}
