import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tulpen/controllers/navigation_controller.dart';
import 'package:tulpen/statics/colours.dart';
import 'package:tulpen/statics/strings.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/icons/tulpen_home.svg',
            height: Get.height,
            fit: BoxFit.fitHeight,
          ),
          Positioned(
            right: 0,
            top: Get.height / 5,
            left: 0,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/tulpen_logo.svg',
                  height: 84,
                ),
                const SizedBox(height: 22),
                Text(
                  'Welkom\nbij Tulpen',
                  style: Get.textTheme.headline4,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Positioned(
            bottom: Get.height / 3.75,
            left: Get.width * 0.10,
            child: InkWell(
              child: Row(
                children: [
                  Text(
                    'ORDER\nDELICIOUS   \nMEALS',
                    style: Get.textTheme.headline6!.copyWith(color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                    size: 36,
                  )
                ],
              ),
              onTap: () {
                NavigationController.to.currentIndex.value = NavigationController.routeIndexMenu;
              },
            ),
          ),
          Positioned(
            bottom: ((Get.height / 3.75) - (Get.width / 1.5) / 4),
            right: -(Get.width / 6),
            child: Image.asset(
              'assets/images/menu_appetizer_Kroketten_720_shadow.png',
              height: Get.width * 0.6,
              width: Get.width * 0.6,
            ),
          ),
          Positioned(
              bottom: 32,
              right: (Get.width / 2) - ((Get.width * 0.7) / 2),
              // left: 0,
              width: (Get.width * 0.7),
              height: 52,
              child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(Strings.routeReservations);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    overlayColor: MaterialStateProperty.all(Colours.orange.withOpacity(0.5)),
                    side: MaterialStateProperty.all(const BorderSide(color: Colors.white, width: 1.2)),
                  ),
                  child: Text(
                    'Reserve table',
                    style: Get.textTheme.subtitle1!.copyWith(color: Colors.white, letterSpacing: 1),
                  ))),
        ],
      ),
    );
  }
}
