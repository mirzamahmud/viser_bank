

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_color.dart';

class MyUtil{

  static changeTheme(){
    SystemChrome.setSystemUIOverlayStyle(

        const SystemUiOverlayStyle(

            statusBarColor: MyColor.primaryColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: MyColor.navigationBarColor,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );
  }


  static String get _getDeviceType {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.width < 550 ? 'phone' : 'tablet';
  }

  static bool get isTablet {
  return _getDeviceType == 'tablet';
  }


}