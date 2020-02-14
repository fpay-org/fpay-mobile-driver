import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fpay_driver/routes/application.dart';
import 'package:fpay_driver/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      AuthService().isLoggedIn().then((_) {
        if (_)
          Application.router.navigateTo(context, '/home', clearStack: true);
        else
          Application.router.navigateTo(context, '/auth', clearStack: true);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          height: 100,
          width: 100,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
