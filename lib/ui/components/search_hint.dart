import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tulpen/statics/colours.dart';

class SearchableHint extends StatelessWidget {
  final searchableItemsList = [
    'Explore our latest menu ...',
    'From Appetizers...',
    'To Drinks...',
    'Salads...',
    'Soups...',
    'Desserts...',
    'Side dishes...',
    'and Main dishes...',
    'Even ${DateFormat.EEEE().format(DateTime.now())} specials...',
    'Welcome to De Tulpen',
  ];

  final double height;

  SearchableHint({
    Key? key,
    required this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'searchAppBar',
      child: Container(
        height: height,
        padding: const EdgeInsets.only(left: 12),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Align(
              alignment: const Alignment(-0.96, 0),
              child: SvgPicture.asset(
                'assets/icons/icon_search_gradient.svg',
                color: Colours.darkGrey,
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: CarouselSlider(
                items: searchableItemsList.map((i) {
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      i,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colours.darkGrey),
                    ),
                  );
                }).toList(),
                options:
                    CarouselOptions(autoPlay: true, scrollDirection: Axis.vertical, autoPlayInterval: const Duration(milliseconds: 2300)),
                // CarouselOptions(autoPlay: true, scrollDirection: Axis.vertical, autoPlayInterval: const Duration(milliseconds: 1800)),
              ),
            ),
          ],
        ),
        decoration: const BoxDecoration(color: Colours.light, borderRadius: BorderRadius.all(Radius.circular(22))),
      ),
    );
  }
}
