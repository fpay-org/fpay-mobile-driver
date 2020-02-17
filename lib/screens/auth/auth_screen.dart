import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpay_driver/routes/application.dart';
import 'package:fpay_driver/services/auth_service.dart';
import 'package:logger/logger.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _nid;
  String _password;

  bool _isLoading = false;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              height: 120,
              color: Color(0xff003b46),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(24.0, 70.0, 24.0, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [BoxShadow(blurRadius: 12.0)],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _nid = value;
                        });
                      },
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "National ID",
                        contentPadding: EdgeInsets.all(0),
                        fillColor: Color(0xffc4dfe6),
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xff66a5ad)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide:
                              BorderSide(color: Color(0xff07575b), width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1),
                        ),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'National ID cannot be empty';
                        } else if (val.length != 10) {
                          //TODO: Add new nid validation
                          return "Invalid National ID";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Password",
                        contentPadding: EdgeInsets.all(0),
                        fillColor: Color(0xffc4dfe6),
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xff66a5ad)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide:
                              BorderSide(color: Color(0xff07575b), width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1),
                        ),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Password cannot be empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Builder(
                      builder: (context) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _handleLogin(context);
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Color(0xff07575b),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: () {
                        // Application.router
                        //     .navigateTo(context, '/auth/register');
                        Navigator.pushNamed(context, '/auth/register');
                      },
                      child: Text('Register'),
                    ),
                    FlatButton(
                      onPressed: () {
                        // Application.router.navigateTo(context, '/auth/forget');
                        Navigator.pushNamed(context, '/auth/forget');
                      },
                      child: Text('Forgot Password'),
                    ),
                  ],
                ),
              ),
            ),
            (_isLoading)
                ? Container(
                    color: Color(0xdd003b46),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
  }

  void _handleLogin(BuildContext context) {
    setState(() {
      _isLoading = true;
    });
    AuthService().login(_nid, _password).then((_) {
      setState(() {
        _isLoading = false;
      });
      if (_)
        // Application.router.navigateTo(context, '/home', clearStack: true);
        Navigator.popAndPushNamed(context, '/home');
      else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Credentials"),
          backgroundColor: Colors.redAccent,
        ));
      }
    });
  }
}
