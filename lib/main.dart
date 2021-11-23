import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text('Dices'),
          backgroundColor: Colors.red,
        ),
        body: const DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  // Default values for dices
  int leftDice = 1;
  int rightDice = 1;

  // Function for long press, to roll both dice
  void rollBothDice() {
    setState(() {
      int newRightValue = rightDice;
      int newLeftValue = leftDice;

      // Loop to get other value than previous (it looks weird when you touch the button and nothing happens)
      while (rightDice == newRightValue || leftDice == newLeftValue) {
        newRightValue = Random().nextInt(6) + 1;
        newLeftValue = Random().nextInt(6) + 1;
      }
      rightDice = newRightValue;
      leftDice = newLeftValue;
    });
  }

  // Function for short press, to roll only one dice
  void rollOneDice(String side) {
    int actualValue = 0;

    // TODO: Check which dice should be rolled (think about better solution)
    if (side == "LEFT") {
      actualValue = leftDice;
    } else {
      actualValue = rightDice;
    }

    int newValue = actualValue;

    // Loop to get other value than previous
    while (actualValue == newValue) {
      newValue = Random().nextInt(6) + 1;
    }

    // TODO: Repeated IF - think how to get rid of it
    if (side == "LEFT") {
      setState(() {
        leftDice = newValue;
      });
    } else {
      setState(() {
        rightDice = newValue;
      });
    }
  }

  // App Frontend
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          // TODO: Create function for building dice widgets
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  rollOneDice("LEFT");
                },
                onLongPress: () {
                  rollBothDice();
                },
                child: Image.asset('images/dice$leftDice.png'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  rollOneDice("RIGHT");
                },
                onLongPress: () {
                  rollBothDice();
                },
                child: Image.asset('images/dice$rightDice.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
