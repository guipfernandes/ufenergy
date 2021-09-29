extension DoubleExtension on double {
  double roundToNextEndingWithZero() {
    return ((this + 9) / 10).truncateToDouble() * 10;
  }
}
