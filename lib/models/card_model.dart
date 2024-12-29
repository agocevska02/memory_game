class CardModel {
  final String content;
  bool isFaceUp;
  bool isMatched;

  CardModel({
    required this.content,
    this.isFaceUp = false,
    this.isMatched = false,
  });
}
