import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tulpen/statics/colours.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: SvgPicture.asset(
            'assets/icons/tulpen_home.svg',
            height: Get.height,
            fit: BoxFit.fitHeight,
          )),
    );
  }
}
