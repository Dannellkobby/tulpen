import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tulpen/statics/strings.dart';
import 'package:tulpen/ui/components/navigator_layout.dart';
import 'package:tulpen/ui/screens/favourites_screen.dart';
import 'package:tulpen/ui/screens/menu_screen.dart';
import 'package:tulpen/ui/screens/menu_item_detail.dart';
import 'package:tulpen/ui/screens/list_reservations.dart';

class Router {
  Router._(); //this is to prevent anyone from instantiating this object

  static void callback(Routing? callback) {
    // NavigationController.to.currentScreen.value = callback?.current ?? '';

    // if (kDebugMode) {
    //   print('Router.callback: from ${callback!.previous} to ${callback.current} ');
    // }
  }

  static final pages = [
    GetPage(name: Strings.routeMain, page: () => const NavigatorLayout()),
    // GetPage(name: Strings.routeReservations, page: () => const ListReservations()),
    GetPage(name: Strings.routeReservations, page: () => const ListReservations()),
    GetPage(name: Strings.routeMenu, page: () => MenuScreen()),
    GetPage(name: Strings.routeFavourites, page: () => FavouritesScreen()),
    GetPage(
        name: Strings.routeMenuItem,
        transitionDuration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubicEmphasized,
        transition: Transition.downToUp,
        page: () => MenuItemDetail(
              menuItem: Get.arguments['menuItem'],
              source: Get.arguments['source'],
            )),
    GetPage(
        name: Strings.routeAccount,
        page: () => Container(
              color: Colors.blue,
            )),

    GetPage(
        name: Strings.routeCart,
        page: () => Container(
              color: Colors.grey,
            )),
  ];
}
