import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_state/game_state.dart';
import 'package:tic_tac_toe/views/cell.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constr) {
          if (MediaQuery.of(context).size.aspectRatio > 1) {
            return Container(
              color: Colors.red,
              width: constr.maxHeight,
              height: constr.maxHeight,
              child: GridView.count(
                crossAxisCount: 3,
                children: [for (var i in GameState.gameBoard) Cell(state: i)],
              ),
            );
          }
          return Container(
            color: Colors.red,
            width: constr.maxWidth,
            height: constr.maxWidth,
            child: GridView.count(
              crossAxisCount: 3,
              children: [for (var i in GameState.gameBoard) Cell(state: i)],
            ),
          );
        },
      ),
    );
  }
}
