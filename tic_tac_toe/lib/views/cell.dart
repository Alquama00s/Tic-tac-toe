import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_state/cell_state.dart';

class Cell extends StatefulWidget {
  const Cell({Key? key, required this.state}) : super(key: key);
  final CellState state;
  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constr) {
      if (MediaQuery.of(context).size.aspectRatio > 1) {
        return Container(
          color: Colors.amberAccent,
          width: constr.maxHeight / 3,
          height: constr.maxHeight / 3,
          child: Center(
            child: Text(view(widget.state)),
          ),
        );
      }

      return Container(
        color: Colors.amberAccent,
        width: constr.maxWidth / 3,
        height: constr.maxWidth / 3,
        child: Center(
          child: Text(
            view(widget.state),
            style: const TextStyle(color: Colors.black, fontSize: 30.0),
          ),
        ),
      );
    });
  }
}
