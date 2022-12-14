import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    _auth.signInAnonymously();
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  @override
  void onReady() async {
    // ever(firebaseUser, handleAuthChanged);
    firebaseUser.value = _auth.currentUser;
    super.onReady();
  }

  @override
  void onClose() {
    firebaseUser.close();
    super.onClose();
  }
}
