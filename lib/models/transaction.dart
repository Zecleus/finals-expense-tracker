class TransactionModel {
  double expense;
  String title;
  DateTime? transDate;
  bool isAdded;

  TransactionModel({
    required this.expense,
    required this.title,
    required this.transDate,
    required this.isAdded,
  });
}
