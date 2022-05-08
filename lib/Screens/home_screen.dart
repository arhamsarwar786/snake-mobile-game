import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // FOOD
  int food = 1000;

  // snake List
  List snake = [0, 1, 2, 3, 4];

  generateFood() {
    Random random = Random();
    int item = random.nextInt(600);

    setState(() {
      food = item;
    });
  }

  runSnake({condition = 'noStop',move = 0}) {
    print(snake);

      for (var i = 0; i < snake.length; i++) {
    Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (condition == 'stop' && timer.isActive) {
            print(condition);
            print(timer.tick);
            timer.cancel();
          } else {
            
            snake[i] = snake[i] + move + 1;
          }
        });
        // runSnake();
    });
      }

    // if (condition == 'stop') {
    //   print(condition);
    //   setState(() {
    //     myTimer.cancel();
    //   });
    // }

    print(snake);
  }

  handleController(String direction) {
    if (direction == 'top') {
      runSnake(move: -20);
    } else if (direction == 'left') {
    } else if (direction == 'right') {
    } else if (direction == 'bottom') {
      runSnake(move: 20);
    }
  }

  @override
  void initState() {
    runSnake();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            runSnake(condition: 'stop');
          }),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("SNAKE"),
        actions: [
          IconButton(
            onPressed: () {
              // generateFood();
              setState(() {
              snake = [0, 1, 2, 3, 4];
                
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Stack(
        children: [
          GridView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 20,
                // crossAxisSpacing: 2,
                // mainAxisSpacing: 2
              ),
              itemCount: 600,
              itemBuilder: (context, index) {
                // Timer.periodic(Duration(seconds: 1), (t){
                //   if(t.tick == 10){
                //     t.cancel();
                //   }else{
                //     for (var i = 0; i < snake.length; i++){
                //       snake[i] = snake[i] + 1;                    
                //       print(snake);
                //     }
                //   }
                // });
                if (food == index) {
                  return Container(
                    color: Colors.black,
                  );
                }
                return Container(
                  decoration: BoxDecoration(
                      color: snake.contains(index)
                          ? Colors.red
                          : Colors.transparent,
                      border: Border.all(color: Colors.red)),
                );
              }),
          manageControllers()
        ],
      ),
    );
  }

  manageControllers() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
          ),
          // TOP
          Positioned(
              top: 0,
              child: InkWell(
                onTap: () {
                  handleController('top');
                },
                child: Image.asset(
                  'assets/images/arrow.png',
                  height: 50,
                ),
              )),

          // BOTTOM
          Positioned(
              bottom: 0,
              child: InkWell(
                onTap: () {
                  handleController('bottom');
                },
                child: RotatedBox(
                    quarterTurns: 2,
                    child: Image.asset(
                      'assets/images/arrow.png',
                      height: 50,
                    )),
              )),
          // RIGHT
          Positioned(
              right: 0,
              child: InkWell(
                onTap: () {
                  handleController('right');
                },
                child: RotatedBox(
                    quarterTurns: 1,
                    child: Image.asset(
                      'assets/images/arrow.png',
                      height: 50,
                    )),
              )),

          // LEFT
          Positioned(
              left: 0,
              child: InkWell(
                onTap: () {
                  handleController('left');
                },
                child: RotatedBox(
                    quarterTurns: 4,
                    child: Image.asset(
                      'assets/images/arrow.png',
                      height: 50,
                    )),
              )),
        ],
      ),
    );
  }
}
