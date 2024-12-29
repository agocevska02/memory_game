import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;

  const CardWidget({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: card.isFaceUp || card.isMatched ? Colors.white : Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4.0, spreadRadius: 1.0),
        ],
      ),
      child: Center(
        child: Text(
          card.isFaceUp || card.isMatched ? card.content.toString() : '',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
