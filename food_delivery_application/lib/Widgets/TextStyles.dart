// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class TextStyles {

  static TextStyle BoldTextFeildStyle(bool textColorModeBlack) {
    return TextStyle(
      color: textColorModeBlack ? Colors.black : Colors.white, 
      fontSize: 20.0, 
      fontWeight: FontWeight.bold, 
      fontFamily: 'Poppins'
    );
  }

  static TextStyle HeaderTextFeildStyle(bool textColorModeBlack) {
    return TextStyle(
      color: textColorModeBlack ? Colors.black : Colors.white, 
      fontSize: 24.0, 
      fontWeight: FontWeight.bold, 
      fontFamily: 'Poppins'
    );
  }

  static TextStyle LightTextFeildStyle(bool textColorModeBlack) {
    return TextStyle(
      color: textColorModeBlack ? Colors.black : Colors.white70, 
      fontSize: 13.0, 
      fontWeight: FontWeight.w500, 
      fontFamily: 'Poppins'
    );
  }

  static TextStyle SamiBoldTextFeildStyle(bool textColorModeBlack) {
    return TextStyle(
      color: textColorModeBlack ? Colors.black : Colors.white, 
      fontSize: 18.0, 
      fontWeight: FontWeight.w500, 
      fontFamily: 'Poppins'
    );
  }  

  static TextStyle ButtonTextFeildStyle(bool textColorModeBlack) {
    return TextStyle(
      color: textColorModeBlack ? Colors.black : Colors.white, 
      fontSize: 18.0,
      fontFamily: 'Poppins'
    );
  }  
}

class Texts {
  static String rupeeText() {
    return "₹ ";
  }
  
  static Text LogoText() {
    return const Text( 
      "𝓖𝓻𝓮𝓪𝓽 𝓕𝓸𝓸𝓭𝓼",
      style: TextStyle(color: Colors.white, fontSize: 60),
    );
  }
}