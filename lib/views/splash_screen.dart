

import 'dart:async';

import 'package:covid_tracker/views/world_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
 late final AnimationController _controller = AnimationController(
   duration: Duration(seconds: 3),
   vsync: this,)..repeat();
 @override
  void dispose() {
   super.dispose();
   _controller.dispose();
  }

  @override
  void initState() {
     Timer(Duration(seconds: 5), (){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WorldStatesScreen()));
     });
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           AnimatedBuilder(animation:_controller ,
               child: Container(
                 width: 200,
                 height: 200,
                 child: const Center(
                   child: Image(image: AssetImage('assets/images/virus.png')),
                 ),
               ),
               builder: (BuildContext context, Widget? chiild){
             return Transform.rotate(angle: _controller.value * 2.0 * math.pi,
             child: chiild,);
           }),
           SizedBox(
             height: MediaQuery.of(context).size.height * .08,
           ),
           Align(
               alignment: Alignment.center,
               child: Text('COVID-19\nTracker App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
               textAlign: TextAlign.center,
               ))
         ],
       )),
    );
  }


}