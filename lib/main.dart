import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_paper_scissors/provider/game_provider.dart';
import 'package:rock_paper_scissors/screens/game_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameProvider()..loadScores(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}
