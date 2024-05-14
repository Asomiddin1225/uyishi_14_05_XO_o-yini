import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ""));
  bool isPlayer1Turn = true;
  bool gameEnded = false;
  int player1Score = 0;
  int player2Score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 76, 152, 148),
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 186, 186, 186),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.home,
                  size: 20,
                ),
                Text(
                  "fotografina.com",
                  style: TextStyle(color: Colors.black),
                ),
                Icon(
                  Icons.save_alt_outlined,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Gap(20),
              const Text(
                "Asomiddin       Telefon ",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 28,
                ),
              ),
              const Gap(0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    player1Score.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 48,
                    ),
                  ),
                  const Text(
                    ":",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    player2Score.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 48,
                    ),
                  )
                ],
              ),
              Column(
                children: List.generate(
                  3,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (subIndex) => Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              if (!gameEnded &&
                                  board[index][subIndex].isEmpty) {
                                setState(() {
                                  board[index][subIndex] =
                                      isPlayer1Turn ? "X" : "O";
                                  isPlayer1Turn = !isPlayer1Turn;
                                  checkForWinner();
                                  if (!gameEnded && !isPlayer1Turn) {
                                    // Computer's turn
                                    rovfunksiya();
                                  }
                                });
                              }
                            },
                            child: Text(
                              board[index][subIndex],
                              style: const TextStyle(fontSize: 40.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  width: 500,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 186, 186, 186),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          resetGame();
                        });
                      },
                      child: const Text(
                        "New Game",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  width: 500,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 186, 186, 186),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          player1Score = 0;
                          player2Score = 0;
                          resetGame();
                        });
                      },
                      child: const Text(
                        "Reset Game",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 40,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_right,
                size: 40,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.save,
                color: Colors.grey,
                size: 40,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.grey,
                size: 40,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void resetGame() {
    board = List.generate(3, (_) => List.filled(3, ""));
    isPlayer1Turn = true;
    gameEnded = false;
  }

  void rovfunksiya() {
    Random random = Random();
    int i, j;
    do {
      i = random.nextInt(3);
      j = random.nextInt(3);
    } while (board[i][j].isNotEmpty);

    setState(() {
      board[i][j] = "O";
      isPlayer1Turn = true;
      checkForWinner();
    });
  }

  void checkForWinner() {
    // Check rows
    for (var i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0].isNotEmpty) {
        if (board[i][0] == "X") {
          player1Score++;
        } else {
          player2Score++;
        }
        gameEnded = true;
        return;
      }
    }

    // Check columns
    for (var i = 0; i < 3; i++) {
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i].isNotEmpty) {
        if (board[0][i] == "X") {
          player1Score++;
        } else {
          player2Score++;
        }
        gameEnded = true;
        return;
      }
    }

    // Check diagonals
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0].isNotEmpty) {
      if (board[0][0] == "X") {
        player1Score++;
      } else {
        player2Score++;
      }
      gameEnded = true;
      return;
    }

    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2].isNotEmpty) {
      if (board[0][2] == "X") {
        player1Score++;
      } else {
        player2Score++;
      }
      gameEnded = true;
      return;
    }

    // Check for a tie
    if (!board.any((row) => row.any((cell) => cell.isEmpty))) {
      gameEnded = true;
      return;
    }

    // Continue the game if no winner or tie
    if (!gameEnded && !isPlayer1Turn) {
      rovfunksiya();
    }
  }
}
