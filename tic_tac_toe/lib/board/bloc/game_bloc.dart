import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tic_tac_toe/board/bloc/game_event.dart';
import 'package:tic_tac_toe/board/bloc/game_state/game_interrupt_state.dart';
import 'package:tic_tac_toe/board/bloc/game_state/cell_state.dart';
import 'package:tic_tac_toe/board/bloc/game_state/game_state.dart';
import 'package:tic_tac_toe/game_ai/ai.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.initialState()) {
    on<AiPlayFirst>((event, emit) {
      if (_gameBoard.every((element) => element == CellState.u)) {
        add(AiResponse());
      }
    });
    on<PlayerResponse>((event, emit) async {
      if (turn) {
        turn = false;
        if (_gameBoard[event.index] == CellState.u) {
          _currentState.updateMove(event.index, CellState.o);
          emit(_currentState.emitter());
          await Future.delayed(const Duration(milliseconds: 500));
          add(AiResponse(playerResponseIndex: event.index));
        } else {
          turn = true;
        }
      }
    });
    on<AiResponse>((event, emit) {
      int nextMove = ai.nextMove(event.playerResponseIndex);
      if (nextMove > 8) {
        if (nextMove > 3000) {
          _currentState.updateInterruptState(GameInterruptState.draw);
        } else if (nextMove > 2000) {
          _currentState.updateInterruptState(GameInterruptState.draw);
        } else if (nextMove > 1001) {
          _currentState.updateMove(nextMove - 1001, CellState.x);
          _currentState.updateInterruptState(GameInterruptState.aiWon);
        } else {
          _currentState.updateInterruptState(GameInterruptState.playerWon);
        }
      } else {
        _currentState.updateMove(nextMove, CellState.x);

        turn = true;
      }
      emit(_currentState.emitter());
    });
    on<ResetGame>((event, emit) {
      turn = true;
      _currentState.resetGame();
      emit(_currentState.emitter());
      reset();
    });
  }
  bool turn = true;

  GameAi ai = GameAi();

  List<CellState> get _gameBoard => _currentState.gameBoard;

  final GameState _currentState = GameState.initialState();

  void reset() {
    ai = GameAi();
  }
}
