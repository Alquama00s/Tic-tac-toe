import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/game_ai/lib/state.dart';

class Configuration extends Equatable {
  Configuration(this.cellBindings);
  final State _state = State();
  final List<int> cellBindings;

  State get state => _state;

  @override
  List<Object> get props => cellBindings;
}
