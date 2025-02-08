eMotorad Reward System App (Scratch Card)

Overview

The eMotorad Reward System App is a mobile application built using Flutter and Cubit for state management. The app features a scratch card functionality, where users can earn coins as rewards. Users can redeem their accumulated balance for various items. The app also maintains a transaction history and includes a countdown timer to manage how frequently users can scratch cards.

Features
	•	Scratch Card Interaction: Users can scratch a virtual card to earn coins.
	•	Reward System: Each successful scratch adds coins to the user’s balance.
	•	Transaction History: Every transaction is logged with details like the amount, type, and description.
	•	Countdown Timer: After each scratch, a countdown timer begins, restricting users from scratching again until it expires.

Technologies Used
	•	Flutter: The framework used to build the mobile app.
	•	Cubit (BLoC): State management solution used for handling the app’s business logic.
	•	Dart: The programming language used to build the app.

Installation

To run the app locally, follow the steps below:
	1.	Clone the repository:

git clone https://github.com/yourusername/emotorad-reward-system.git


	2.	Navigate to the project directory:

cd emotorad-reward-system


	3.	Install the dependencies:

flutter pub get


	4.	Run the app:

flutter run



How It Works

AppCubit Class

The AppCubit class is the heart of the app, responsible for managing the application’s state. It tracks the user’s balance, the scratch card’s availability, and the transaction history. The state is updated in response to user interactions like scratching a card or redeeming items.
	•	Initial State: The app starts with a balance of 1000 coins, a scratch card available, no transactions, and a countdown timer set to 0 seconds.
	•	Redeem Item: Users can redeem their rewards, and the transaction is added to the history, updating the balance accordingly.
	•	Scratch Card: When the user scratches a card, a random reward is generated, and the balance is updated. The scratch card is then disabled until the countdown finishes.
	•	Countdown Timer: After scratching the card, a countdown starts, preventing the user from scratching again until the time expires (set to 1 hour or 3600 seconds). Once the countdown reaches 0, the user can scratch again.
	•	Closing Timer: The timer is properly canceled when the app is closed to avoid memory leaks.

AppState

AppState is a data model that defines the current state of the app. It includes:
	•	balance: The user’s current balance in coins.
	•	canScratch: A boolean indicating if the user can scratch the card.
	•	transactions: A list of transactions, where each transaction logs details of rewards earned.
	•	countDown: The remaining time in seconds before the user can scratch again.

Usage
	1.	Start Scratching: Users can tap on the scratch card to reveal a reward.
	2.	View Rewards: After scratching, the user earns coins, which are added to the balance.
	3.	Transaction History: The app maintains a transaction history, logging every reward earned.
	4.	Countdown Timer: The user must wait for the countdown to finish before scratching again.

License

This project is licensed under the MIT License. See the LICENSE file for more details.

This version focuses on explaining the implementation and flow of the app, with proper formatting and no code snippets. Let me know if you need further adjustments!
