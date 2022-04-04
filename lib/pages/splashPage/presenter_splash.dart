/*
    Created by Shawon lodh on 2 January 2022
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos_printing/common/constants/app_routes.dart';
import 'package:flutter_pos_printing/common/utils/app_navigation_util.dart';
import 'package:flutter_pos_printing/pages/splashPage/data_splash.dart';

class SplashScreenPresenter {
  BuildContext context;
  SplashScreenData? splashScreenData;
  /// Constructor
  SplashScreenPresenter({required this.context, required this.splashScreenData});

  ///navigation
  goToHomePage(composition) {
    splashScreenData!.animationControllerValue
    !..duration = composition.duration
      ..forward().whenComplete(() => NavigatorUtil.instance.goToNextScreenDestroyingPrevious(context, AppRoutes.homePageAddress));
  }



}
