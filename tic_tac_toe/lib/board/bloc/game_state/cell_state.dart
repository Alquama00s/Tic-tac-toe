enum CellState { x, o, u }
String view(CellState state) {
  if (state == CellState.x) return 'X';
  if (state == CellState.o) return 'O';
  return '';
}
