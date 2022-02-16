import 'package:flutter/material.dart';

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
    return LayoutBuilder(builder: (context, constr) {
      if (MediaQuery.of(context).size.aspectRatio > 1) {
        return GestureDetector(
          onTap: () => sendEvent(index),
          child: Container(
            color: Colors.amberAccent,
            width: constr.maxHeight / 3,
            height: constr.maxHeight / 3,
            child: Center(
              child: Text(view(state)),
            ),
          ),
        );
      }

      return GestureDetector(
        onTap: () => sendEvent(index),
        child: Container(
          color: Colors.amberAccent,
          width: constr.maxWidth / 3,
          height: constr.maxWidth / 3,
          child: Center(
            child: Text(
              view(state),
              style: const TextStyle(color: Colors.black, fontSize: 30.0),
            ),
          ),
        ),
      );
    });
  }
}
