import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_services_fyp/Pages/splashScreen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.Navigate();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                child: Text('E-Services',style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold
                ),)
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Image(
                    image: AssetImage('assets/images/splashImage.jpg'),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      child: Text("All Services",style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold,color: Colors.deepPurple),),
                    ),
                    Container(
                      child: AnimatedTextKit(
                        isRepeatingAnimation: true,
                        repeatForever: true,

                        animatedTexts: [
                          TypewriterAnimatedText('On Door Step',textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.deepPurple),speed: Duration(milliseconds: 100)),

                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
