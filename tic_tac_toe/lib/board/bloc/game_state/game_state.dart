import 'package:tic_tac_toe/board/bloc/game_state/cell_state.dart';

import 'game_interrupt_state.dart';

class GameState {
  GameState(this._gameBoard);
  factory GameState.initialState() {
    return GameState(List.filled(9, CellState.u));
  }

  final List<CellState> _gameBoard;

  List<CellState> get gameBoard => _gameBoard;

  GameInterruptState _state = GameInterruptState.ongoing;

  GameInterruptState get currentState => _state;

  void updateInterruptState(GameInterruptState state) {
    _state = state;
  }

  String get infoMessage {
    switch (_state) {
      case GameInterruptState.aiWon:
        return "You are just punny human, you can't defeat me";
      case GameInterruptState.playerWon:
        return "How can i take over the world, i can't win a simple game";
      case GameInterruptState.draw:
        return "Lets play once more";
      default:
        return "";
    }
  }
}
