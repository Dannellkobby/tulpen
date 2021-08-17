import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tulpen/controllers/menus_controller.dart';
import 'package:tulpen/models/reservation.dart';
import 'package:tulpen/statics/colours.dart';
import 'package:tulpen/statics/utils.dart';

class ListReservations extends StatefulWidget {
  const ListReservations({Key? key}) : super(key: key);

  @override
  State<ListReservations> createState() => _ListReservationsState();
}

class _ListReservationsState extends State<ListReservations> {
  final PanelController _pc = PanelController();
  final SlidableController slidableController = SlidableController();
  final MenusController _reservationsController = Get.find<MenusController>();

  int reservationCount = -1;
  DateTime reservationDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  TimeOfDay reservationTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          if (_pc.isPanelOpen) {
            _pc.close();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: SlidingUpPanel(
          controller: _pc,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          minHeight: 84,
          backdropEnabled: true,
          parallaxEnabled: true,
          boxShadow: const [BoxShadow(color: Colours.red, offset: Offset(0, 0), blurRadius: 1)],
          body: Obx(
            () => _reservationsController.reservations.isEmpty
                ? Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: Get.height / 5,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 48.0),
                          child: Text(
                            '${_reservationsController.reservations.length} Reservations',
                            style: Get.textTheme.bodyText2
                                ?.copyWith(color: Colors.blueGrey.shade900, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final Reservation item = _reservationsController.reservations[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                                child: Slidable(
                                  key: Key(item.key),
                                  controller: slidableController,
                                  direction: Axis.horizontal,
                                  //   dismissal: SlidableDismissal(
                                  //     child: const SlidableDrawerDismissal(),
                                  //     onDismissed: (actionType) {
                                  //       _showSnackBar(context, actionType == SlideActionType.primary ? 'Dismiss Archive' : 'Dimiss Delete');
                                  //       /*      setState(() {
                                  //   items.removeAt(index);
                                  // });*/
                                  //     },
                                  //   ),
                                  actionPane: const SlidableStrechActionPane(),
                                  actionExtentRatio: 0.25,
                                  child: ListItem(item),
                                  actions: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 36, right: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: IconSlideAction(
                                          color: Colors.blue,
                                          icon: Icons.archive,
                                          onTap: () => _showSnackBar(context, 'Archive'),
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
                                          onTap: () => _reservationsController.deleteReservation(item.key).catchError((err) {
                                            toastError(title: 'Delete Reservation failed');
                                            print('deleteReservation caught error $err');
                                          }).then((value) => toastSuccess(title: 'Reservation deleted')),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: _reservationsController.reservations.length,
                          ),
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                      ],
                    ),
                  ),
          ),
          header: SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: () {
                  if (_pc.isPanelOpen) {
                    _pc.close();
                    Future.delayed(const Duration(milliseconds: 300), () {
                      setState(() {});
                    });
                  } else {
                    _pc.open();
                    Future.delayed(const Duration(milliseconds: 300), () {
                      setState(() {});
                    });
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                  overlayColor: MaterialStateProperty.all(Colours.orange.withOpacity(0.25)),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reservation',
                      style: Get.textTheme.subtitle1!.copyWith(color: Colours.black, letterSpacing: 1),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Icon(
                          Icons.keyboard_arrow_up_sharp,
                          color: Colours.black,
                          size: 16,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colours.black,
                          size: 16,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          panel: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 84),
                Text(
                  'People\n',
                  style: Get.textTheme.subtitle1!.copyWith(color: Colours.red, letterSpacing: 1),
                ),
                SizedBox(
                  height: 72,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [1, 2, 3, 4, 5, 6, 7, 8].map((i) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            reservationCount = i;
                          });
                        },
                        highlightColor: Colours.light,
                        borderRadius: BorderRadius.circular(22),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 64,
                              width: 64,
                              margin: const EdgeInsets.only(right: 12),
                              alignment: Alignment.center,
                              child: Text(
                                '$i',
                                style: Get.textTheme.subtitle1!.copyWith(
                                    color: reservationCount == i ? Colors.black : Colours.darkGrey,
                                    fontSize: reservationCount == i ? 18 : null),
                              ),
                              decoration: BoxDecoration(
                                  color: Colours.white,
                                  border: Border.all(color: reservationCount == i ? Colours.red : Colors.grey.shade300),
                                  boxShadow: reservationCount == i
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
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.maxFinite,
                  child: TextButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: reservationDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 180)),
                        ).then((value) {
                          setState(() {
                            reservationDate = value ?? reservationDate;
                          });
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                        overlayColor: MaterialStateProperty.all(Colours.orange.withOpacity(0.25)),
                        backgroundColor: MaterialStateProperty.all(Colours.white),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(18),
                        ),
                        side: MaterialStateProperty.all(BorderSide(color: Colors.grey.shade300, width: 1.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Date',
                              style: Get.textTheme.bodyText2!.copyWith(color: Colours.red, letterSpacing: 1),
                            ),
                          ),
                          Text(
                            DateFormat.yMMMEd().format(reservationDate),
                            style: Get.textTheme.subtitle1!.copyWith(color: Colours.dark, letterSpacing: 1),
                          ),
                          Expanded(
                            child: Text(
                              '',
                              style: Get.textTheme.subtitle1!.copyWith(color: Colours.dark, letterSpacing: 1),
                            ),
                          ),
                        ],
                      )),
                ),
                const Spacer(),
                SizedBox(
                  width: double.maxFinite,
                  child: TextButton(
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: reservationTime,
                        ).then((value) {
                          setState(() {
                            reservationTime = value ?? reservationTime;
                            // print('showTimePicker $reservationTime');
                          });
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                        overlayColor: MaterialStateProperty.all(Colours.orange.withOpacity(0.25)),
                        backgroundColor: MaterialStateProperty.all(Colours.white),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(18),
                        ),
                        side: MaterialStateProperty.all(BorderSide(color: Colors.grey.shade300, width: 1.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Time',
                              style: Get.textTheme.bodyText2!.copyWith(color: Colours.red, letterSpacing: 1),
                            ),
                          ),
                          Text(
                            reservationTime.format(context),
                            style: Get.textTheme.subtitle1!.copyWith(color: Colours.dark, letterSpacing: 1),
                          ),
                          Expanded(
                            child: Text(
                              '',
                              style: Get.textTheme.subtitle1!.copyWith(color: Colours.dark, letterSpacing: 1),
                            ),
                          ),
                        ],
                      )),
                ),
                const Spacer(),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        if (reservationCount < 1) {
                          toastError(title: 'Invalid People count', message: 'Please choose number of people for the table');
                          print('Invalid People count');
                          return;
                        }
                        final dateTime = reservationDate.add(Duration(hours: reservationTime.hour, minutes: reservationTime.minute));
                        if (dateTime.isBefore(DateTime.now().add(const Duration(hours: 2)))) {
                          toastError(title: 'Incorrect Time', message: 'Reservations need to be at least 2hrs from now');
                          print('Incorrect Time');
                        } else {
                          _reservationsController.createReservation(dateTime.millisecondsSinceEpoch, reservationCount).then((value) {
                            toastSuccess(title: 'Reservation sent', message: 'De Tulpen will notify you once confirmed');
                            _pc.close();
                            print('Reservation sent');
                          }).catchError((err) {
                            print('createReservation err: $err');
                            toastError(title: 'Error', message: '$err');
                          });
                        }
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                          // overlayColor: MaterialStateProperty.all(Colours.orange.withOpacity(0.5)),
                          backgroundColor: MaterialStateProperty.all(Colours.orange),
                          padding: MaterialStateProperty.all(const EdgeInsets.all(18))
                          // side: MaterialStateProperty.all(const BorderSide(color: Colours.red, width: 1.2)),
                          ),
                      child: Text(
                        'Reserve table',
                        style: Get.textTheme.subtitle1!.copyWith(color: Colours.white, letterSpacing: 1),
                      )),
                ),
                const SizedBox(height: 18)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}

class ListItem extends StatelessWidget {
  const ListItem(this.item, {Key? key}) : super(key: key);
  final Reservation item;

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
              padding: const EdgeInsets.only(right: 18, bottom: 18),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(color: Colours.light, borderRadius: BorderRadius.circular(22)),
              height: 128,
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(item.dateCreated)),
                      style: Get.textTheme.bodyText2?.copyWith(color: Colors.blueGrey.shade800, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Icon(
                          Icons.radio_button_checked_rounded,
                          color: item.confirmed ? Colors.cyan : Colors.red,
                          size: 14,
                        ),
                        Text(
                          ' Confirmed',
                          style: Get.textTheme.subtitle2?.copyWith(color: item.confirmed ? Colors.blueGrey : Colors.red, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 14,
              bottom: 0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${item.people}',
                    style: Get.textTheme.headline1?.copyWith(color: Colors.orange.shade800, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Image.asset(
                    'assets/images/table.png',
                    width: 96,
                    // fit: BoxFit.scaleDown,
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
