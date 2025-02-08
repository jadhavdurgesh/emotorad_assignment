import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entities/app_state.dart';
import '../../../../core/entities/transaction.dart';
import '../../core/cubit/app_cubit.dart';
import '../../core/entities/redeem_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entities/app_state.dart';
import '../../../../core/entities/transaction.dart';
import '../../core/cubit/app_cubit.dart';
import '../../core/entities/redeem_item.dart';

class RedemptionStoreScreen extends StatelessWidget {
  const RedemptionStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for redeemable items
    final redeemableItems = [
      RedeemableItem(
        name: 'Discount Coupon',
        cost: 200,
        description: 'Get 20% off on your next purchase!',
      ),
      RedeemableItem(
        name: 'Gift Card',
        cost: 500,
        description: 'Redeem for a \$10 gift card.',
      ),
      RedeemableItem(
        name: 'Free Item',
        cost: 1000,
        description: 'Get a free item from our store!',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Redemption Store'),
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: redeemableItems.length,
            itemBuilder: (context, index) {
              final item = redeemableItems[index];

              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.description),
                trailing: Text('${item.cost} coins'),
                onTap: () {
                  if (state.balance >= item.cost) {
                    // Successful redemption: Deduct coins and add transaction
                    final newBalance = state.balance - item.cost;
                    final newTransaction = Transaction(
                      id: DateTime.now().toString(),
                      type: 'Reward',
                      amount: -item.cost,
                      date: DateTime.now(),
                      description:
                          'Redeemed ${item.name} for ${item.cost} coins.',
                    );

                    context
                        .read<AppCubit>()
                        .redeemItem(newBalance, newTransaction);

                    // Show success dialog with redemption details
                    _showSuccessDialog(
                      context,
                      item.name,
                      item.cost,
                      newBalance,
                    );
                  } else {
                    // Insufficient balance: Show failure message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Insufficient Coins',)),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showSuccessDialog(
      BuildContext context, String itemName, int cost, int newBalance) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Redemption Successful!'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Item Redeemed: $itemName'),
              Text('Cost: $cost coins'),
              Text('Current Balance: $newBalance coins'),
              Text('Date: ${DateTime.now()}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
