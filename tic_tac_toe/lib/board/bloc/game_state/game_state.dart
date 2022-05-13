import 'package:equatable/equatable.dart';
import 'package:objectid/objectid.dart';
import 'package:tic_tac_toe/board/bloc/game_state/cell_state.dart';

import 'game_interrupt_state.dart';

class GameState extends Equatable {
  GameState._(this._objectId, this._gameBoard, this._stat, this._state);
  factory GameState.initialState() {
    return GameState._(ObjectId().toString(), List.filled(9, CellState.u),
        List.filled(3, 0, growable: false), GameInterruptState.ongoing);
  }

  GameState emitter() {
    return GameState._(ObjectId().toString(), _gameBoard, _stat, _state);
  }

  final String _objectId;

  final List<int> _stat;

  List<int> get status => _stat;

  get drawCount => _stat[0];
  get winCount => _stat[1];
  get aiWinCount => _stat[2];

  List<CellState> _gameBoard;

  List<CellState> get gameBoard => _gameBoard;

  GameInterruptState _state = GameInterruptState.ongoing;

  GameInterruptState get currentState => _state;

  void updateMove(int index, CellState input) {
    _gameBoard[index] = input;
  }

  void resetGame() {
    _gameBoard = List.filled(9, CellState.u);
    _state = GameInterruptState.ongoing;
  }

  void updateInterruptState(GameInterruptState state) {
    _state = state;
    switch (_state) {
      case GameInterruptState.aiWon:
        _stat[2]++;
        break;
      case GameInterruptState.playerWon:
        _stat[1]++;
        break;
      case GameInterruptState.draw:
        _stat[0]++;
        break;
      default:
    }
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
        return "Hmm.. looks like I will win";
    }
  }

  @override
  List get props => [_objectId];
}
