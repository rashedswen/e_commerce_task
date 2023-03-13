import 'package:e_commerce_task/models/item.dart';
import 'package:e_commerce_task/models/transaction.dart';
import 'package:e_commerce_task/util/const.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<Item> getItemsBox() {
    return Hive.box<Item>(itemsBox);
  }

  static Box<Transactions> getTransactionsBox() {
    return Hive.box<Transactions>(transactionsBox);
  }
}
