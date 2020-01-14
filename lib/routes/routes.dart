
import 'package:fluro/fluro.dart';
import 'package:fpay_driver/routes/routes_handler.dart';

class Routes {
  static const splash = '/';
  static const auth = '/auth';
  static const home = '/home';
  static const reg = '/reg';
  static const profile = '/profile';
  static const forget = '/forget';
  

  static void configureRouter(Router router) {
    router.define(splash,
        handler: splashHandler, transitionType: TransitionType.native);

    router.define(auth,
        handler: authHandler, transitionType: TransitionType.native);

    router.define(home,
        handler: homeHandler, transitionType: TransitionType.native);

    router.define(reg,
        handler: regHandler, transitionType: TransitionType.native);

    router.define(profile,
        handler: profileHandler, transitionType: TransitionType.native);

    router.define(forget,
        handler: forgetHandler, transitionType: TransitionType.native);
  }
}
