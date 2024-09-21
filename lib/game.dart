import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:s_game/home.dart';

class StarGame extends StatefulWidget {
  const StarGame({super.key});

  @override
  State<StarGame> createState() => _StarGameState();
}

enum Direction { up, down, left, right }

class _StarGameState extends State<StarGame> {
  int row = 20, coulmn = 20;
  List<int> borderList = [];
  List<int> snakePostion = [];
  int snakeHead = 0;
  int score = 0;
  late Direction direction;
  late int foodPostion;

  @override
  void initState() {
    startGame();
    super.initState();
  }

  void startGame() {
    makeBorder();
    generateFood();
    direction = Direction.down;
    snakePostion = [45, 44, 43];
    snakeHead = snakePostion.first;
    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        updateSnake();
        if (checkCollision()) {
          timer.cancel();
          showGameOverDialogBox();
        }
      },
    );
  }

  void showGameOverDialogBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: const Text("Your Snake Collided!"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    }));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.home,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    startGame();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.replay_circle_filled_outlined,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Restart",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  bool checkCollision() {
    if (borderList.contains(snakeHead)) return true;
    if (snakePostion.sublist(1).contains(snakeHead)) return true;
    return false;
  }

  void generateFood() {
    foodPostion = Random().nextInt(row * coulmn);
    if (borderList.contains(foodPostion)) {
      generateFood();
    }
  }

  void updateSnake() {
    setState(() {
      switch (direction) {
        case Direction.up:
          snakePostion.insert(0, snakeHead - coulmn);

          break;
        case Direction.down:
          snakePostion.insert(0, snakeHead + coulmn);

          break;
        case Direction.right:
          snakePostion.insert(0, snakeHead + 1);

          break;
        case Direction.left:
          snakePostion.insert(0, snakeHead - 1);

          break;

        default:
      }
    });

    if (snakeHead == foodPostion) {
      score++;
      generateFood();
    } else {
      snakePostion.removeLast();
    }

    snakeHead = snakePostion.first;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: _buildGameView()),
            _buildGameControllers(),
          ],
        ),
      ),
    );
  }

  Widget _buildGameView() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: coulmn),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: fillBoxColor(index),
          ),
        );
      },
      itemCount: row * coulmn,
    );
  }

  Widget _buildGameControllers() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Score:$score"),
          IconButton(
            onPressed: () {
              if (direction != Direction.down) direction = Direction.up;
            },
            icon: const Icon(Icons.arrow_circle_up_outlined),
            iconSize: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (direction != Direction.right) direction = Direction.left;
                },
                icon: const Icon(Icons.arrow_circle_left_outlined),
                iconSize: 100,
              ),
              const SizedBox(
                width: 70,
              ),
              IconButton(
                onPressed: () {
                  if (direction != Direction.left) direction = Direction.right;
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
                iconSize: 100,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              if (direction != Direction.up) direction = Direction.down;
            },
            icon: const Icon(Icons.arrow_circle_down_outlined),
            iconSize: 100,
          ),
        ],
      ),
    );
  }

  Color fillBoxColor(int index) {
    if (borderList.contains(index)) {
      return Colors.amber;
    } else {
      if (snakePostion.contains(index)) {
        if (snakeHead == index) {
          return Colors.white.withOpacity(0.9);
        } else {
          return Colors.green;
        }
      } else {
        if (index == foodPostion) {
          return Colors.red;
        }
      }
    }
    return Colors.grey.withOpacity(0.5);
  }

  makeBorder() {
    for (int i = 0; i < coulmn; i++) {
      if (!borderList.contains(i)) borderList.add(i);
    }

    for (int i = 0; i < row * coulmn; i = i + coulmn) {
      if (!borderList.contains(i)) borderList.add(i);
    }
    for (int i = coulmn - 1; i < row * coulmn; i = i + coulmn) {
      if (!borderList.contains(i)) borderList.add(i);
    }
    for (int i = (row * coulmn) - coulmn; i < row * coulmn; i = i + 1) {
      if (!borderList.contains(i)) borderList.add(i);
    }
  }
}
