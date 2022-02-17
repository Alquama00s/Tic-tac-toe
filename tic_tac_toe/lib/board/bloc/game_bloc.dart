import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tic_tac_toe/board/bloc/game_event.dart';
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
    on<PlayerResponse>((event, emit) {
      if (turn) {
        turn = false;
        if (_gameBoard[event.index] == CellState.u) {
          emit(update(event.index, CellState.o));
          add(AiResponse(playerResponseIndex: event.index));
        } else {
          turn = true;
        }
      }
    });
    on<AiResponse>((event, emit) {
      int nextMove = ai.nextMove(event.playerResponseIndex);
      print("nestMaove" + nextMove.toString());
      if (nextMove > 8) {
        if (nextMove > 3000) {
          print("draw" + nextMove.toString());
        } else if (nextMove > 2000) {
          emit(update(nextMove - 2000, CellState.x));
          //sleep(const Duration(milliseconds: 500));
          print("draw" + nextMove.toString());
        } else if (nextMove > 1001) {
          emit(update(nextMove - 1001, CellState.x));
          //sleep(const Duration(milliseconds: 500));
          print("I won" + nextMove.toString());
        } else {
          print("u won");
        }
        emit(GameState.initialState());
        reset();
      } else {
        emit(update(nextMove, CellState.x));
      }
      turn = true;
    });
  }
  bool turn = true;

  GameAi ai = GameAi();

  List<CellState> _gameBoard = List.filled(9, CellState.u);

  GameState update(int index, CellState input) {
    _gameBoard[index] = input;
    return GameState(_gameBoard);
  }

  void reset() {
    ai = GameAi();
    _gameBoard = List.filled(9, CellState.u);
  }
}
