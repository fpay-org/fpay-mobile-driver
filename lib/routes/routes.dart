// import 'package:fluro/fluro.dart';
// import 'package:fpay_driver/routes/routes_handler.dart';

import 'package:flutter/material.dart';
import 'package:fpay_driver/screens/auth/auth_screen.dart';
import 'package:fpay_driver/screens/auth/forget_screen.dart';
import 'package:fpay_driver/screens/auth/register_screen.dart';
import 'package:fpay_driver/screens/home/home_refactor.dart';
import 'package:fpay_driver/screens/profile/profile_screen.dart';
import 'package:fpay_driver/screens/splash/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const auth = '/auth';
  static const register = '/auth/register';
  static const forget = '/auth/forget';

  static const home = '/home';
  static const profile = '/profile';

  // static void configureRouter(Router router) {
  //   router.define(splash,
  //       handler: splashHandler, transitionType: TransitionType.native);

  //   router.define(auth,
  //       handler: authHandler, transitionType: TransitionType.native);

  //   router.define(home,
  //       handler: homeHandler, transitionType: TransitionType.native);

  //   router.define(register,
  //       handler: registerHandler, transitionType: TransitionType.native);

  //   router.define(profile,
  //       handler: profileHandler, transitionType: TransitionType.native);

  //   router.define(forget,
  //       handler: forgetHandler, transitionType: TransitionType.native);
  // }

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) => SplashScreen(),
    auth: (context) => AuthScreen(),
    register: (context) => RegistrationScreen(),
    forget: (context) => ForgetScreen(),
    home: (context) => HomeScreen(),
    profile: (context) => ProfileScreen(),
  };
}
