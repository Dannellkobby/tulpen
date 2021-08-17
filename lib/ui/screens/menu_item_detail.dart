import 'dart:math';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:tulpen/controllers/menus_controller.dart';
import 'package:tulpen/models/menu_item.dart';
import 'package:tulpen/statics/colours.dart';
import 'package:tulpen/ui/components/add_to_cart.dart';

class MenuItemDetail extends GetView<MenusController> {
  final MenuItem menuItem;
  final String source;

  const MenuItemDetail({required this.source, required this.menuItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colours.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: Get.width / 1.5,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          // overflow: Overflow.visible,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: double.maxFinite,
                decoration: const BoxDecoration(
                    color: Colours.red, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: FadeIn(
                    delay: const Duration(milliseconds: 400),
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
                          elevation: 6.0,
                          color: Colours.white,
                          radius: const BorderRadius.all(
                            Radius.circular(28.0),
                          ),
                          child: FittedBox(
                            // height: 24,
                            // width: 24,
                            alignment: Alignment.center,
                            fit: BoxFit.scaleDown,
                            child: Obx(
                              () => LikeButton(
                                likeCount: null,
                                size: 24,
                                onTap: (bool liked) async {
                                  controller.toggleFavourite(menuItem);
                                  return Future.value(true);
                                },
                                padding: const EdgeInsets.only(left: 8, right: 6, top: 8, bottom: 8),
                                isLiked: (controller.favourites.any((e) => e.key == menuItem.key)),
                                circleColor: const CircleColor(start: Colours.orange, end: Colours.red),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Colours.red,
                                  dotSecondaryColor: Colours.orange,
                                ),
                                likeBuilder: (bool isLiked) {
                                  return isLiked
                                      ? const Icon(
                                          Icons.favorite_rounded,
                                          color: Colours.red,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.favorite_border_rounded,
                                          size: 20,
                                        );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                tag: '$source${menuItem.key}',
                child: CachedNetworkImage(
                  imageUrl: menuItem.image,
                  fit: BoxFit.scaleDown,
                  height: Get.width / 1.5,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    tag: 'title${menuItem.key}_',
                    child: FadeIn(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        menuItem.name,
                        style: GoogleFonts.ubuntuTextTheme()
                            .headline1!
                            .copyWith(fontSize: 30, color: Colours.dark, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: 'price${menuItem.key}_',
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
                                '${menuItem.rating ?? (Random().nextDouble() * 5).toPrecision(1)}',
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
                                '${menuItem.kCal} kCal',
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
                      child: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: TextStyle(color: Colours.darkGrey),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: AddToListButton(
                height: 48,
                cartKey: menuItem.key,
                title: 'ADD TO CART',
                minWidth: Get.width * 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
