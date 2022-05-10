import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar errorCard(String error) {
  return GetSnackBar(
    backgroundColor: Colors.red[400]!,
    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 20,
    messageText: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          error,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: "Baloo",
            color: Colors.white,
          ),
        ),
      ],
    ),
    titleText: const Text(
      "Error",
      style: TextStyle(
        fontSize: 18,
        fontFamily: "Baloo",
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
