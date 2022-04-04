/*
    Created by Shawon Lodh on 01 February 2022
*/

import 'package:flutter/material.dart';

class SplashScreenData {
  AnimationController? animationController;

  /// Constructor
  SplashScreenData({required this.animationController});


  ///  Animation Controller Value
  AnimationController? get animationControllerValue{
    return animationController;
  }

  set isBluetoothOnValue(AnimationController? valueAnimationController) {
    animationController = valueAnimationController;
  }

}