import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tic_tac_toe/board/bloc/game_bloc.dart';
import 'package:tic_tac_toe/board/bloc/game_event.dart';
import '../../bloc/game_state/cell_state.dart';

class Cell extends StatelessWidget {
  const Cell({
    Key? key,
    required this.index,
    required this.state,
  }) : super(key: key);
  final CellState state;
  final int index;

  NeumorphicBoxShape? getBoxShape() {
    switch (state) {
      case CellState.o:
        return const NeumorphicBoxShape.circle();
      case CellState.x:
        return const NeumorphicBoxShape.rect();
      default:
        return null;
    }
  }

  Color? getColor() {
    switch (state) {
      case CellState.o:
        return Colors.blue;
      case CellState.x:
        return Colors.red;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (state != CellState.u) return;
        BlocProvider.of<GameBloc>(context).add(PlayerResponse(index));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(3),
        padding: state == CellState.u
            ? const EdgeInsets.all(0)
            : const EdgeInsets.all(30),
        child: Neumorphic(
          style: NeumorphicStyle(boxShape: getBoxShape(), color: getColor()),
        ),
      ),
    );
  }
}
