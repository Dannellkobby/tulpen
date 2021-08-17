import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tulpen/controllers/auth_controller.dart';
import 'package:tulpen/models/menu_item.dart';
import 'package:tulpen/models/reservation.dart';
import 'package:tulpen/statics/strings.dart';

class MenusController extends GetxController {
  static MenusController to = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<MenuItem> itemsAppetizers = RxList<MenuItem>([]);
  RxList<MenuItem> itemsMain = RxList<MenuItem>([]);
  RxList<MenuItem> itemsDesserts = RxList<MenuItem>([]);
  RxList<MenuItem> itemsSalads = RxList<MenuItem>([]);
  RxList<MenuItem> itemsWines = RxList<MenuItem>([]);
  RxList<MenuItem> favourites = RxList<MenuItem>([]);
  RxMap<String, int> cartKeyValues = RxMap({});
  RxList<MenuItem> itemsInCart = RxList<MenuItem>([]);
  RxList<dynamic> keysInCart = RxList<dynamic>([]);
  RxList<Reservation> reservations = RxList<Reservation>([]);

  handleUserChanged(User? user) {
    if (user == null) {
      favourites.clear();
      reservations.clear();
      cartKeyValues.clear();
    } else {
      cartKeyValues.bindStream(_firestore.doc('${Strings.colCarts}/${user.uid}').snapshots().map((snap) {
        final Map<String, int> mappable = {};
        keysInCart.assignAll(snap.get('items') as List<dynamic>);
        for (var key in keysInCart) {
          mappable.putIfAbsent(key, () => keysInCart.where((e) => e == key).length);
        }
        return mappable;
      }));

      favourites.bindStream(_firestore
          .collection('${Strings.colUsers}/${user.uid}/${Strings.colFavourites}')
          .orderBy('date', descending: true)
          .snapshots()
          .map((snaps) => snaps.docs.map((snap) => MenuItem.fromJson(snap.data())).toList()));

      reservations.bindStream(_firestore
          .collection('${Strings.colUsers}/${user.uid}/${Strings.colReservations}')
          .orderBy(Strings.dateCreated, descending: true)
          .snapshots()
          .map((snaps) => snaps.docs.map((snap) => Reservation.fromJson(snap.data())).toList()));
    }
  }

  onCartKeysChanged(cartKeys) async {
    var param = (cartKeys as Map<String, int>).keys;
    var items = <MenuItem>[];
    // itemsInCart.clear();
    for (var e in param) {
      items.add(MenuItem.fromJson((await _firestore.doc('${Strings.colMenus}/$e').get()).data()!));
    }
    // items.sort()
    itemsInCart.assignAll(items);
  }

  clearItems() {
    itemsInCart.clear();
    cartKeyValues.clear();
    keysInCart.clear();
    return _firestore
        .doc('${Strings.colCarts}/${Get.find<AuthController>().firebaseUser.value?.uid}')
        .set({'items': keysInCart}, SetOptions(merge: true));
  }

  @override
  void onInit() {
    ever(cartKeyValues, (keys) => onCartKeysChanged(keys));
    ever(Get.find<AuthController>().firebaseUser, (User? user) => user != null ? handleUserChanged(user) : () {});

    itemsAppetizers.bindStream(_firestore
        .collection(Strings.colMenus)
        .where('group', isEqualTo: 'appetizers')
        .snapshots()
        .map((snaps) => snaps.docs.map((snap) => MenuItem.fromJson(snap.data())).toList()));
    itemsMain.bindStream(_firestore
        .collection(Strings.colMenus)
        .where('group', isEqualTo: 'main')
        .snapshots()
        .map((snaps) => snaps.docs.map((snap) => MenuItem.fromJson(snap.data())).toList()));
    itemsDesserts.bindStream(_firestore
        .collection(Strings.colMenus)
        .where('group', isEqualTo: 'desserts')
        .snapshots()
        .map((snaps) => snaps.docs.map((snap) => MenuItem.fromJson(snap.data())).toList()));
    itemsSalads.bindStream(_firestore
        .collection(Strings.colMenus)
        .where('group', isEqualTo: 'salads')
        .snapshots()
        .map((snaps) => snaps.docs.map((snap) => MenuItem.fromJson(snap.data())).toList()));
    itemsWines.bindStream(_firestore
        .collection(Strings.colMenus)
        .where('group', isEqualTo: 'wines')
        .snapshots()
        .map((snaps) => snaps.docs.map((snap) => MenuItem.fromJson(snap.data())).toList()));
    super.onInit();
  }

  @override
  void onReady() {
    if (favourites.isEmpty || reservations.isEmpty || cartKeyValues.isEmpty) {
      //handleUserChanged(Get.find<AuthController>().firebaseUser.value);
    }
    super.onReady();
  }

  @override
  void onClose() {
    itemsAppetizers.close();
    itemsMain.close();
    itemsDesserts.close();
    itemsSalads.close();
    itemsWines.close();
    reservations.close();
    favourites.close();
    super.onClose();
  }

  Future toggleFavourite(MenuItem menuItem) async {
    if (favourites.any((e) => e.key == menuItem.key)) {
      //remove
      return _firestore
          .doc('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colFavourites}/${menuItem.key}')
          .delete();
    } else {
      return _firestore
          .doc('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colFavourites}/${menuItem.key}')
          .set(menuItem.toJson());
    }
  }

  Future addToCart(dynamic key) async {
    // print('addToCart ${Strings.colCarts}/${Get.find<AuthController>().firebaseUser.value?.uid} '
    //     ': ${{
    //   'items': [cartKeys, key]
    // }}');
    return _firestore.doc('${Strings.colCarts}/${Get.find<AuthController>().firebaseUser.value?.uid}').set({
      'items': [...keysInCart, key]
    }, SetOptions(merge: true));
  }

  Future removeFromCart(dynamic key) async {
    keysInCart.remove(key);
    return _firestore
        .doc('${Strings.colCarts}/${Get.find<AuthController>().firebaseUser.value?.uid}')
        .set({'items': keysInCart}, SetOptions(merge: true));
  }

  Future removeAllFromCart(dynamic key) async {
    keysInCart.removeWhere((k) {
      // print('removeWhere $k == $key');
      return k == key;
    });
    // print('removeWhere after $keysInCart');

    return _firestore
        .doc('${Strings.colCarts}/${Get.find<AuthController>().firebaseUser.value?.uid}')
        .set({'items': keysInCart}, SetOptions(merge: true));
  }

  Future createReservation(dateCreated, people) async {
    final key = _firestore
        .collection('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colReservations}')
        .doc()
        .id;

    return _firestore.doc('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colReservations}/$key').set({
      Strings.key: key,
      // Strings.dateTime: dateTime,
      Strings.people: people,
      Strings.confirmed: Random().nextBool(),
      Strings.dateCreated: dateCreated,
    });
  }

  Future<void> deleteReservation(key) async {
    return _firestore
        .doc('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colReservations}/$key')
        .delete();
  }
}
