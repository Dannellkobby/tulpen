import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

void toastError({@required title, message, SnackPosition position = SnackPosition.BOTTOM, duration}) {
  Get.snackbar(title, message ?? '',
      colorText: Colors.white,
      backgroundColor: Colors.red,
      snackPosition: position,
      duration: duration ?? const Duration(milliseconds: 4000));
}

void toastSuccess({@required title, message, SnackPosition position = SnackPosition.BOTTOM, duration}) {
  Get.snackbar(title, message ?? '',
      colorText: Colors.white,
      backgroundColor: Colors.lightGreen,
      snackPosition: position,
      duration: duration ?? const Duration(milliseconds: 4000));
}

void toast({@required title, message, SnackPosition position = SnackPosition.BOTTOM, duration, textColor, backgroundColor}) {
  Get.snackbar(title, message ?? '',
      colorText: textColor ?? Colors.white,
      backgroundColor: backgroundColor ?? Colors.grey.shade400,
      snackPosition: position,
      duration: duration ?? const Duration(milliseconds: 4000));
}
