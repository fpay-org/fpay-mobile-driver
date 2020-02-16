import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:fpay_driver/screens/auth/auth_screen.dart';
import 'package:fpay_driver/screens/auth/register_screen.dart';
import 'package:fpay_driver/screens/auth/forget_screen.dart';
import 'package:fpay_driver/screens/home/home_refactor.dart';
import 'package:fpay_driver/screens/splash/splash_screen.dart';

var splashHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashScreen();
});

var authHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AuthScreen();
});

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});

var registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegistrationScreen();
});

var forgetHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ForgetScreen();
});

var profileHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  //return MyProfile();
});

var settingsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  //return Settings();
});
