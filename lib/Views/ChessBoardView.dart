  import 'dart:async';
  import 'dart:math';
  import 'package:chess_algorithm/Views/HomeView.dart';
  import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
  import 'package:flutter/material.dart';
  import 'package:lottie/lottie.dart';
  import 'package:sizer/sizer.dart';
  class ChessBoard extends StatefulWidget {
    const ChessBoard({super.key});

    @override
    State<ChessBoard> createState() => _ChessBoardState();
  }

  class _ChessBoardState extends State<ChessBoard> {
    int knightRow = 7;
    int knightCol = 1;
    int pawnRow = 0;
    int pawnCol = 6;

    static  int chessScore = 0 ;
    static  int pawnScore = 0 ;




    String selectedPiece = '';

    List<List<bool>> validMoves = List.generate(8, (_) => List.filled(8, false));

    Timer? _timer;
    int secondsLeft = 60;

    String gameResult = '';

    bool isKnightTurn = true;

    final Color darkSquareColor = const Color(0xff497572);
    final Color lightSquareColor = const Color(0xff909493);
    final Color border1 = const Color(0xff3d5347);
    final Color border2 = const Color(0xff3c4745);
    final Color border3 = const Color(0xff26322d);
    final Color backgroundColor = const Color(0xff26322d);

    @override
    void initState() {
      super.initState();
      startTimer();
      setRandomScenario();
    }

    void setRandomScenario() {
      final random = Random();


      int scenario = random.nextInt(3);

      switch (scenario) {
        case 0:

          List<List<int>> knightPositions = [];
          for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
              knightRow = r;
              knightCol = c;
              calculateKnightMoves();
              for (int rr = 0; rr < 8; rr++) {
                for (int cc = 0; cc < 8; cc++) {
                  if (validMoves[rr][cc]) {
                    knightPositions.add([r, c, rr, cc]);
                  }
                }
              }
            }
          }
          var chosen = knightPositions[random.nextInt(knightPositions.length)];
          knightRow = chosen[0];
          knightCol = chosen[1];
          pawnRow = chosen[2];
          pawnCol = chosen[3];
          break;

        case 1:

          List<List<int>> pawnPositions = [];
          for (int r = 0; r < 7; r++) {
            for (int c = 0; c < 8; c++) {
              int row = r + 1;
              if (c > 0) pawnPositions.add([r, c, row, c - 1]);
              if (c < 7) pawnPositions.add([r, c, row, c + 1]);
            }
          }
          var chosen = pawnPositions[random.nextInt(pawnPositions.length)];
          pawnRow = chosen[0];
          pawnCol = chosen[1];
          knightRow = chosen[2];
          knightCol = chosen[3];
          break;

        default: // Completely random
          do {
            knightRow = random.nextInt(8);
            knightCol = random.nextInt(8);
            pawnRow = random.nextInt(8);
            pawnCol = random.nextInt(8);
          } while (knightRow == pawnRow && knightCol == pawnCol);
      }

      resetValidMoves();
      selectedPiece = '';
      isKnightTurn = true;
      secondsLeft = 60;
      gameResult = '';
    }


    void startTimer() {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          secondsLeft++;
          if (secondsLeft == 0) {
            gameResult = 'Pawn Wins!';
            _timer?.cancel();
            pawnScore++;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    WhiteKnight(size: 40,),
                    const Text("+1 kill")
                  ],
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                //
                title:  Text("Pawn Wins!",style: TextStyle(
                  color: const Color(0xff26322d),
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold
                ),),

                actions: [
                  Lottie.asset("assets/Congrats.json"),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     InkWell(
                       onTap: (){
                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  home_v(knightScore: chessScore,pawnScore: pawnScore,)));

                       },
                       child: Container(
                         width: 15.w,
                         height: 4.h,
                         decoration: const BoxDecoration(
                           color: Color(0xff26322d),
                           borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(20),
                               bottomRight: Radius.circular(20)
                           ),

                         ),
                         child: Center(child: Text("Ok",style: TextStyle(color: const Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 16.sp),)),
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         setRandomScenario();

                       },
                       child: Container(
                         width: 17.w,
                         height: 4.h,
                         decoration: const BoxDecoration(
                           color: Color(0xff26322d),
                           borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(20),
                               bottomRight: Radius.circular(20)
                           ),

                         ),
                         child: Center(child: Text("Restart",style: TextStyle(color: const Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 16.sp),)),
                       ),
                     )
                   ],
                 )
                ],
              ),
            );
          }
        });
      });
    }

    void resetValidMoves() {
      validMoves = List.generate(8, (_) => List.filled(8, false));
    }

    void calculateKnightMoves() {
      resetValidMoves();
      final directions = [
        [-2, -1], [-2, 1],
        [-1, -2], [-1, 2],
        [1, -2],  [1, 2],
        [2, -1],  [2, 1],
      ];



      for (var dir in directions) {
        int newRow = knightRow + dir[0];
        int newCol = knightCol + dir[1];
        if (_isInBounds(newRow, newCol)) {
          validMoves[newRow][newCol] = true;
        }
      }
    }

    void calculatePawnMoves() {
      resetValidMoves();
      int newRow = pawnRow + 1; // moving down the board
      if (_isInBounds(newRow, pawnCol)) {
        validMoves[newRow][pawnCol] = true; // Move forward
      }
      if (_isInBounds(newRow, pawnCol - 1)) {
        validMoves[newRow][pawnCol - 1] = true; // Capture left
      }
      if (_isInBounds(newRow, pawnCol + 1)) {
        validMoves[newRow][pawnCol + 1] = true; // Capture right
      }
    }

    bool _isInBounds(int row, int col) {
      return row >= 0 && row < 8 && col >= 0 && col < 8;
    }

    void handleTap(int row, int col) {
      if (gameResult.isNotEmpty) return;

      if (isKnightTurn && row == knightRow && col == knightCol) {
        selectedPiece = 'knight';
        calculateKnightMoves();
      } else if (!isKnightTurn && row == pawnRow && col == pawnCol) {
        selectedPiece = 'pawn';
        calculatePawnMoves();
      } else if (validMoves[row][col]) {
        if (selectedPiece == 'knight') {
          knightRow = row;
          knightCol = col;
          if (knightRow == pawnRow && knightCol == pawnCol) {
            gameResult = 'Knight Wins!';
            _timer?.cancel();
            KnightWins();
            chessScore++;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    BlackPawn(size: 40,),
                    const Text("+1 kill")
                  ],
                ),
                duration: const Duration(seconds: 2),
              ),
            );

          } else {
            isKnightTurn = false;
          }
        } else if (selectedPiece == 'pawn') {
          pawnRow = row;
          pawnCol = col;
          if (pawnRow == knightRow && pawnCol == knightCol) {
            gameResult = 'Pawn Wins!';
            _timer?.cancel();
            PawnWins();
            pawnScore++;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    WhiteKnight(size: 40,),
                    const Text("+1 kill")
                  ],
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          } else if(pawnRow ==7){
            gameResult = 'Pawn Wins!';
            PawnWins();
            pawnScore++;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    WhiteKnight(size: 40,),
                    const Text("+1 kill")
                  ],
                ),
                duration: const Duration(seconds: 2),
              ),
            );


          }else {
            isKnightTurn = true;
          }
        }
        selectedPiece = '';
        resetValidMoves();
      }
      setState(() {});
    }

    void KnightWins(){
       showDialog(
        context: context,
        builder: (_) => AlertDialog(
          //
          title:  Text("Knight Wins!",style: TextStyle(
              color: const Color(0xff26322d),
              fontSize: 25.sp,
              fontWeight: FontWeight.bold
          ),),



          actions: [
            Lottie.asset("assets/Congrats.json"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  home_v(knightScore: chessScore,pawnScore: pawnScore,)));

                  },
                  child: Container(
                    width: 15.w,
                    height: 4.h,
                    decoration: const BoxDecoration(
                      color: Color(0xff26322d),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                      ),

                    ),
                    child: Center(child: Text("Ok",style: TextStyle(color: const Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 16.sp),)),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ChessBoard()));

                  },
                  child: Container(
                    width: 17.w,
                    height: 4.h,
                    decoration: const BoxDecoration(
                      color: Color(0xff26322d),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                      ),

                    ),
                    child: Center(child: Text("Restart",style: TextStyle(color: const Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 16.sp),)),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
    void PawnWins(){
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          //
          title:  Text("Pawn Wins!",style: TextStyle(
              color: const Color(0xff26322d),
              fontSize: 25.sp,
              fontWeight: FontWeight.bold
          ),),



          actions: [
            Lottie.asset("assets/Congrats.json"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  home_v(knightScore: chessScore,pawnScore: pawnScore,)));

                  },
                  child: Container(
                    width: 15.w,
                    height: 4.h,
                    decoration: const BoxDecoration(
                      color: Color(0xff26322d),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                      ),

                    ),
                    child: Center(child: Text("Ok",style: TextStyle(color: const Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 16.sp),)),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ChessBoard()));

                  },
                  child: Container(
                    width: 17.w,
                    height: 4.h,
                    decoration: const BoxDecoration(
                      color: Color(0xff26322d),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                      ),

                    ),
                    child: Center(child: Text("Restart",style: TextStyle(color: const Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 16.sp),)),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    Widget buildSquare(int row, int col) {
      bool isDark = (row + col) % 2 == 1;
      Color color = isDark ? darkSquareColor : lightSquareColor;

      Widget? piece;
      if (row == knightRow && col == knightCol) {
        piece = WhiteKnight(size: 50,);
      } else if (row == pawnRow && col == pawnCol) {
        piece = BlackPawn(size: 50,);
      }

      return GestureDetector(
        onTap: () => handleTap(row, col),
        child: Container(
          decoration: BoxDecoration(
            color: validMoves[row][col] ? Colors.greenAccent : color,
          ),
          child: Center(child: piece),
        ),
      );
    }

    Widget buildBoardWithBorders() {
      return Container(

        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: border3,
          border: Border.all(color: border3, width: 6),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: border2,
            border: Border.all(color: border2, width: 6),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: border1,
              border: Border.all(color: border1, width: 6),
            ),
            child: GridView.builder(
              itemCount: 64,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
              itemBuilder: (context, index) {
                int row = index ~/ 8;
                int col = index % 8;
                return buildSquare(row, col);
              },
            ),
          ),
        ),
      );
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Row(

                children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  home_v(knightScore: chessScore,pawnScore: pawnScore,)));
                  },
                  child: Container(
                    width: 20.w,
                    height: 5.h,
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.white,width: 2),
                     borderRadius: const BorderRadius.only(
                         topLeft: Radius.circular(20),
                         bottomRight: Radius.circular(20)
                     ),
                     color: const Color(0xff26322d)
                   ),
                    child: const Center(
                      child: Text("Exit",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ),
                  SizedBox(width: 15.w,),

                  const Text(
                    "Knight VS Pawn" ,
                    style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            SizedBox(
              height: 45.1.h,
              child: buildBoardWithBorders(),
            ),
            SizedBox(height: 3.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(22),
                         border: Border.all(color: Colors.black,width: 1),


                         gradient:  const LinearGradient(colors:  [Color(0xff8b9e92) , Color(0xff223329)],begin: Alignment.topCenter ,end: Alignment.bottomCenter)
                       ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Knight",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 2,top: 5),
                      child: Container(
                        width: 15.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 1),
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xff284641)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WhiteKnight(size: 50,),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(22),
                            border: Border.all(color: Colors.black,width: 1),
                            gradient: const LinearGradient(colors: [Color(0xff8b9e92) , Color(0xff223329)],begin: Alignment.topCenter ,end: Alignment.bottomCenter)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Pawn",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 2,top: 5),
                      child: Container(
                        width: 15.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1),
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff284641)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlackPawn(size: 50,),
                          ],
                        ),
                      ),
                    )

                  ],
                )
              ],
            ),
            SizedBox(height: 3.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(secondsLeft == 60? "$secondsLeft":"00:$secondsLeft",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp
                ),),
              ],
            )
          ],
        ),
      );
    }

    @override
    void dispose() {
      _timer?.cancel();
      super.dispose();
    }
  }
