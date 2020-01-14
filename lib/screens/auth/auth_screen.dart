import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpay_driver/routes/application.dart';
import 'package:fpay_driver/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _email;
  String _password;
  static final _formKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("lib/images/driver_login.png"),
                ),
              ),
              Center(
                child: Container(
                    width: 320,
                    child: TextFormField(
                      obscureText: false,
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Your Licence ID",
                      ),
                      validator: (val) {
                        // if (val.isEmpty) {
                        //   return 'Licence Id cannot be empty';
                        // }
                        // else if(val.length != 8){
                        //   return "Invalid licence id";
                        // }
                        //add validation
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                    width: 320,
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      validator: (val) {
                        if (val.length == 0) {
                          return "Password cannot be empty";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "User Password",
                      ),
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 240,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _handleLogin(_email, _password, context);
                      }
                    },
                    textColor: Colors.white,
                    child: const Text('Login', style: TextStyle(fontSize: 20)),
                    color: Colors.green,
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 200,
                  child: RaisedButton(
                      onPressed: () {
                        Application.router.navigateTo(context, '/forget');
                      },
                      textColor: Colors.white,
                      child: const Text('Forget Password',
                          style: TextStyle(fontSize: 20)),
                      color: Colors.black)),
              Container(
                  width: 200,
                  child: RaisedButton(
                      onPressed: () {
                        Application.router.navigateTo(context, '/reg');
                      },
                      textColor: Colors.white,
                      child: const Text('Register',
                          style: TextStyle(fontSize: 20)),
                      color: Colors.black)),
              Expanded(child: Container())
            ],
          ),
        ));
  }

  Future _handleLogin(
      String email, String password, BuildContext context) async {
    final form = _formKey.currentState;
    await AuthService().login(email, password).then((res) async {
      if (res) {
        Application.router.navigateTo(context, '/home');
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Invalid credentials"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Okay"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    });
  }
}
