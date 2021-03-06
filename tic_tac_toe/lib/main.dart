import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tic_tac_toe/board/board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: "Tic Tac Toe",
      color: Colors.white,
      darkTheme: neumorphicDefaultTheme,
      home: SafeArea(child: Board()),
    );
  }
}
