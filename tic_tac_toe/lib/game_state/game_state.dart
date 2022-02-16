import 'package:tic_tac_toe/game_state/cell_state.dart';
export './cell_state.dart';

class GameState {
  static List<CellState> gameBoard = List.filled(9, CellState.u);
}
