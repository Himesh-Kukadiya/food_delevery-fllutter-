import 'package:flutter/material.dart';

class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent({required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(image: 'images/screen1.png', title: "Select from Out Best Menu", description: "Pick your food from our menu more than 35 times", ),
  UnboardingContent(image: 'images/screen2.png', title: "Easy and online payment", description: "You can pay cash on delivery and Car paument is avaialble", ),
  UnboardingContent(image: 'images/screen3.png', title: "Quick Delevery at you Doorstes", description: "Delivery your food at your Doorstes", ),
];

