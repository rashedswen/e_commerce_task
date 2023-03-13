class TransactionWithItem {
  final String? name;
  final String? sku;
  final double? price;
  final String? type;
  final DateTime? inbound;
  final DateTime? outbound;

  TransactionWithItem({
    this.name,
    this.sku,
    this.price,
    this.type,
    this.inbound,
    this.outbound,
  });
}
