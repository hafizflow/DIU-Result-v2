import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InitialAnimation extends StatelessWidget {
  const InitialAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.sizeOf(context).height * .1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/a.json',
                width: MediaQuery.sizeOf(context).width * .8,
                height: MediaQuery.sizeOf(context).height * .4,
                fit: BoxFit.fitWidth,
              ),
              const Text(
                'Search your result',
                style: TextStyle(letterSpacing: 1, wordSpacing: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
