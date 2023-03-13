import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 2)
class Transactions extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? type;
  @HiveField(2)
  final String? itemId;
  @HiveField(3)
  final int? quantity;
  @HiveField(4)
  final DateTime? inboudAt;
  @HiveField(5)
  final DateTime? outboundAt;

  Transactions({
    this.id,
    this.type,
    this.itemId,
    this.quantity,
    this.inboudAt,
    this.outboundAt,
  });
}
