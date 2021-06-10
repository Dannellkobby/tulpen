import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulpen/models/menu_item.dart';
import 'package:tulpen/statics/colours.dart';

class MenuItemDetail extends StatefulWidget {
  final MenuItem menuItem;

  const MenuItemDetail({required this.menuItem, Key? key}) : super(key: key);

  @override
  State<MenuItemDetail> createState() => _MenuItemDetailState();
}

class _MenuItemDetailState extends State<MenuItemDetail> with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animation = ColorTween(begin: Colours.transparent, end: Colours.red).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    Future.delayed(const Duration(milliseconds: 800)).then((value) => controller.forward());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colours.red,
        brightness: Brightness.dark,
        toolbarHeight: Get.width / 1.5,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          // overflow: Overflow.visible,
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoCard(
                        elevation: 6.0,
                        color: Colors.white,
                        radius: const BorderRadius.all(
                          Radius.circular(28.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      CupertinoCard(
                        child: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Center(
                                  child: Text(
                                '··',
                                style: TextStyle(fontSize: 30, height: 1),
                              )),
                            ),
                          ),
                        ),
                        elevation: 6.0,
                        // margin: const EdgeInsets.all(4.0),
                        color: Colours.white,
                        radius: const BorderRadius.all(
                          Radius.circular(28.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 48,
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
              ),
            ),
            Positioned(
              bottom: -96,
              right: 0,
              left: 0,
              child: Hero(
                tag: 'meal${menuItem.id}',
                child: Image.asset(
                  'assets/images/menu_appetizer_Kroketten_720_shadow.png',
                  fit: BoxFit.scaleDown,
                  height: Get.width / 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 32.0, right: 32, top: (Get.width / 4)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Hero(
                    tag: 'title${menuItem.id}_',
                    child: FadeIn(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        'Kroketten',
                        style: GoogleFonts.ubuntuTextTheme()
                            .headline1!
                            .copyWith(fontSize: 30, color: Colours.dark, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: 'price${menuItem.id}_',
                  child: FadeIn(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 1000),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '€ ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colours.orange,
                            height: 2,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${menuItem.price}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.miriamLibreTextTheme()
                              .headline1!
                              .copyWith(fontSize: 32, color: Colours.orange, fontWeight: FontWeight.bold),
                          // style: TextStyle(
                          //   fontWeight: FontWeight.bold,
                          //   fontSize: 32,
                          //   fontFamily: 'Roboto',
                          // ),
                          // style: GoogleFonts.numansTextTheme().headline1!.copyWith(fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeIn(
                          duration: const Duration(milliseconds: 1000),
                          delay: const Duration(milliseconds: 300),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 28,
                                color: Colours.yellow,
                              ),
                              Text(
                                ' 4.8',
                                textAlign: TextAlign.center,
                                style: Get.textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        FadeIn(
                          duration: const Duration(milliseconds: 1000),
                          delay: const Duration(milliseconds: 400),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.local_fire_department,
                                color: Colours.orange,
                                size: 28,
                              ),
                              Text(
                                ' 150 Kcal',
                                textAlign: TextAlign.center,
                                style: Get.textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        FadeIn(
                          duration: const Duration(milliseconds: 1000),
                          delay: const Duration(milliseconds: 400),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.timer,
                                color: Colors.lightGreen,
                                size: 28,
                              ),
                              Text(
                                ' 5 - 10 min',
                                textAlign: TextAlign.center,
                                style: Get.textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    FadeIn(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: TextStyle(color: Colours.darkGrey),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: animation.value,
        brightness: Brightness.dark,
        toolbarHeight: Get.width / 1.5,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          // overflow: Overflow.visible,
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: FadeOut(
                    delay: const Duration(milliseconds: 0),
                    duration: const Duration(milliseconds: 40),
                    child: FadeIn(
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 400),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoCard(
                            elevation: 6.0,
                            color: Colors.white,
                            radius: const BorderRadius.all(
                              Radius.circular(28.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                controller.reverse();
                                Get.back();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          CupertinoCard(
                            child: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Center(
                                      child: Text(
                                    '··',
                                    style: TextStyle(fontSize: 30, height: 1),
                                  )),
                                ),
                              ),
                            ),
                            elevation: 6.0,
                            // margin: const EdgeInsets.all(4.0),
                            color: Colours.white,
                            radius: const BorderRadius.all(
                              Radius.circular(28.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 48,
                decoration: const BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 48,
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0))),
              ),
            ),
            Positioned(
              bottom: -96,
              right: 0,
              left: 0,
              child: Hero(
                tag: 'meal${widget.menuItem.id}',
                child: Image.asset(
                  'assets/images/menu_appetizer_Kroketten_720_shadow.png',
                  fit: BoxFit.scaleDown,
                  height: Get.width / 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 32.0, right: 32, top: (Get.width / 4)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Hero(
                    tag: 'title${widget.menuItem.id}_',
                    child: Text(
                      'Kroketten',
                      style:
                          GoogleFonts.ubuntuTextTheme().headline1!.copyWith(fontSize: 30, color: Colours.dark, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Hero(
                  tag: 'price${widget.menuItem.id}_',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '€ ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colours.orange,
                          height: 2,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${widget.menuItem.price}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.miriamLibreTextTheme()
                            .headline1!
                            .copyWith(fontSize: 32, color: Colours.orange, fontWeight: FontWeight.bold),
                        // style: TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 32,
                        //   fontFamily: 'Roboto',
                        // ),
                        // style: GoogleFonts.numansTextTheme().headline1!.copyWith(fontWeight: FontWeight.bold, fontSize: 32),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 28,
                              color: Colours.yellow,
                            ),
                            Text(
                              ' 4.8',
                              textAlign: TextAlign.center,
                              style: Get.textTheme.subtitle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: Colours.orange,
                              size: 28,
                            ),
                            Text(
                              ' 150 Kcal',
                              textAlign: TextAlign.center,
                              style: Get.textTheme.subtitle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.timer,
                              color: Colors.lightGreen,
                              size: 28,
                            ),
                            Text(
                              ' 5 - 10 min',
                              textAlign: TextAlign.center,
                              style: Get.textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(color: Colours.darkGrey),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
