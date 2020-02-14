import 'package:fluro/fluro.dart';
import 'package:fpay_driver/routes/routes_handler.dart';

class Routes {
  static const splash = '/';
  static const auth = '/auth';
  static const register = '/auth/register';
  static const forget = '/auth/forget';

  static const home = '/home';
  static const profile = '/profile';

  static void configureRouter(Router router) {
    router.define(splash,
        handler: splashHandler, transitionType: TransitionType.native);

    router.define(auth,
        handler: authHandler, transitionType: TransitionType.native);

    router.define(home,
        handler: homeHandler, transitionType: TransitionType.native);

    router.define(register,
        handler: registerHandler, transitionType: TransitionType.native);

    router.define(profile,
        handler: profileHandler, transitionType: TransitionType.native);

    router.define(forget,
        handler: forgetHandler, transitionType: TransitionType.native);
  }
}
