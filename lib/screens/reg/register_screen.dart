import 'package:flutter/material.dart';
import 'package:fpay_driver/routes/application.dart';
import 'package:fpay_driver/services/reg_service.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static final _regFormKey = new GlobalKey<FormState>();
  String _fName, _lName, _licenceId, _uNeme, _pass, _licence_id;
  int _mobile_no;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Welcome to FPay",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Form(
                key: _regFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: Container(
                            width: 320,
                            child: TextFormField(
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  _fName = value;
                                });
                              },
                              validator: (val) {
                                if (val.length == 0) {
                                  return "First name cannot be empty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "First Name",
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ))),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: Container(
                            width: 320,
                            child: TextFormField(
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  _lName = value;
                                });
                              },
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Last name cannot be empty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Last Name",
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ))),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: Container(
                            width: 320,
                            child: TextFormField(
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  _lName = value;
                                });
                              },
                              validator: (val) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val);
                                if (val.length == 0) {
                                  return "Email cannot be empty";
                                }
                                if (!emailValid) {
                                  return "Not a valid email";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Email",
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ))),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: Container(
                            width: 320,
                            child: TextFormField(
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  _mobile_no = value as int;
                                });
                              },
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Mobile number cannot be empty";
                                } else if (val.length != 10 || !(val is int)) {
                                  return "Invalid mobile number";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Mobile Number",
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ))),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: Container(
                            width: 320,
                            child: TextFormField(
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  _licenceId = value;
                                });
                              },
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Licence number cannot be empty";
                                } else if (val.length != 8) {
                                  return "Invalid licence number";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Licence ID",
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ))),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: Container(
                            width: 320,
                            child: TextFormField(
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  _uNeme = value;
                                });
                              },
                              validator: (val) {
                                if (val.length == 0) {
                                  return "User name cannot be empty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "User Name",
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ))),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: Container(
                            width: 320,
                            child: TextFormField(
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  _pass = value;
                                });
                              },
                              validator: (val) {
                                String pattern =
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                RegExp regExp = new RegExp(pattern);
                                bool validateStructure = regExp.hasMatch(val);
                                if (val.length == 0) {
                                  return "Password cannot be empty";
                                } else if (val.length < 8) {
                                  return "Password too short";
                                } else if (!validateStructure) {
                                  return "please follow the constraints";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Password (min 8 characters)",
                                hintText:
                                    "one uppercase/lowercase/special character/number",
                                hintStyle: TextStyle(fontSize: 13),
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green)),
                      onPressed: () {
                        if (_regFormKey.currentState.validate()) {
                          _handleRegistration(_fName, _lName, _licenceId,
                              _uNeme, _pass, _licenceId, _mobile_no);
                        }
                      },
                      textColor: Colors.white,
                      child: const Text('Register',
                          style: TextStyle(fontSize: 20)),
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  Future _handleRegistration(String _fName, String _lName, String _email,
      String _uName, String _pass, String _licence_id, int _mobile_no) async {
    final form = _regFormKey.currentState;
    RegService()
        .register(
            _fName, _lName, _email, _mobile_no, _licence_id, _uName, _pass)
        .then((res) {
      if (res) {
        Application.router.navigateTo(context, '/home');
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Registration failed"),
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
    //await AuthService().login(email, password).then((res) async {
    //   if (res) {
    //     Application.router.navigateTo(context, '/home');
    //   } else if (res == null) {
    //     showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             title: Text("Invalid credentials"),
    //             actions: <Widget>[
    //               FlatButton(
    //                 child: Text("Okay"),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //               )
    //             ],
    //           );
    //         });
    //   }
    //});
  }
}
