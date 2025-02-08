import 'dart:async';
import 'dart:math';

import 'package:emotorad_assignment/core/entities/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(AppState(
            balance: 1000, canScratch: true, transactions: [], countDown: 0));

  Timer? _timer;
  int _remainingTime = 3600;

  void redeemItem(int newBalance, Transaction newTransaction) {
    emit(state.copyWith(
      balance: newBalance,
      transactions: List.from(state.transactions)..add(newTransaction),
    ));
  }

  void scratchCard() {
    if (state.canScratch) {
      int reward = Random().nextInt(451) + 50;
      final newTransaction = Transaction(
          id: DateTime.now().toString(),
          type: 'scratch',
          amount: reward,
          date: DateTime.now(),
          description: "You earned $reward coins from scratch card!");
      final newBalance = state.balance + reward;
      emit(state.copyWith(
          balance: newBalance,
          canScratch: false,
          transactions: List.from(state.transactions)..add(newTransaction)));
      nextCardCountDown();
    }
  }

  void nextCardCountDown() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        emit(state.copyWith(countDown: _remainingTime));
      } else {
        _timer?.cancel();
        _remainingTime = 3600; // Reset for next time
        emit(state.copyWith(canScratch: true, countDown: 0));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
