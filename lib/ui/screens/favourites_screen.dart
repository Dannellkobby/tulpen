import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tulpen/controllers/menus_controller.dart';
import 'package:tulpen/models/menu_item.dart';
import 'package:tulpen/statics/colours.dart';
import 'package:tulpen/statics/strings.dart';
import 'package:tulpen/statics/utils.dart';

class FavouritesScreen extends GetView<MenusController> {
  FavouritesScreen({Key? key}) : super(key: key);
  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => controller.favourites.isEmpty
          ? Stack(
              children: [
                Positioned(
                  right: 0,
                  top: Get.height / 2.5,
                  left: 0,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/speech-bubble.svg',
                        height: 84,
                        color: Colours.grey,
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'none\nyet',
                        style: Get.textTheme.headline4,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 48.0),
                  //   child: Text(
                  //     '${controller.favourites.length} Favourites',
                  //     style: Get.textTheme.bodyText2?.copyWith(color: Colors.blueGrey.shade900, fontSize: 18, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final MenuItem item = controller.favourites[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48.0),
                          child: Slidable(
                            key: Key(item.key),
                            controller: slidableController,
                            direction: Axis.horizontal,
                            dismissal: SlidableDismissal(
                              child: const SlidableDrawerDismissal(),
                              //dragDismissible: false,
                              onWillDismiss: (actionType) {
                                if (actionType == SlideActionType.primary) {
                                  Slidable.of(context)?.close();
                                  Get.toNamed(Strings.routeMenuItem, arguments: {'menuItem': item, 'source': 'favs'});
                                  return false;
                                } else {
                                  controller.toggleFavourite(item);
                                  return true;
                                }
                              },
                              onDismissed: (actionType) {
                                // _showSnackBar(context,  ? 'Dismiss Archive' : 'Dimiss Delete');
                                /*      setState(() {
                              items.removeAt(index);
                            });*/
                              },
                            ),
                            actionPane: const SlidableStrechActionPane(),
                            actionExtentRatio: 0.25,
                            child: ListItem(item),
                            actions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 36, right: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: IconSlideAction(
                                    color: Colours.yellow,
                                    icon: Icons.open_in_new_rounded,
                                    foregroundColor: Colors.white,
                                    onTap: () {
                                      Get.toNamed(Strings.routeMenuItem, arguments: {'menuItem': item, 'source': 'favs'});
                                    },
                                  ),
                                ),
                              ),
                            ],
                            secondaryActions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 36, left: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: IconSlideAction(
                                    caption: 'Delete',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () => controller.toggleFavourite(item).catchError((err) {
                                      // toastError(title: 'Delete F failed');
                                      print('deleteReservation caught error $err');
                                    }).then((value) => toastSuccess(title: 'Reservation deleted')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: controller.favourites.length,
                    ),
                  ),
                ],
              ),
            ),
    ));
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}

class ListItem extends StatelessWidget {
  const ListItem(this.item, {Key? key}) : super(key: key);
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Slidable.of(context)?.renderingMode == SlidableRenderingMode.none ? Slidable.of(context)?.open() : Slidable.of(context)?.close(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(right: 24, bottom: 18, top: 18, left: 100),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(color: Colours.light, borderRadius: BorderRadius.circular(22)),
              height: 128,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.name,
                          maxLines: 3,
                          style:
                              Get.textTheme.bodyText2?.copyWith(color: Colors.blueGrey.shade500, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              '${item.price}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colours.orange,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32)
                ],
              ),
            ),
            Positioned(
                left: -24,
                bottom: 0,
                top: 0,
                child: Hero(
                  tag: 'favs${item.key}',
                  child: CachedNetworkImage(
                    imageUrl: item.image,
                    fit: BoxFit.fitWidth,
                    width: 84,
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
