import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tulpen/controllers/navigation_controller.dart';
import 'package:tulpen/models/menu_item.dart';
import 'package:tulpen/statics/colours.dart';
import 'package:tulpen/statics/strings.dart';
import 'package:tulpen/ui/components/add_to_list.dart';

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

class ProductCardTile extends StatelessWidget {
  final MenuItem menuItem;
  const ProductCardTile(Key key, this.menuItem) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: NavigationController.to.themeA.value
            ? BoxDecoration(
                color: Colours.white,
                boxShadow: [
                  BoxShadow(
                    color: Colours.grey.withOpacity(0.42),
                    blurRadius: 2,
                    offset: const Offset(2, 2),
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(28)),
              )
            : const BoxDecoration(
                color: Colours.light,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
        child: InkWell(
          onTap: () {
            Get.toNamed(Strings.routeMenuItem, arguments: {'menuItem': menuItem});
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 10),
                child: Hero(
                  tag: 'meal${menuItem.id}',
                  child: Image.asset(
                    menuItem.image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Hero(
                        tag: 'title${menuItem.id}',
                        child: Text(
                          menuItem.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.caption?.copyWith(fontWeight: FontWeight.bold, color: Colours.dark),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Hero(
                        tag: 'price${menuItem.id}',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '€ ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colours.orange,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              '${menuItem.price}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colours.orange,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const AddToListButton()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    // return OpenContainer(
    //   transitionType: ContainerTransitionType.fade,
    //   tappable: false,
    //   closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    //
    //   closedBuilder: (BuildContext _, VoidCallback openContainer) => Column(
    //     children: <Widget>[
    //       Padding(
    //         padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 10),
    //         child: InkWell(
    //           onTap: () {
    //             Get.toNamed(Strings.routeMenuItem, arguments: {'menuItem': menuItem});
    //           },
    //           child: Hero(
    //             tag: 'meal${menuItem.id}',
    //             child: Image.asset(
    //               menuItem.image,
    //               fit: BoxFit.fitHeight,
    //             ),
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.only(bottom: 6),
    //               child: Hero(
    //                 tag: 'title${menuItem.id}',
    //                 child: Text(
    //                   menuItem.title,
    //                   textAlign: TextAlign.center,
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: Get.textTheme.caption?.copyWith(fontWeight: FontWeight.bold, color: Colours.dark),
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(bottom: 12),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Hero(
    //                     tag: 'currency${menuItem.id}',
    //                     child: const Text(
    //                       '€ ',
    //                       textAlign: TextAlign.center,
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         color: Colours.orange,
    //                         fontSize: 10,
    //                       ),
    //                     ),
    //                   ),
    //                   Hero(
    //                     tag: 'price${menuItem.id}',
    //                     child: Text(
    //                       '${menuItem.price}',
    //                       textAlign: TextAlign.center,
    //                       style: const TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         color: Colours.orange,
    //                         fontSize: 16,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const AddToListButton()
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    //   // useRootNavigator: true,
    //   routeSettings: const RouteSettings(name: '/menuDetail', arguments: 'beef burg'), useRootNavigator: false,
    //   transitionDuration: const Duration(milliseconds: 500),
    //   openBuilder: (BuildContext context, void Function({Object? returnValue}) action) {
    //     return MenuItemDetail(
    //       menuItem: menuItem,
    //     );
    //   },
    // );
  }
}
