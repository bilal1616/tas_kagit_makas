import 'package:flutter/foundation.dart';
import 'package:rock_paper_scissors/models/player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameProvider with ChangeNotifier {
  Player player1 = Player(name: "Player 1");
  Player player2 = Player(name: "Player 2");

  String? player1Choice;
  String? player2Choice;

  Future<void> loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    player1.score = prefs.getInt('player1_score') ?? 0;
    player2.score = prefs.getInt('player2_score') ?? 0;
    notifyListeners();
  }

  Future<void> saveScores() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('player1_score', player1.score);
    prefs.setInt('player2_score', player2.score);
  }

  void updatePlayerNames(String name1, String name2) {
    player1.name = name1;
    player2.name = name2;
    notifyListeners();
  }

  void resetScores() {
    player1.score = 0;
    player2.score = 0;
    saveScores();
    notifyListeners();
  }

  void makeChoice(String choice, int playerNumber) {
    if (playerNumber == 1) {
      player1Choice = choice;
    } else {
      player2Choice = choice;
    }

    if (player1Choice != null && player2Choice != null) {
      _calculateScore();
    }
  }

  void _calculateScore() {
    if (player1Choice == player2Choice) {
      // Beraberlik durumu
    } else if ((player1Choice == 'rock' && player2Choice == 'scissors') ||
               (player1Choice == 'scissors' && player2Choice == 'paper') ||
               (player1Choice == 'paper' && player2Choice == 'rock')) {
      player1.score++;
    } else {
      player2.score++;
    }

    player1Choice = null;
    player2Choice = null;
    saveScores();
    notifyListeners();
  }
}
