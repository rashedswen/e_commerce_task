import 'package:e_commerce_task/models/item.dart';
import 'package:e_commerce_task/models/transaction.dart';
import 'package:e_commerce_task/util/boxes.dart';
import 'package:e_commerce_task/util/const.dart';
import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ItemsModel])
void main() {
  setUpAll(() async {
    Hive.init("test");
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(TransactionsAdapter());
    await Hive.openBox<Item>(itemsBox);
    await Hive.openBox<Transactions>(transactionsBox);
  });

  group("CRUD Operations Hive ", () {
    test("insert Into Hive Items", () {
      final item = Item(
        id: 1,
        name: "name",
        price: 1,
        sku: "sku",
        image: "image",
      );
      final box = Hive.box<Item>(itemsBox);
      box.add(item);
      expect(box.length, 1);
    });

    test("insert More 3 Items Into Hive", () {
      final item = Item(
        id: 1,
        name: "name",
        price: 1,
        sku: "sku",
        image: "image",
      );
      final item2 = Item(
        id: 2,
        name: "name2",
        price: 2,
        sku: "sku2",
        image: "image2",
      );
      final item3 = Item(
        id: 3,
        name: "name3",
        price: 3,
        sku: "sku3",
        image: "image3",
      );
      final box = Hive.box<Item>(itemsBox);
      box.add(item);
      box.add(item2);
      box.add(item3);
      expect(box.length, 3);
    });

    test("delete Item From Hive", () {
      final item = Item(
        id: 1,
        name: "name",
        price: 1,
        sku: "sku",
        image: "image",
      );
      final box = Hive.box<Item>(itemsBox);
      box.add(item);
      box.deleteAt(0);
      expect(box.length, 0);
    });
    tearDown(() {
      Boxes.getItemsBox().clear();
      Boxes.getTransactionsBox().clear();
    });
  });

  group('ItemsModel', () {
    ItemsModel itemsModel = ItemsModel();

    setUp(() {
      // Reset the items model before each test
      itemsModel = ItemsModel();
    });

    test('getItems() should return an empty list when there are no items', () {
      expect(itemsModel.getItems(), []);
    });

    test('addItem() should add an item to the items list', () {
      final item = Item(
          name: 'Test Item',
          sku: 'SKU123',
          price: 10.0,
          description: 'This is a test item');

      itemsModel.addItem(item);
      itemsModel.getItems();
      expect(itemsModel.items.length, 1);
    
      expect(itemsModel.items.first.name, 'Test Item');
    });

    test('removeItem() should remove an item from the items list', () {
      final item = Item(
          name: 'Test Item',
          sku: 'SKU123',
          price: 10.0,
          description: 'This is a test item');
      itemsModel.addItem(item);

      itemsModel.removeItem(item);

      expect(itemsModel.items.length, 0);
    });

    test(
        'getTransactions() should return an empty list when there are no transactions',
        () {
      expect(itemsModel.transactions, []);
    });

    test('addTransaction() should add a transaction to the transactions list',
        () {
      final transaction =
          Transactions(itemId: "1", type: "inbound", quantity: 5);

      itemsModel.addTransaction(transaction);
      
      itemsModel.getTransactions();
      expect(itemsModel.transactions.length, 1);
      expect(itemsModel.transactions.first.itemId!, "1");
    });

    test(
        'removeTransaction() should remove a transaction from the transactions list',
        () {
      final transaction =
          Transactions(itemId: "1", type: "inbound", quantity: 5);
      itemsModel.addTransaction(transaction);

      itemsModel.removeTransaction(transaction);

      expect(itemsModel.transactions.length, 0);
    });

    tearDown(() {
      Boxes.getItemsBox().clear();
      Boxes.getTransactionsBox().clear();
    });
  });
}
