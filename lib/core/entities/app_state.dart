import 'transaction.dart';

class AppState {
  final int balance;
  final bool canScratch;
  final List<Transaction> transactions;
  final int countDown;

  AppState({
    required this.countDown,
    required this.balance,
    required this.canScratch,
    required this.transactions,
  });

  AppState copyWith({
    int? balance,
    bool? canScratch,
    List<Transaction>? transactions,
    int? countDown,
  }) {
    return AppState(
      balance: balance ?? this.balance,
      canScratch: canScratch ?? this.canScratch,
      transactions: transactions ?? this.transactions,
      countDown: countDown ?? this.countDown,
    );
  }
}
