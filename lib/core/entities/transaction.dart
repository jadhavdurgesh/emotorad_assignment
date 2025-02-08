class Transaction {
  final String id;
  final String type;
  final int amount;
  final DateTime date;
  final String description;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
  });
}
