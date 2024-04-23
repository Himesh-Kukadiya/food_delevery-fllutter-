import 'package:flutter/material.dart';

class FoodCategory {
  static Material Menu(String imageUrl, bool colorSpecify) {
    return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: colorSpecify ? Colors.black54 : Colors.white,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            imageUrl,
            height: 35,
            width: 35,
            fit: BoxFit.cover,
            color: colorSpecify ? Colors.white : Colors.black,
          ),
        )
      )
    );
  }
}
