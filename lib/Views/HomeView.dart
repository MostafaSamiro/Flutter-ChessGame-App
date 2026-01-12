import 'package:chess_algorithm/Views/ChessBoardView.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class home_v extends StatelessWidget {

  int knightScore,pawnScore;


   home_v({super.key,required this.knightScore , required this.pawnScore});




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        children: [

          SizedBox(height: 5.h,),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Chess.io",style: TextStyle(
                  color: const Color(0xff284641),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp
                ),),
                Lottie.asset("assets/Animation - 1745179698943.json",frameRate: const FrameRate(120),repeat: false,height: 50,width: 50),

              ],
            ),
          ),
          SizedBox(height:20.h),

          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Container(
              height: 20.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black12,width: 2)
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5,top: 20),
                    child: Row(
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
                                    gradient: const LinearGradient(colors: [Color(0xff8f998f) , Color(0xff223329)],begin: Alignment.topCenter ,end: Alignment.bottomCenter)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Player 1",style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp
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
                                    border: Border.all(color: Colors.white,width: 1),
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color(0xff2f4b3f)
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
                        Container(
                          width: 40.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12,width: 1),
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: Center(
                            child: Text("Score:> ${knightScore}",style: TextStyle(
                              color: const Color(0xff284641),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5,top: 20),
                    child: Row(
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
                                    gradient: const LinearGradient(colors: [Color(0xff8f998f) , Color(0xff223329)],begin: Alignment.topCenter ,end: Alignment.bottomCenter)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Player 2",style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp
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
                                    border: Border.all(color: Colors.white,width: 1),
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color(0xff8f998f)
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
                        ),
                        Container(
                          width: 40.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12,width: 1),
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: Center(
                            child: Text("Score:> ${pawnScore} ",style: TextStyle(
                                color: const Color(0xff284641),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp
                            ),),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),


          SizedBox(height:43.5.h),
           InkWell(
             onTap: (){
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ChessBoard()));

             },
             child: Container(
              width: 70.w,
              height: 6.h,
              decoration: const BoxDecoration(
                color: Color(0xff284641),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                ),

              ),
              child: Center(child: Text("Start The Game",style: TextStyle(color: const Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 16.sp),)),
                       ),
           ),
        ],
      ),

    );
  }
}
