import 'package:emotorad_assignment/core/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/app_state.dart';
import '../../widget/scartch_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showScratchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ScratchCardDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60.0, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  state.balance.toString() + " Coins",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Get your hourly rewards",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap:
                    state.canScratch ? () => _showScratchDialog(context) : null,
                child: Container(
                  width: 400,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: state.canScratch ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    state.canScratch
                        ? "Tap to Scratch!"
                        : "${(state.countDown ~/ 60)}:${(state.countDown % 60)} seconds left",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     context.read<AppCubit>().scratchCard();
              //   },
              //   child: Container(
              //     width: 400,
              //     height: 100,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Text(
              //       state.canScratch
              //           ? "You can scratch now"
              //           : (state.countDown ~/ 60).toString() +
              //               ":" +
              //               (state.countDown % 60).toString() +
              //               " seconds left",
              //       style: TextStyle(fontSize: 20),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 80,
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/redemption');
                  },
                  child: Text("Coupons Store")),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/history');
                  },
                  child: Text("Check History")),
            ],
          ),
        );
      }),
    );
  }
}
