import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tulpen/controllers/auth_controller.dart';
import 'package:tulpen/controllers/menus_controller.dart';
import 'package:tulpen/controllers/navigation_controller.dart';
import 'package:tulpen/statics/router.dart';
import 'package:tulpen/statics/strings.dart';
import 'package:tulpen/statics/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();
  //   if (host == '10.0.2.2:8080' || host == 'localhost:8080') {
//     print('RUNNING IN EMULATOR MODE');
// // Set the host as soon as possible.
//     FirebaseFirestore.instance.settings = Settings(host: host, sslEnabled: false, persistenceEnabled: false);
//     FirebaseFunctions.instance.useFunctionsEmulator(origin: 'http://localhost:5001');
//   }
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  Get.put<NavigationController>(NavigationController());
  Get.put<MenusController>(MenusController());

  runApp(GetMaterialApp(
    navigatorObservers: [
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
    ],
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.fade,
    theme: Themes.light,
    initialRoute: Strings.routeMain,
    routingCallback: Router.callback,
    getPages: Router.pages,
  ));
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}
