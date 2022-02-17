import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../board/bloc/game_state/cell_state.dart';

class Cell extends StatelessWidget {
  const Cell(
      {Key? key,
      required this.index,
      required this.state,
      required this.sendEvent})
      : super(key: key);
  final CellState state;
  final Function sendEvent;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => sendEvent(index),
      child: Neumorphic(
        margin: const EdgeInsets.all(3),
        child: Center(
          child: Text(
            view(state),
            style: const TextStyle(color: Colors.black, fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
