import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tulpen/controllers/navigation_controller.dart';
import 'package:tulpen/models/menu_item.dart';
import 'package:tulpen/statics/colours.dart';
import 'package:tulpen/ui/components/menu_categories.dart';
import 'package:tulpen/ui/components/product_card_tile.dart';
import 'package:tulpen/ui/components/search_hint.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leadingWidth: 32 + 32.0,
      //   // systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.green),
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 32.0),
      //     child: SvgPicture.asset(
      //       'assets/icons/Tulpen logo1.svg',
      //       width: 3,
      //       height: 3,
      //     ),
      //   ),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   toolbarHeight: 82,
      //   title: Text(
      //     ' Menu',
      //     style: Get.textTheme.headline3,
      //   ),
      //   actions: [
      //     InkWell(
      //       child: const CircleAvatar(
      //         backgroundColor: Colours.red,
      //         radius: 16,
      //         child: Icon(
      //           Icons.account_circle_rounded,
      //           color: Colors.white,
      //           size: 18,
      //         ),
      //       ),
      //       onTap: () {
      //         NavigationController.to.themeA.toggle();
      //       },
      //     ),
      //     const SizedBox(
      //       width: 32,
      //     )
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32, bottom: 24),
                    child: SearchableHint(height: 56),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32, bottom: 24),
                    child: MenuCategory(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32),
                    child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                      crossAxisCount: 4,
                      itemBuilder: (context, index) => ProductCardTile(
                        ObjectKey(index.toString()),
                        MenuItem(
                            id: index.toString(),
                            title: 'Krokoten',
                            image: 'assets/images/menu_appetizer_Kroketten_720_shadow.png',
                            kCal: '148',
                            price: 28.5,
                            rating: 4.8),
                      ),
                      itemCount: 18,
                      mainAxisSpacing: 32.0,
                      crossAxisSpacing: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
