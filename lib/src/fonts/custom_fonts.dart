import 'package:flutter/material.dart';

class CustomFonts{
   static const heading = TextStyle(
      fontSize: 25,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w700,
      letterSpacing: -0.15,
      color: Colors.black);
  
   static const signinGoogle = TextStyle(
      fontSize: 10,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: Colors.white);
  
  static const signinFacebook = TextStyle(
      fontSize: 10,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: Colors.black);
  
  static const orSigninWith = TextStyle(
      fontSize: 10.5,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.14,
      color: Color.fromRGBO(162, 166, 187, 1));
  
  static const emailPass = TextStyle(
      fontSize: 12,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      color: Colors.black);
  
  static const textFieldText = TextStyle(
      fontSize: 11,
      height: 1.5,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: Colors.black);

  static const rememberMe = TextStyle(
      fontSize: 11,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: Color.fromRGBO(162, 166, 187, 1));

  static const forgotPassword = TextStyle(
      fontSize: 11,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: Color.fromRGBO(79, 90, 191, 1));

  static const newUser = TextStyle(
      fontSize: 12,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: Colors.black);

  static const createAccount = TextStyle(
      fontSize: 12,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: Color.fromRGBO(79, 90, 191, 1));

////////////////////////////////////////
///
///         Contant Us    ////////////////////

static const contactText = TextStyle(
      fontSize: 14,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.14,
      color: Color.fromRGBO(162, 166, 187, 1));

static const mailId = TextStyle(
      decoration: TextDecoration.underline,
      fontSize: 15,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w700,
      letterSpacing: -0.09,
      color: Color.fromRGBO(79, 90, 191, 1));

static const contactSubHeading = TextStyle(
      fontSize: 20,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w700,
      letterSpacing: -0.15,
      color: Colors.black);

static medium(double size,Color color){
  return TextStyle(
      fontSize: size,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.15,
      color: color);
}

static large(double size,Color color){
  return TextStyle(
      fontSize: size,
      fontFamily: 'Chivo',
      fontWeight: FontWeight.w700,
      letterSpacing: -0.15,
      color: color);
}
}