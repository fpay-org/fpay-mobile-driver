
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpay_driver/screens/auth/auth_screen.dart';
import 'package:fpay_driver/screens/forget/forget_screen.dart';
import 'package:fpay_driver/screens/home/home_screen.dart';
import 'package:fpay_driver/screens/reg/register_screen.dart';
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

var regHandler = Handler(
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


