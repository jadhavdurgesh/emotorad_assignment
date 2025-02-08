import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/cubit/app_cubit.dart';
import 'features/history/history_screen.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/redemption/redemption_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
        title: 'Reward Coins',
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/redemption': (context) => const RedemptionStoreScreen(),
          '/history': (context) => const HistoryScreen(),
        },
      ),
    );
  }
}
