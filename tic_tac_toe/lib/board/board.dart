import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/board/bloc/game_bloc.dart';
import 'package:tic_tac_toe/board/bloc/game_event.dart';
import 'package:tic_tac_toe/board/fragments/cell/cell.dart';
import 'package:tic_tac_toe/board/fragments/cells.dart';

import 'bloc/game_state/game_state.dart';

class Board extends StatelessWidget {
  Board({Key? key}) : super(key: key);
  final factor = 3.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GameBloc(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, GameState state) => LayoutBuilder(
                builder: (context, constr) {
                  if (MediaQuery.of(context).size.aspectRatio >= 1) {
                    return Row(
                      children: [
                        const Cells(),
                        Expanded(
                            child: Column(
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                child: Row(children: [
                                  Flexible(
                                      flex: 1,
                                      child: Center(
                                          child: Neumorphic(
                                              padding: EdgeInsets.fromLTRB(
                                                  35 * factor,
                                                  25 * factor,
                                                  35 * factor,
                                                  25 * factor),
                                              child: FittedBox(
                                                child: Text(
                                                    "${state.drawCount}\nDraws",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.ubuntu(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )))),
                                  Flexible(
                                      flex: 1,
                                      child: Center(
                                          child: Neumorphic(
                                        padding: EdgeInsets.fromLTRB(
                                            35 * factor,
                                            25 * factor,
                                            35 * factor,
                                            25 * factor),
                                        child: FittedBox(
                                          child: Text("${state.winCount}\nWins",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ))),
                                  Flexible(
                                      flex: 1,
                                      child: Center(
                                          child: Neumorphic(
                                              padding: EdgeInsets.fromLTRB(
                                                  35 * factor,
                                                  25 * factor,
                                                  35 * factor,
                                                  25 * factor),
                                              child: FittedBox(
                                                child: Text(
                                                    "${state.aiWinCount}\nLost",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.ubuntu(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ))))
                                ]),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: SingleChildScrollView(
                                child: Neumorphic(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  style:
                                      const NeumorphicStyle(color: Colors.blue),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        state.infoMessage,
                                        textAlign: TextAlign.center,
                                        maxLines: null,
                                        style: GoogleFonts.ubuntu(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: SizedBox(
                        child: Row(children: [
                          Flexible(
                              flex: 1,
                              child: Center(
                                  child: Neumorphic(
                                      padding: const EdgeInsets.fromLTRB(
                                          35, 25, 35, 25),
                                      child:
                                          Text("${state.drawCount}\nDraws")))),
                          Flexible(
                              flex: 1,
                              child: Center(
                                  child: Neumorphic(
                                      padding: const EdgeInsets.fromLTRB(
                                          35, 25, 35, 25),
                                      child: Text("${state.winCount}\nWins")))),
                          Flexible(
                              flex: 1,
                              child: Center(
                                  child: Neumorphic(
                                      padding: const EdgeInsets.fromLTRB(
                                          35, 25, 35, 25),
                                      child:
                                          Text("${state.aiWinCount}\nLost"))))
                        ]),
                      )),
                      const Cells(),
                      Expanded(
                          child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      BlocProvider.of<GameBloc>(context)
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
                                  onTap: () =>
                                      BlocProvider.of<GameBloc>(context)
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
                            Visibility(
                              visible: state.infoMessage.isNotEmpty,
                              child: Neumorphic(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.all(8),
                                style:
                                    const NeumorphicStyle(color: Colors.blue),
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
          ),
        ),
      ),
    );
  }
}
