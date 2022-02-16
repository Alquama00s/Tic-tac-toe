import 'dart:math';

import 'package:tic_tac_toe/game_ai/lib/ai_data.dart';
import 'package:tic_tac_toe/game_ai/lib/configuration.dart';
import 'package:tic_tac_toe/game_state/cell_state.dart';

//X is ai

class GameAi extends AiData {
  //List<int> gameBoard = List.filled(9, 0);

  ///this contains a priority sorted index of game board
  ///the zeroth index contains the index of current move;
  List<int> prioritySortedIndex = List.generate(9, (i) => i);

  final List<Configuration> configs = List.unmodifiable([
    Configuration(const [0, 1, 2]), //row 1 -0
    Configuration(const [3, 4, 5]), //row 2 -1
    Configuration(const [6, 7, 8]), //row 2 -2
    Configuration(const [0, 3, 6]), //column 1 -3
    Configuration(const [1, 4, 7]), //column 2 -4
    Configuration(const [8, 5, 2]), //column 2 -5
    Configuration(const [6, 4, 2]), //diag 1 -6
    Configuration(const [0, 4, 8]), //diag 2 -7
  ]);

  ///this stores k vs list
  ///where the list contains all the indices
  ///corresponding to [configs] where kth cell
  ///belongs to that configuration
  final Map<int, List<int>> indexToConfigs = {
    0: [0, 3, 7],
    1: [0, 4],
    2: [0, 5, 6],
    3: [1, 3],
    4: [1, 4, 7, 6],
    5: [1, 5],
    6: [2, 3, 6],
    7: [2, 4],
    8: [2, 5, 7],
  };

  ///once a cell is occupied it needs to be decresed in priority
  ///locally
  Map<int, int> secondLocalPriority = Map.from(AiData.secondPriority);

  int getCombinedPriority(int cellIndex) {
    int _max = -10000;
    for (var index in indexToConfigs[cellIndex]!) {
      _max =
          max(_max, AiData.firstPriority[configs[index].state.currentState]!);
    }

    return _max + secondLocalPriority[cellIndex]!;
  }

  ///this sorts the [prioritySortedIndex]
  void sortPriorityIndex() {
    prioritySortedIndex
        .sort((a, b) => getCombinedPriority(a) - getCombinedPriority(b));
  }

  int nextMove(int currentUserMove) {
    for (var index in indexToConfigs[currentUserMove]!) {
      configs[index].state.changeState(CellState.o);
    }
    secondLocalPriority[currentUserMove] = -10000;
    sortPriorityIndex();
    secondLocalPriority[prioritySortedIndex[0]] = -10000;
    return prioritySortedIndex[0];
  }
}
