import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulpen/controllers/menus_controller.dart';
import 'package:tulpen/statics/colours.dart';

class AddToListButtonVertical extends StatefulWidget {
  @override
  _AddToListButtonVerticalState createState() => _AddToListButtonVerticalState();
  // final double width;
  // final double height;
  // final double minWidth;
  final String cartKey;

  const AddToListButtonVertical({Key? key, required this.cartKey}) : super(key: key);
}

class _AddToListButtonVerticalState extends State<AddToListButtonVertical> {
  bool b0Pressed = false;
  bool leftPosition = false;

  static const buttonMargin = 2;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final int quantity = MenusController.to.keysInCart.where((m) => m == widget.cartKey).length;
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 28,
              // width: 284,
              height: constraints.maxHeight,
            ),
            AnimatedPositioned(
              top: !b0Pressed ? 0 : 3,
              duration: const Duration(milliseconds: 50),
              child: AnimatedContainer(
                // margin: const EdgeInsets.symmetric(horizontal: 24),
                duration: const Duration(milliseconds: 50),
                // width: constraints.maxWidth - 24,
                height: (constraints.maxHeight - buttonMargin),
                width: 28 - 4,
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(26)),
                    gradient: LinearGradient(
                      begin: const Alignment(0, -5.5),
                      end: Alignment.bottomLeft,
                      colors: quantity == 0
                          ? [
                              Colours.red,
                              Colours.red,
                              // Colours.orange,
                            ]
                          : [
                              Colours.red,
                              Colours.red,
                              Colours.orange,
                            ],
                    ),
                    boxShadow: !b0Pressed
                        ? [
                            /*
                            BoxShadow(
                              color: Colors.grey.shade500,
                              blurRadius: 1.5,
                              offset: const Offset(0.5, 2),
                            ),
                            const BoxShadow(
                              color: Colours.redError,
                              blurRadius: 0,
                              offset: Offset(0.1, 0.3),
                            ),
                      */
                          ]
                        : const []),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(26)),
                    splashColor: Colors.white70,
                    highlightColor: Colors.deepOrange.withOpacity(1),
                    onTapDown: (details) {
                      leftPosition = !(details.localPosition.dy / (constraints.maxHeight - buttonMargin) < 0.5);
                      //print('${details.localPosition.dx / (constraints.maxWidth - buttonMargin)} $leftPosition');
                      setState(() {
                        b0Pressed = true;
                      });
                    },
                    onTapCancel: () {
                      release(instant: true, quantity: quantity, cartKey: widget.cartKey);
                    },
                    onTap: () {
                      release(quantity: quantity, cartKey: widget.cartKey);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const SizedBox(
                          width: double.maxFinite,
                          height: double.maxFinite,
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            const Text('+', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(fontSize: 14, height: 1, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                            const Text('-', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                            const SizedBox(height: 8)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  void release({instant = false, required quantity, required cartKey}) {
    if (!b0Pressed) return;
    if (instant) {
      setState(() {
        b0Pressed = false;
      });
    } else {
      Future.delayed(const Duration(milliseconds: 150)).whenComplete(() => setState(() {
            b0Pressed = false;
            if (quantity == 0 || !leftPosition) {
              MenusController.to.addToCart(cartKey);
              // quantity++;
              // Get.find<MainPageController>().shoppingListCount.value++;
              // Get.find<MainPageController>().likeButtonKey.currentState.onTap();
            } else {
              MenusController.to.removeFromCart(cartKey);
              // quantity--;
              // Get.find<MainPageController>().shoppingListCount.value--;
            }
          }));
    }
  }
}
