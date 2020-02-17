import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fpay_driver/routes/application.dart';
import 'package:fpay_driver/routes/routes.dart';
import 'package:fpay_driver/screens/home/home_refactor.dart';

class FPayDriverApp extends StatelessWidget {
  // FPayDriverApp() {
  //   final router = Router();
  //   Routes.configureRouter(router);
  //   Application.router = router;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Officer App",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: Routes.routes,
    );
  }
}
