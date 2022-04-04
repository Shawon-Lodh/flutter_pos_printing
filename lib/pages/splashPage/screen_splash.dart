/*
    Created by Shawon lodh on 2 January 2022
*/

import 'package:flutter/material.dart';
import 'package:flutter_pos_printing/pages/splashPage/data_splash.dart';
import 'package:flutter_pos_printing/pages/splashPage/presenter_splash.dart';
import 'package:material_dialogs/material_dialogs.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key,}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  SplashScreenData? _splashScreenData;
  SplashScreenPresenter? _splashScreenPresenter;

  @override
  initState() {
    super.initState();
    _splashScreenData = SplashScreenData(animationController: AnimationController(vsync: this));
    _splashScreenPresenter = SplashScreenPresenter(context: context, splashScreenData: _splashScreenData);
  }

  @override
  void dispose() {
    _splashScreenPresenter = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getLoadingIcon(),
      )
    );
  }

  Widget _getLoadingIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 2,
          child: Lottie.asset('assets/lottiefiles/lottie_splash_screen.zip',
          controller: _splashScreenData!.animationControllerValue,
            onLoaded: _splashScreenPresenter!.goToHomePage,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(text: "Easy", style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff424242),
              )),
              TextSpan(text: "-", style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff424242),
              )),
              TextSpan(text: "Print", style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff424242),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

