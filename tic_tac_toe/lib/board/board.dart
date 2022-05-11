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
      body: BlocBuilder(
        bloc: gameBloc,
        builder: (context, GameState state) => LayoutBuilder(
          builder: (context, constr) {
            if (MediaQuery.of(context).size.aspectRatio >= 1) {
              return ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: constr.maxHeight,
                    height: constr.maxHeight,
                    child: GridView.count(
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
                  Center(
                    child: NeumorphicButton(
                      child: const Text('u play first'),
                      onPressed: () => gameBloc.add(AiPlayFirst()),
                    ),
                  ),
                  Center(
                    child: Text(state.infoMessage),
                  ),
                  Center(
                    child: NeumorphicButton(
                      child: const Text('u play first'),
                      onPressed: () => gameBloc.add(ResetGame()),
                    ),
                  ),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: SizedBox()),
                Container(
                  margin: const EdgeInsets.all(6),
                  padding: const EdgeInsets.all(6),
                  width: constr.maxWidth,
                  height: constr.maxWidth,
                  child: GridView.count(
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
                Expanded(
                    child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => gameBloc.add(AiPlayFirst()),
                            child: Neumorphic(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(left: 20),
                              style: const NeumorphicStyle(
                                  color: Colors.blue,
                                  shape: NeumorphicShape.convex,
                                  boxShape: NeumorphicBoxShape.circle()),
                              child: NeumorphicIcon(
                                Icons.start,
                                size: 30,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => gameBloc.add(ResetGame()),
                            child: Neumorphic(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(right: 20),
                              style: const NeumorphicStyle(
                                  color: Colors.blue,
                                  shape: NeumorphicShape.convex,
                                  boxShape: NeumorphicBoxShape.circle()),
                              child: NeumorphicIcon(
                                Icons.restart_alt,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: state.infoMessage.isNotEmpty,
                        child: Neumorphic(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(8),
                          style: const NeumorphicStyle(color: Colors.blue),
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                state.infoMessage,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}
