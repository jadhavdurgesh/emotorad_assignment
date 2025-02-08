eMotorad Reward System App (Scratch Card)


https://github.com/user-attachments/assets/32bb7433-a95c-40e9-a90d-a0052b8620c8


Overview

The eMotorad Reward System App is a mobile application built using Flutter and Cubit for state management. This app allows users to earn rewards through a scratch card feature. Users can accumulate coins in their balance, view transaction history, and redeem their balance for various items.

The app includes a countdown timer to limit the frequency of scratching cards, ensuring fairness and balance in the reward system.

Features
	•	Scratch Card Interaction: Users can earn coins by scratching a virtual card.
	•	Reward System: Coins are added to the user’s balance after each successful scratch.
	•	Transaction History: The app logs all transactions, showing details such as amount, type, and description.
	•	Countdown Timer: After each scratch, a timer counts down before the user can scratch again.

Technologies Used
	•	Flutter: The framework used to build the mobile app.
	•	Cubit (BLoC): A state management solution to handle business logic and state updates.
	•	Dart: The programming language used for building the app.

Installation

To run the app locally, follow these steps:
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

The AppCubit class manages the state of the app, which includes the balance, the scratch card’s availability, and transaction history. Here’s a breakdown of its functionality:
	•	Initial State: The app starts with a balance of 1000 coins, a scratch card available for use, an empty transaction history, and a countdown timer set to 0.
	•	Redeem Item: Users can redeem their coins. This updates the balance and logs the transaction in the history.
	•	Scratch Card: When users scratch the card, they receive a random reward (between 50 to 500 coins). The balance is updated, and the scratch card becomes unavailable until the countdown timer expires.
	•	Countdown Timer: After scratching the card, a countdown starts, and the user cannot scratch again until the timer reaches zero (set to 3600 seconds, or 1 hour). Once the countdown expires, the scratch card becomes available again.
	•	Timer Management: The countdown timer is managed and properly canceled when the app is closed to prevent memory leaks.

AppState

AppState is a data model that holds the current state of the application. It includes:
	•	balance: The user’s current coin balance.
	•	canScratch: A boolean flag indicating if the user can scratch the card.
	•	transactions: A list of transactions, each recording a reward earned.
	•	countDown: The time remaining before the user can scratch the card again.

Usage
	1.	Scratch a Card: Users tap on the scratch card to reveal a random reward.
	2.	View Rewards: After scratching, the earned coins are added to the user’s balance.
	3.	Transaction History: The app logs each scratch and its reward in the transaction history.
	4.	Countdown: Users must wait for the countdown to expire before they can scratch again.

License

This project is licensed under the MIT License. See the LICENSE file for more details.

This is now ready to be used as a README file on GitHub, structured with proper headings and clean formatting. Let me know if you need further adjustments!
