import 'dart:math';
import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../widgets/card_widget.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../widgets/card_widget.dart';

class MemoryGameScreen extends StatefulWidget {
  final int gridSize;

  MemoryGameScreen({required this.gridSize});

  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  late List<CardModel> _cards;
  CardModel? _selectedCard;
  bool _isProcessing = false;
  int _moves = 0;  // Track number of moves
  Stopwatch _stopwatch = Stopwatch();  // Stopwatch for timing
  late Timer _timer;  // Timer for UI update

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _moves = 0;
    _stopwatch.reset();
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    // Define a base emoji list
    final List<String> _baseEmojiList = [
      '🍎', '🍌', '🍍', '🍉', '🍇', '🍓', '🍒', '🍋', '🍊', '🐶', '🐱', '🐰',
      '🦁', '🐯', '🦄', '🐼', '⚽', '🏀', '🏈', '🎸', '🍩', '🍪', '🍰', '🍫',
      '🍮', '🎮', '🕹️', '🎧', '🎤', '🎷'
    ];

    final int pairsCount = (widget.gridSize * widget.gridSize) ~/ 2;
    final List<String> contents = List<String>.generate(pairsCount, (index) {
      return _baseEmojiList[index % _baseEmojiList.length];
    });

    final shuffledContents = [...contents, ...contents]..shuffle(Random());

    _cards = shuffledContents.map((content) => CardModel(content: content)).toList();
    _selectedCard = null;
    _isProcessing = false;
  }

  void _onCardTap(CardModel card) {
    if (_isProcessing || card.isFaceUp || card.isMatched) return;

    setState(() {
      card.isFaceUp = true;
    });

    if (_selectedCard == null) {
      _selectedCard = card;
    } else {
      _isProcessing = true;
      _moves++;  // Increment moves on every valid card selection

      if (_selectedCard!.content == card.content) {
        setState(() {
          _selectedCard!.isMatched = true;
          card.isMatched = true;
        });
      } else {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _selectedCard!.isFaceUp = false;
            card.isFaceUp = false;
          });
        });
      }

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _selectedCard = null;
        });
        _isProcessing = false;
      });
    }

    _checkForWin();
  }

  void _checkForWin() {
    if (_cards.every((card) => card.isMatched)) {
      _stopwatch.stop();
      _showWinDialog();
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final elapsedTime = _stopwatch.elapsed;
        final minutes = elapsedTime.inMinutes;
        final seconds = elapsedTime.inSeconds % 60;

        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Text(
            'You Win!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,  // Make sure the content doesn't take up too much space
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Time: $minutes:${seconds.toString().padLeft(2, '0')}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Moves: $_moves',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Do you want to play again?',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _initializeGame();
              },
            ),
            TextButton(
              child: Text(
                'No',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      _initializeGame();
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsedTime = _stopwatch.elapsed;
    final minutes = elapsedTime.inMinutes;
    final seconds = elapsedTime.inSeconds % 60;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Memory Game',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 10,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _restartGame,
            color: Colors.white,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time: $minutes:${seconds.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Moves: $_moves',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.gridSize,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onCardTap(_cards[index]),
                    child: CardWidget(card: _cards[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
