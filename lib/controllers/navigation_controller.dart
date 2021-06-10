import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:tulpen/models/menu_item.dart';
import 'package:tulpen/statics/strings.dart';

class NavigationController extends GetxController {
  static NavigationController to = Get.find();
  var navBarVisible = true.obs;
  var themeA = true.obs;
  var mainScreen = true.obs;
  var selectedMenuItem = MenuItem().obs;
  var currentScreen = Strings.routeMenu.obs;
  var currentIndex = 0.obs;
  var currentCategoryIndex = '0'.obs;

  void exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  void onReady() {
    super.onReady();
    ever(currentScreen, (currentScreen) {
      switch (currentScreen) {
        case Strings.routeHome:
          NavigationController.to.currentIndex.value = 0;
          mainScreen.value = true;
          break;
        case Strings.routeMenu:
          NavigationController.to.currentIndex.value = 1;
          mainScreen.value = true;
          break;
        case Strings.routeFavourites:
          NavigationController.to.currentIndex.value = 2;
          mainScreen.value = true;
          break;
        case Strings.routeCart:
          NavigationController.to.currentIndex.value = 3;
          mainScreen.value = true;
          break;
        default:
          mainScreen.value = false;
          break;
      }
    });
  }

  String getCurrentScreenName() {
    switch (currentScreen.value) {
      case Strings.routeHome:
        return '';
      case Strings.routeMenu:
        return 'Menu';
      case Strings.routeFavourites:
        return 'Favs';
      case Strings.routeCart:
        return 'Cart';
      default:
        return '';
    }
  }
}
