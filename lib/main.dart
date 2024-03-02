import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Tic(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Tic extends StatefulWidget {
  const Tic({super.key});

  @override
  _TicState createState() => _TicState();
}

class _TicState extends State<Tic> {
  bool oTurn = true;
  int oScore = 0;
  int xScore = 0;
  int gridFull = 0;
  String turn = 'O';

  List<String> showcase = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD1EAF5),
              Color(0xFFF3E5F5),
              Color(0xFFFFF9C4),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Player O',
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 3,
                                  fontSize: 25)),
                          Text(oScore.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 3,
                                  fontSize: 25)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Player X',
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 3,
                                  fontSize: 25)),
                          Text(
                            xScore.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                letterSpacing: 3,
                                fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        touched(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            showcase[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Turn: $turn',
                    style: const TextStyle(
                        color: Colors.black, letterSpacing: 3, fontSize: 25),
                  ),
                  ElevatedButton(
                    onPressed: clearBoard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Reset Game'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void touched(int index) {
    setState(() {
      if (oTurn && showcase[index] == '') {
        turn = 'X';
        showcase[index] = 'O';
        oTurn = !oTurn;
        gridFull = gridFull + 1;
        print(gridFull);
      } else if (!oTurn && showcase[index] == '') {
        turn = 'O';
        showcase[index] = 'X';
        oTurn = !oTurn;
        gridFull = gridFull + 1;
        print(gridFull);
      }
      theWinner();
    });
  }

  void theWinner() {
    if (showcase[0] == showcase[1] &&
        showcase[0] == showcase[2] &&
        showcase[0] != '') {
      gridFull = 0;
      _showDialog(showcase[0]);
    } else if (showcase[3] == showcase[4] &&
        showcase[3] == showcase[5] &&
        showcase[3] != '') {
      gridFull = 0;
      _showDialog(showcase[3]);
    } else if (showcase[6] == showcase[7] &&
        showcase[6] == showcase[8] &&
        showcase[6] != '') {
      gridFull = 0;
      _showDialog(showcase[6]);
    } else if (showcase[0] == showcase[3] &&
        showcase[0] == showcase[6] &&
        showcase[0] != '') {
      gridFull = 0;
      _showDialog(showcase[0]);
    } else if (showcase[1] == showcase[4] &&
        showcase[1] == showcase[7] &&
        showcase[1] != '') {
      gridFull = 0;
      _showDialog(showcase[1]);
    } else if (showcase[2] == showcase[5] &&
        showcase[2] == showcase[8] &&
        showcase[2] != '') {
      gridFull = 0;
      _showDialog(showcase[2]);
    } else if (showcase[0] == showcase[4] &&
        showcase[0] == showcase[8] &&
        showcase[0] != '') {
      gridFull = 0;
      _showDialog(showcase[0]);
    } else if (showcase[2] == showcase[4] &&
        showcase[2] == showcase[6] &&
        showcase[2] != '') {
      gridFull = 0;
      _showDialog(showcase[2]);
    } else if (gridFull == 9) {
      showDraw();
    }
  }

  void showDraw() {
    print('Draw');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Draw'),
            actions: [
              TextButton(
                  child: const Text('Play Again'),
                  onPressed: () async {
                    clearBoard();
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _showDialog(String winner) {
    print('winner');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(winner + '  is the Winner'),
            actions: [
              TextButton(
                  child: const Text(
                    'Play Again',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    clearBoard();
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
    if (winner == 'O') {
      oScore = oScore + 1;
    } else if (winner == 'X') {
      xScore = xScore + 1;
    }
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        showcase[i] = '';
      }
    });
    gridFull = 0;
  }
}
