import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:tulpen/models/menu_item.dart';
import 'package:tulpen/statics/strings.dart';

class NavigationController extends GetxController {
  static NavigationController to = Get.find();
  static const int routeIndexHome = 0;
  static const int routeIndexMenu = 1;
  static const int routeIndexFavs = 2;
  static const int routeIndexCart = 3;
  var navBarVisible = true.obs;
  var exitWindowOpen = false;
  var themeA = true.obs;
  // var mainScreen = true.obs;
  var selectedMenuItem = MenuItem(key: '').obs;
  // var currentScreen = Strings.routeMenu.obs;
  var currentIndex = 0.obs;
  var currentCategoryIndex = '0'.obs;
  Timer exitTimer = Timer(const Duration(milliseconds: 0), () {});

  void exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  openExitWindow() {
    print('NavigationController.openExitWindow start: $exitWindowOpen');
    exitWindowOpen = true;
    exitTimer.cancel();
    exitTimer = Timer(const Duration(milliseconds: 3000), () {
      print('NavigationController.openExitWindow end: $exitWindowOpen');
      exitWindowOpen = false;
    });
  }

  String getCurrentScreenName() {
    switch (currentIndex.value) {
      case 0:
        return '';
      case 1:
        return 'Menu';
      case 2:
        return 'Favourites';
      case 3:
        return 'Cart';
      default:
        return '';
    }
  }
}
