import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:north_star/Styles/Themes.dart';

void showSnack(String title, String message) {
  Get.snackbar(title, message,
      margin: const EdgeInsets.all(16),
      backgroundColor: Themes.mainThemeColor.shade900,
      colorText: Colors.white);
}
