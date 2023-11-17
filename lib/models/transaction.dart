class Transaction {
  int? id;
  String description;
  final double amount;
  String type;

  Transaction({
    this.id,
    required this.description,
    required this.amount,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount.toDouble(),
      'type': type,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      description: map['description'],
      amount: map['amount'].toDouble(),
      type: map['type'],
    );
  }

}
