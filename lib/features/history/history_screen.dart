import 'package:emotorad_assignment/core/cubit/app_cubit.dart';
import 'package:emotorad_assignment/core/entities/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/entities/transaction.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final transaction = state.transactions.reversed.toList();
          return ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              final transactions = transaction[index];
              return ListTile(
                title: Text(transactions.description),
                subtitle: Text(DateFormat.yMMMd().format(transactions.date)),
                trailing: Text(
                  '${transactions.amount} coins',
                  style: TextStyle(
                    color:
                        transactions.type == 'scratch' ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
