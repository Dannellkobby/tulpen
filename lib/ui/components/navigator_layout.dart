import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tulpen/controllers/navigation_controller.dart';
import 'package:tulpen/statics/colours.dart';
import 'package:tulpen/ui/screens/carts_screen.dart';
import 'package:tulpen/ui/screens/favourites_screen.dart';
import 'package:tulpen/ui/screens/home.dart';
import 'package:tulpen/ui/screens/menu_screen.dart';

class NavigatorLayout extends StatelessWidget {
  // final Widget? child;

  const NavigatorLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () {
          if (NavigationController.to.currentIndex.value != 0) {
            NavigationController.to.currentIndex.value = 0;
            return Future.value(false);
          }

          if (NavigationController.to.exitWindowOpen) {
            return Future.value(true);
          } else {
            NavigationController.to.openExitWindow();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tap again to exit!')));
          }

          return Future.value(false);
        },
        child: Scaffold(
            body: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Stack(
                children: [
                  IndexedStack(
                    index: NavigationController.to.currentIndex.value,
                    children: [
                      const Home(),
                      MenuScreen(),
                      FavouritesScreen(),
                      CartScreen(),
                    ],
                  ),
                  Positioned(
                    top: 18,
                    left: 0,
                    right: 0,
                    child: Obx(
                      () => AppBar(
                        leadingWidth: 32 + 32.0,
                        leading: NavigationController.to.currentIndex.value == NavigationController.routeIndexMenu
                            ? Padding(
                                padding: const EdgeInsets.only(left: 32.0),
                                child: SvgPicture.asset(
                                  'assets/icons/tulpen_logo.svg',
                                  width: 3,
                                  height: 3,
                                ),
                              )
                            : const SizedBox.shrink(),
                        centerTitle: true,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        title: Text(
                          NavigationController.to.getCurrentScreenName(),
                          style: Get.textTheme.headline3?.copyWith(fontSize: 32),
                        ),
                        actions: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(const CircleBorder()),
                                  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colours.red,
                                  )),
                              child: SvgPicture.asset(
                                'assets/icons/user.svg',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 32,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colours.light,
              buttonBackgroundColor: Colours.red,
              index: NavigationController.to.currentIndex.value,
              animationDuration: const Duration(milliseconds: 200),
              height: 54.0 + (context.mediaQueryPadding.bottom / 2),
              items: [
                SvgPicture.asset('assets/icons/tulpen_logo.svg',
                    color: NavigationController.to.currentIndex.value == 0 ? Colours.white : Colors.grey, height: 20),
                SvgPicture.asset('assets/icons/fork_n_knife.svg',
                    color: NavigationController.to.currentIndex.value == 1 ? Colours.white : Colors.grey, height: 20),
                SvgPicture.asset('assets/icons/heart.svg',
                    color: NavigationController.to.currentIndex.value == 2 ? Colours.white : Colors.grey, height: 20),
                SvgPicture.asset('assets/icons/cart.svg',
                    color: NavigationController.to.currentIndex.value == 3 ? Colours.white : Colors.grey, height: 20),
              ],
              onTap: (index) {
                NavigationController.to.currentIndex.value = index;
              },
            )),
      ),
    );
  }
}

// class NavBarMenu extends StatelessWidget {
//   final String icon;
//   final String iconPressed;
//   final String title;
//   final String route;
//
//   const NavBarMenu({this.icon, this.iconPressed, this.title, this.route});
//
//   @override
//   Widget build(BuildContext context) {
//     // print('selected ${route}');
//
//     return Obx(() {
//       final selected = Get.find<NavigationController>().currentScreen.value == route;
//       return Expanded(
//         child: Container(
//           child: Material(
//             type: MaterialType.transparency,
//             child: InkWell(
//               onTap: () {
//                 Get.toNamed(route);
//               },
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset(selected ? iconPressed : icon),
//                   SizedBox(height: 2),
//                   FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         title,
//                         style: Get.textTheme.caption.copyWith(
//                             color: selected ? Colors.grey.shade800 : Colors.grey.shade800,
//                             fontWeight: selected ? FontWeight.w600 : FontWeight.w500),
//                       ))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
/*/*    return Material(
      child: Stack(
        children: [
          child!,
          Align(
            alignment: Alignment.bottomCenter,
            child: CurvedNavigationBar(
              backgroundColor: Colours.light,
              buttonBackgroundColor: Colours.red,
              index: NavigationController.to.currentIndex.value,
              animationDuration: const Duration(milliseconds: 200),
              height: 54.0 + (context.mediaQueryPadding.bottom / 2),
              items: [
                SvgPicture.asset('assets/icons/restaurant.svg',
                    color: NavigationController.to.currentIndex.value == 0 ? Colours.white : Colors.grey, height: 24),
                SvgPicture.asset('assets/icons/user.svg',
                    color: NavigationController.to.currentIndex.value == 1 ? Colours.white : Colors.grey, height: 20),
                SvgPicture.asset('assets/icons/heart.svg',
                    color: NavigationController.to.currentIndex.value == 2 ? Colours.white : Colors.grey, height: 20),
                SvgPicture.asset('assets/icons/shopping-cart-2.svg',
                    color: NavigationController.to.currentIndex.value == 3 ? Colours.white : Colors.grey, height: 22),
              ],
              onTap: (index) {
                NavigationController.to.currentIndex.value = index;
              },
            ),
          ),
        ],
      ),
    );*/
*/
