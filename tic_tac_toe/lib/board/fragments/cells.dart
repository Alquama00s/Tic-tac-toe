import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tic_tac_toe/board/bloc/game_bloc.dart';
import 'package:tic_tac_toe/board/bloc/game_event.dart';
import 'package:tic_tac_toe/board/bloc/game_state/game_state.dart';
import 'package:tic_tac_toe/board/fragments/cell/cell.dart';

class Cells extends StatelessWidget {
  const Cells({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      return LayoutBuilder(builder: (context, constr) {
        if (MediaQuery.of(context).size.aspectRatio >= 1) {
          return Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(125),
                  width: constr.maxHeight - 200,
                  height: constr.maxHeight - 200,
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
                        )
                    ],
                  )),
              Expanded(
                  child: SizedBox(
                width: constr.maxHeight - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => BlocProvider.of<GameBloc>(context)
                              .add(AiPlayFirst()),
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
                          onTap: () => BlocProvider.of<GameBloc>(context)
                              .add(ResetGame()),
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
                  ],
                ),
              )),
            ],
          );
        }
        return Container(
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
                  )
              ],
            ));
      });
    });
  }
}
