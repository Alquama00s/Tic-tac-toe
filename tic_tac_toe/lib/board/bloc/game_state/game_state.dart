import 'package:tic_tac_toe/board/bloc/game_state/cell_state.dart';

class GameState {
  GameState(this._gameBoard);
  factory GameState.initialState() {
    return GameState(List.filled(9, CellState.u));
  }

  final List<CellState> _gameBoard;

  List<CellState> get gameBoard => _gameBoard;
}
