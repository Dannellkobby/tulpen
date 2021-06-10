import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tulpen/controllers/navigation_controller.dart';
import 'package:tulpen/statics/strings.dart';
import 'package:tulpen/ui/screens/home.dart';
import 'package:tulpen/ui/screens/menu.dart';
import 'package:tulpen/ui/screens/menu_item_detail.dart';

class Router {
  Router._(); //this is to prevent anyone from instantiating this object

  static void callback(Routing? callback) {
    NavigationController.to.currentScreen.value = callback?.current ?? '';

    // if (kDebugMode) {
    //   print('Router.callback: from ${callback!.previous} to ${callback.current} ');
    // }
  }

  static final pages = [
    GetPage(name: Strings.routeHome, page: () => const Home()),
    GetPage(name: Strings.routeMenu, page: () => const Menu()),
    GetPage(
        name: Strings.routeMenuItem,
        transitionDuration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubicEmphasized,
        transition: Transition.downToUp,
        page: () => MenuItemDetail(
              menuItem: Get.arguments['menuItem'],
            )),
    GetPage(
        name: Strings.routeAccount,
        page: () => Container(
              color: Colors.blue,
            )),
    GetPage(
        name: Strings.routeFavourites,
        page: () => Container(
              color: Colors.pinkAccent,
            )),
    GetPage(
        name: Strings.routeCart,
        page: () => Container(
              color: Colors.grey,
            )),
  ];
}
