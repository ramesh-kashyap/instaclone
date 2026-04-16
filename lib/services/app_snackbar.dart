import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppSnack {
  static void success(String message) {
    _show(message, Colors.green);
  }

  static void error(String message) {
    _show(message, Colors.red);
  }

  static void warning(String message) {
    _show(message, Colors.orange);
  }

  static void info(String message) {
    _show(message, Colors.blue);
  }

  static void _show(String message, Color color) {
    if (Get.overlayContext == null) return;

    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: color,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
