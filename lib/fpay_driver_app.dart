import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fpay_driver/routes/application.dart';
import 'package:fpay_driver/routes/routes.dart';

class FPayDriverApp extends StatelessWidget {
  FPayDriverApp() {
    final router = Router();
    Routes.configureRouter(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Officer App",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
    );
  }
}
