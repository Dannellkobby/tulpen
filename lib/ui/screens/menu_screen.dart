import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tulpen/controllers/menus_controller.dart';
import 'package:tulpen/statics/colours.dart';
import 'package:tulpen/ui/components/menu_categories.dart';
import 'package:tulpen/ui/components/product_card_tile.dart';
import 'package:tulpen/ui/components/search_hint.dart';

class MenuScreen extends GetView<MenusController> {
  MenuScreen({Key? key}) : super(key: key);

  // final MenusController controller = MenusController.to;
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 32.0, right: 32),
              child: SearchableHint(height: 56),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: MenuCategory(
                onTap: (i) {
                  _scrollController.scrollTo(duration: const Duration(milliseconds: 600), index: i * 2, curve: Curves.easeOutQuad);
                },
              ),
            ),
            Expanded(
              child: ScrollablePositionedList.builder(
                physics: const BouncingScrollPhysics(),
                itemScrollController: _scrollController,
                itemBuilder: (BuildContext context, int index) => [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Appetizers',
                      style: Get.textTheme.subtitle1!.copyWith(color: Colours.darkGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                      crossAxisCount: 4,
                      itemBuilder: (context, index) {
                        var menu = controller.itemsAppetizers[index];
                        return ProductCardTile(ObjectKey(menu.key), menu);
                      },
                      itemCount: controller.itemsAppetizers.length,
                      mainAxisSpacing: 32.0,
                      crossAxisSpacing: 10,
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Main dishes',
                      style: Get.textTheme.subtitle1!.copyWith(color: Colours.darkGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                      crossAxisCount: 4,
                      itemBuilder: (context, index) {
                        var menu = controller.itemsMain[index];
                        return ProductCardTile(ObjectKey(menu.key), menu);
                      },
                      itemCount: controller.itemsMain.length,
                      mainAxisSpacing: 32.0,
                      crossAxisSpacing: 10,
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Salads',
                      style: Get.textTheme.subtitle1!.copyWith(color: Colours.darkGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                      crossAxisCount: 4,
                      itemBuilder: (context, index) {
                        var menu = controller.itemsSalads[index];
                        return ProductCardTile(ObjectKey(menu.key), menu);
                      },
                      itemCount: controller.itemsSalads.length,
                      mainAxisSpacing: 32.0,
                      crossAxisSpacing: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Desserts',
                      style: Get.textTheme.subtitle1!.copyWith(color: Colours.darkGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      physics: const NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                      crossAxisCount: 4,
                      itemBuilder: (context, index) {
                        var menu = controller.itemsDesserts[index];
                        return ProductCardTile(ObjectKey(menu.key), menu);
                      },
                      itemCount: controller.itemsDesserts.length,
                      mainAxisSpacing: 32.0,
                      crossAxisSpacing: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Wines',
                      style: Get.textTheme.subtitle1!.copyWith(color: Colours.darkGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                      crossAxisCount: 4,
                      itemBuilder: (context, index) {
                        var menu = controller.itemsWines[index];
                        return ProductCardTile(ObjectKey(menu.key), menu);
                      },
                      itemCount: controller.itemsWines.length,
                      mainAxisSpacing: 32.0,
                      crossAxisSpacing: 10,
                    ),
                  ),
                ][index],
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
