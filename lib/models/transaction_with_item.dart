class TransactionWithItem {
  final int? transactionId;
  final String? name;
  final String? sku;
  final double? price;
  final String? type;
  final String? description;
  final int? quantity;
  final String? image;
  final DateTime? inbound;
  final DateTime? outbound;

  TransactionWithItem({
    this.transactionId,
    this.name,
    this.sku,
    this.price,
    this.type,
    this.description,
    this.image,
    this.inbound,
    this.outbound,
    this.quantity,
  });
}
