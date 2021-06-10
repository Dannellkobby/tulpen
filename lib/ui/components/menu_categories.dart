import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tulpen/controllers/navigation_controller.dart';
import 'package:tulpen/statics/colours.dart';

class MenuCategoryItem {
  late String title;
  late String image;
  late String key;

  MenuCategoryItem(this.title, this.image, this.key);
}

class MenuCategory extends StatelessWidget {
  final categories = <MenuCategoryItem>[
    MenuCategoryItem('Appetizer', 'assets/icons/barbecue.svg', '0'),
    MenuCategoryItem('Main dishes', 'assets/icons/fried-rice.svg', '1'),
    MenuCategoryItem('Salads', 'assets/icons/salad copy.svg', '2'),
    MenuCategoryItem('Soups', 'assets/icons/soup_1.svg', '3'),
    MenuCategoryItem('Side dishes', 'assets/icons/chicken-leg.svg', '4'),
    MenuCategoryItem('Desserts', 'assets/icons/apple.svg', '5'),
    MenuCategoryItem('Drinks', 'assets/icons/cocktail.svg', '6'),
  ];

  MenuCategory({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: categories.map((i) {
          return InkWell(
            onTap: () {
              NavigationController.to.currentCategoryIndex.value = i.key;
            },
            highlightColor: Colours.light,
            borderRadius: BorderRadius.circular(22),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    padding: const EdgeInsets.all(14),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      i.image,
                    ),
                    decoration: BoxDecoration(
                        color: Colours.light,
                        boxShadow: NavigationController.to.currentCategoryIndex.value == i.key
                            ? [
                                BoxShadow(
                                  color: Colours.grey.withOpacity(0.82),
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                )
                              ]
                            : null,
                        borderRadius: const BorderRadius.all(Radius.circular(22))),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      i.title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Get.textTheme.caption
                          ?.copyWith(color: NavigationController.to.currentCategoryIndex.value == i.key ? Colours.dark : Colours.grey),
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
