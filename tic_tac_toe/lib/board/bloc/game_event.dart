import 'package:flutter/services.dart';

abstract class GameEvent {}

class PlayerResponse extends GameEvent {
  PlayerResponse(this.index);
  final int index;
}

class AiResponse extends GameEvent {
  AiResponse({this.playerResponseIndex});
  final int? playerResponseIndex;
}

class AiPlayFirst extends GameEvent {}
