import 'package:chess_algorithm/Views/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class welcome_v extends StatefulWidget {
  const welcome_v({super.key});

  @override
  State<welcome_v> createState() => _welcome_vState();
}

class _welcome_vState extends State<welcome_v> with TickerProviderStateMixin {

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Column(
                  children: [
                    Text("Welocme to",style: TextStyle(color: const Color(0xff284641),fontWeight: FontWeight.bold,fontSize: 17.sp),),
                    Text("chess.io",style: TextStyle(color: const Color(0xff284641),fontWeight: FontWeight.bold,fontSize: 17.sp),),


                  ],

                ),
                Lottie.asset("assets/Animation - 1745179698943.json",frameRate: const FrameRate(120),repeat: false,height: 50,width: 50),






              ],
            ),
          ),
          SizedBox(height: 15.h,),
          Lottie.asset("assets/Animation - 1745179698943.json",frameRate: const FrameRate(120),repeat: true,),
          SizedBox(height:25.9.h),
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  home_v(knightScore: 0,pawnScore: 0,)));

            },

            child: Container(
              width: 50.w,
              height: 4.h,
              decoration: const BoxDecoration(
                color: Color(0xff284641),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                ),

              ),
              child: Center(child: Text("Let's Play",style: TextStyle(color: const Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 16.sp),)),
            ),
          )


        ],
      ),
    );
  }
}
