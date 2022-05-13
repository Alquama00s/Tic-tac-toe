import 'dart:math';

import 'package:tic_tac_toe/game_ai/lib/ai_data.dart';
import 'package:tic_tac_toe/game_ai/lib/configuration.dart';

import '../board/bloc/game_state/cell_state.dart';

//X is ai

class GameAi extends AiData {
  //List<int> gameBoard = List.filled(9, 0);
  int moves = 0;

  ///this contains a priority sorted index of game board
  ///the zeroth index contains the index of current move;
  List<int> prioritySortedIndex = List.generate(9, (i) => i);

  ///win configurations
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
    if (secondLocalPriority[cellIndex]! == -10000) {
      //this cell is already filled
      return -10000;
    }
    int _max = -10000;
    for (var index in indexToConfigs[cellIndex]!) {
      _max = max(_max, AiData.firstPriority(configs[index].state.currentState));
    }
    if (_max > 0) {
      return _max;
    }
    if (_max == -1) {
      return 1; // ai will win
    }
    if (_max == -2) {
      return 0; // ai will block user from winning
    }
    return _max + secondLocalPriority[cellIndex]!;
  }

  //contains the priority of all index acc to both priority plan
  List<int> pval = List.filled(9, 0);

  ///this sorts the [prioritySortedIndex] in decrasing order
  ///do current move stays at index 0
  void sortPriorityIndex() {
    prioritySortedIndex.sort((a, b) {
      pval[a] = getCombinedPriority(a);
      pval[b] = getCombinedPriority(b);
      return pval[b] - pval[a];
    });
  }

  int nextMove(int? currentUserMove) {
    int? gameInterrupt; // this keeps track of if the game is won or lost
    int temp;
    moves++;
    //the current move may be null when ai plays first
    if (currentUserMove != null) {
      for (var index in indexToConfigs[currentUserMove]!) {
        //change the state of board acc. to user input
        configs[index].state.changeState(CellState.o);
        //check whether the game is won or lost by using fiirst priority paln
        temp = AiData.firstPriority(configs[index].state.currentState);
        if (temp > 0) {
          //the game is won or lost if ai gives +ve integer
          //as priority
          gameInterrupt = temp;
        }
      }

      if (gameInterrupt != null) {
        return gameInterrupt;
      }
      //reduce the priority of this cell bcoz it
      //is occupied by user bt second priority paln
      secondLocalPriority[currentUserMove] = -10000;
    }
    //sort the indices based on both priority plans
    sortPriorityIndex();

    for (var index in indexToConfigs[prioritySortedIndex[0]]!) {
      //change the state of board acc. to ai input
      configs[index].state.changeState(CellState.x);
      //check whether the game is won or lost by using fiirst priority paln
      temp = AiData.firstPriority(configs[index].state.currentState);
      if (temp > 0) {
        //the game is won or lost if ai gives +ve integer
        //as priority
        gameInterrupt = temp;
      }
    }
    if (gameInterrupt != null) {
      //send back 1001+current move to display on screen
      return gameInterrupt += prioritySortedIndex[0];
    }
    if (moves >= 5) {
      //game is draw bcoz all cells are filled
      return 2000 + prioritySortedIndex[0];
    }
    //reduce the priority of this cell bcoz it
    //will be occupied by ai bt second priority paln
    secondLocalPriority[prioritySortedIndex[0]] = -10000;
    //reduce the priority of this cell bcoz it
    //will be occupied by ai bt both priority paln
    pval[prioritySortedIndex[0]] = -10000;

    return prioritySortedIndex[0];
  }
}
