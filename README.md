eMotorad Reward System App (Scratch Card)

Overview

The eMotorad Reward System App is built using Flutter with Cubit for state management, providing users with a scratch card experience. Users can earn rewards (coins) through a scratch card feature and redeem items using accumulated balance. This app manages the user’s balance, transactions, and provides a countdown timer before the next scratch card can be used.

Features
	•	Scratch Card Interaction: Users can scratch a card to reveal a reward.
	•	Reward System: Points (coins) are accumulated in the user’s balance after each scratch.
	•	Transaction History: Each reward earned is recorded as a transaction, which can be accessed by the user.
	•	Countdown Timer: A countdown is triggered after each scratch, preventing users from scratching again until the timer resets.

Technologies Used
	•	Flutter: For building the mobile application.
	•	Cubit (BLoC): For managing the application’s state and business logic.
	•	Dart: Programming language for Flutter.

Installation

To get the app up and running locally, follow these steps:
	1.	Clone the repository:

git clone https://github.com/yourusername/emotorad-reward-system.git


	2.	Navigate to the project directory:

cd emotorad-reward-system


	3.	Install dependencies:

flutter pub get


	4.	Run the app:

flutter run



How It Works

AppCubit Class

The AppCubit is the central class that manages the state of the app. It extends from Cubit<AppState> and maintains the user’s balance, transactions, scratch card status, and countdown timer.
	1.	Initial State:
The initial state of the app is set with a balance of 1000 coins, an available scratch card, an empty list of transactions, and a countdown of 0 seconds.

AppCubit()
   : super(AppState(
         balance: 1000, canScratch: true, transactions: [], countDown: 0));


	2.	Redeem Item:
The redeemItem() method allows users to redeem their balance by passing a new balance and creating a new transaction that is added to the transaction history.

void redeemItem(int newBalance, Transaction newTransaction) {
  emit(state.copyWith(
    balance: newBalance,
    transactions: List.from(state.transactions)..add(newTransaction),
  ));
}


	3.	Scratch Card:
The scratchCard() method triggers the scratch card interaction. When the user scratches the card, a random reward (between 50 to 500 coins) is generated. A new transaction is created with the reward, and the balance is updated. Additionally, the scratch card becomes unavailable until the countdown is completed.

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


	4.	Countdown Timer:
The nextCardCountDown() method controls the countdown for the next scratch card. Once the user scratches the card, the countdown starts, and the user can’t scratch again until the countdown reaches zero (which is set to 3600 seconds, i.e., 1 hour). The countdown is displayed on the UI, and once it reaches 0, the scratch card becomes available again.

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


	5.	Closing the Timer:
The _timer is canceled when the Cubit is closed to avoid memory leaks and unnecessary processing.

@override
Future<void> close() {
  _timer?.cancel();
  return super.close();
}



AppState

AppState represents the state of the app and includes the following properties:
	•	balance: The user’s current balance.
	•	canScratch: A boolean indicating whether the user can scratch the card.
	•	transactions: A list of transactions related to rewards earned.
	•	countDown: The remaining time (in seconds) before the user can scratch again.

The state is updated and emitted using the emit() method, which triggers UI updates.

Usage
	1.	Start Scratching: Tap on the scratch card to reveal a random reward (coins).
	2.	View Rewards: After scratching, the app displays the reward (coins) and adds it to the user’s balance.
	3.	Transaction History: The transaction is logged and can be viewed in the user’s transaction history.
	4.	Countdown: Once the user scratches the card, a countdown starts before they can scratch again.

License

MIT License. See the LICENSE file for more details.

This updated version is now focused purely on the current functionality and doesn’t include any suggestions for future improvements. It describes how the app works, especially the scratch card and reward system. Let me know if you need any further edits!
