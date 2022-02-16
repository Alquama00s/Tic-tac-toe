import 'package:tic_tac_toe/game_ai/lib/state.dart';

abstract class AiData {
  //more priority value => nmore important

  static const Map<String, int> firstPriority = {
    "20": -1,
    "02": -2,
    "01": -3,
    "10": -4,
    "00": -5,
    "11": -6
  };

  //modeling the game bord as row-major 1d list
  //we get the following second priority

  static const Map<int, int> secondPriority = {
    0: -2,
    1: -7,
    2: -3,
    3: -6,
    4: -1,
    5: -8,
    6: -5,
    7: -9,
    8: -4,
  };
}
