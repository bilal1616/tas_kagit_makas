import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_paper_scissors/provider/game_provider.dart';

class GameScreen extends StatelessWidget {
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Taş Kağıt Makas Oyunu'),
        titleTextStyle: TextStyle(
            color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField('1. Oyuncu İsmi', player1Controller),
              SizedBox(height: 10),
              _buildTextField('2. Oyuncu İsmi', player2Controller),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Text(
                '${gameProvider.player1.name}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ChoiceButton(
                    label: 'Taş',
                    imagePath: 'assets/rock.png',
                    onPressed: () => gameProvider.makeChoice('rock', 1),
                  ),
                  ChoiceButton(
                    label: 'Kağıt',
                    imagePath: 'assets/paper.png',
                    onPressed: () => gameProvider.makeChoice('paper', 1),
                  ),
                  ChoiceButton(
                    label: 'Makas',
                    imagePath: 'assets/scissors.png',
                    onPressed: () => gameProvider.makeChoice('scissors', 1),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                '${gameProvider.player2.name}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ChoiceButton(
                    label: 'Taş',
                    imagePath: 'assets/rock.png',
                    onPressed: () => gameProvider.makeChoice('rock', 2),
                  ),
                  ChoiceButton(
                    label: 'Kağıt',
                    imagePath: 'assets/paper.png',
                    onPressed: () => gameProvider.makeChoice('paper', 2),
                  ),
                  ChoiceButton(
                    label: 'Makas',
                    imagePath: 'assets/scissors.png',
                    onPressed: () => gameProvider.makeChoice('scissors', 2),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Text(
                '${gameProvider.player1.name}: ${gameProvider.player1.score}',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              Text(
                '${gameProvider.player2.name}: ${gameProvider.player2.score}',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        gameProvider.updatePlayerNames(
                          player1Controller.text,
                          player2Controller.text,
                        );
                      },
                      child: Text('Oyunu Başlat', textAlign: TextAlign.center),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        player1Controller.clear();
                        player2Controller.clear();
                        gameProvider.updatePlayerNames('Player 1', 'Player 2');
                      },
                      child: Text('Bilgileri Sıfırla',
                          textAlign: TextAlign.center),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: gameProvider.resetScores,
                      child: Text('Skoru Sıfırla', textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  ChoiceButton({required this.label, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 70,
            height: 70,
          ),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
      splashColor: Colors.black.withAlpha(50), // Tıklanma efekti
      borderRadius: BorderRadius.circular(12), // Köşeleri yuvarlatma
    );
  }
}
