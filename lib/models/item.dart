import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final double? price;
  @HiveField(3)
  final String? sku;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final String? image;

  Item({
    this.id,
    this.name,
    this.price,
    this.sku,
    this.description,
    this.image,
  });
}
