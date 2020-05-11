class ColorsUtil {
  static final cardsColorList = [0xFF008267, 0xFFb6006f, 0xFF0097A7, 0xFF964df6, 0xFF63b4f6, 0xFFf357aa, 0xFFf8a82e, 0xFF607D8B, 0xFF388E3C, 0xFF00a189];

  static int getColorForPosition(int position) {
    final pos = position.toString().substring(position.toString().length-1, position.toString().length);
      return cardsColorList[int.parse(pos)];
  }
}