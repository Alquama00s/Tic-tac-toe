import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tic_tac_toe/board/bloc/game_bloc.dart';
import 'package:tic_tac_toe/board/bloc/game_event.dart';
import 'package:tic_tac_toe/cell/cell.dart';

import 'bloc/game_state/game_state.dart';

class Board extends StatelessWidget {
  Board({Key? key}) : super(key: key);
  final GameBloc gameBloc = GameBloc();
  void triggerTapEvent(int i) {
    gameBloc.add(PlayerResponse(i));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constr) {
          if (MediaQuery.of(context).size.aspectRatio >= 1) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: constr.maxHeight,
                  height: constr.maxHeight,
                  child: BlocBuilder(
                    bloc: gameBloc,
                    builder: (context, GameState state) => GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (int i = 0; i < state.gameBoard.length; i++)
                          Cell(
                            index: i,
                            state: state.gameBoard[i],
                            sendEvent: triggerTapEvent,
                          )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: NeumorphicButton(
                    child: const Text('u play first'),
                    onPressed: () => gameBloc.add(AiPlayFirst()),
                  ),
                )
              ],
            );
          }
          return ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(6),
                width: constr.maxWidth,
                height: constr.maxWidth,
                child: BlocBuilder(
                  bloc: gameBloc,
                  builder: (context, GameState state) => GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for (int i = 0; i < state.gameBoard.length; i++)
                        Cell(
                          index: i,
                          state: state.gameBoard[i],
                          sendEvent: triggerTapEvent,
                        )
                    ],
                  ),
                ),
              ),
              Center(
                child: NeumorphicButton(
                  child: const Text('u play first'),
                  onPressed: () => gameBloc.add(AiPlayFirst()),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
