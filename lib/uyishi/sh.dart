import 'package:flutter/material.dart';
import 'dart:math';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'XO O\'yini',
//       home: XOGame(),
//     );
//   }
// }

class XOGame extends StatefulWidget {
  @override
  _XOGameState createState() => _XOGameState();
}

class _XOGameState extends State<XOGame> {
  List<String> boxes = List.filled(9, '');
  bool isPlayerOneTurn = true;
  int player1Score = 0;
  int player2Score = 0;
  Random random = Random();

  void checkForWin() {
    List<List<int>> winConditions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (var condition in winConditions) {
      if (boxes[condition[0]] == boxes[condition[1]] &&
          boxes[condition[1]] == boxes[condition[2]] &&
          boxes[condition[0]] != '') {
        if (boxes[condition[0]] == 'X') {
          setState(() {
            player1Score++;
          });
        } else {
          setState(() {
            player2Score++;
          });
        }
        _showWinDialog(boxes[condition[0]]);
        return;
      }
    }

    bool isBoardFull = !boxes.contains('');
    if (isBoardFull) {
      _showDrawDialog();
    }

    // Kompyuter uchun tasodifiy raqam tanlash
    if (!isPlayerOneTurn) {
      int computerChoice;
      do {
        computerChoice = random.nextInt(9);
      } while (boxes[computerChoice] != '');
      boxes[computerChoice] = 'O';
      isPlayerOneTurn = true;
    }
  }

// ==============================================================
  void _showWinDialog(String winner) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('O\'yin tugadi'),
        content: Text('G\'alib: $winner'),
        actions: <Widget>[
          TextButton(
            child: Text('Davom ettirish'),
            onPressed: () {
              resetGame();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('O\'yin tugadi'),
        content: Text('Durang!'),
        actions: <Widget>[
          TextButton(
            child: Text('Davom ettirish'),
            onPressed: () {
              resetGame();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      boxes = List.filled(9, '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 76, 152, 148),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (boxes[index] == '') {
                setState(() {
                  boxes[index] = isPlayerOneTurn ? 'X' : 'O';
                  isPlayerOneTurn = !isPlayerOneTurn;
                  checkForWin();
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: Text(
                  boxes[index],
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
