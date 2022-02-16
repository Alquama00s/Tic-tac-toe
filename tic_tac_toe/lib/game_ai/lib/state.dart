import 'package:equatable/equatable.dart';

import '../../board/bloc/game_state/cell_state.dart';

class State extends Equatable {
  State();

  int _x = 0, _o = 0;

  void changeState(CellState input) {
    if (input == CellState.x) {
      _x++;
    } else if (input == CellState.o) {
      _o++;
    }
  }

  String get currentState => _x.toString() + _o.toString();

  @override
  List<Object> get props => [_x, _o];
}
