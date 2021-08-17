import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulpen/controllers/menus_controller.dart';
import 'package:tulpen/statics/colours.dart';

class CheckoutButton extends StatefulWidget {
  @override
  _CheckoutButtonState createState() => _CheckoutButtonState();

  const CheckoutButton({Key? key}) : super(key: key);
}

class _CheckoutButtonState extends State<CheckoutButton> {
  bool b0Pressed = false;
  bool leftPosition = false;

  static const buttonMargin = 48;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final int quantity = MenusController.to.keysInCart.length;
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 54,
              // width: 284,
              width: constraints.maxWidth,
            ),
            AnimatedPositioned(
              top: !b0Pressed ? 0 : 3,
              duration: const Duration(milliseconds: 50),
              child: AnimatedContainer(
                // margin: const EdgeInsets.symmetric(horizontal: 24),
                duration: const Duration(milliseconds: 50),
                // width: constraints.maxWidth - 24,
                width: (constraints.maxWidth - buttonMargin),
                height: 54 - 4,
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
                            BoxShadow(
                              color: Colors.grey.shade500,
                              blurRadius: 1.5,
                              offset: const Offset(0.5, 2),
                            ),
                            const BoxShadow(
                              color: Colours.redError,
                              blurRadius: 0,
                              offset: Offset(0.5, 1.0),
                            ),
                          ]
                        : const []),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(26)),
                    splashColor: Colors.white70,
                    highlightColor: Colors.deepOrange.withOpacity(1),
                    onTapDown: (details) {
                      leftPosition = details.localPosition.dx / (constraints.maxWidth - buttonMargin) < 0.5;
                      //print('${details.localPosition.dx / (constraints.maxWidth - buttonMargin)} $leftPosition');
                      setState(() {
                        b0Pressed = true;
                      });
                    },
                    onTapCancel: () {
                      release(instant: true, quantity: quantity);
                    },
                    onTap: () {
                      release(quantity: quantity);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const SizedBox(
                          width: double.maxFinite,
                          height: double.maxFinite,
                        ),
                        Text('Checkout $quantity Items',
                            maxLines: 1, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white))
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

/*SizedBox(
                  height: 28,
                  child: Center(
                    child:),
                  ),
                )*/
  void release({instant = false, required quantity}) {
    if (!b0Pressed) return;
    if (instant) {
      setState(() {
        b0Pressed = false;
      });
    } else {
      Future.delayed(const Duration(milliseconds: 150)).whenComplete(() => setState(() {
            b0Pressed = false;
            CoolAlert.show(
                context: context,
                title: '$quantity Meals Checked out',
                type: CoolAlertType.success,
                text: 'Package will be delivered in 30mins',
                onConfirmBtnTap: () {
                  MenusController.to.clearItems();
                  Get.back();
                });

            if (quantity == 0 || !leftPosition) {
              // MenusController.to.addToCart(cartKey);
              // quantity++;
              // Get.find<MainPageController>().shoppingListCount.value++;
              // Get.find<MainPageController>().likeButtonKey.currentState.onTap();
            } else {
              // MenusController.to.removeFromCart(cartKey);
              // quantity--;
              // Get.find<MainPageController>().shoppingListCount.value--;
            }
          }));
    }
  }
}
