import 'package:flutter/material.dart';
import 'package:fpay_driver/model/driver.dart';
import 'package:fpay_driver/routes/application.dart';
import 'package:fpay_driver/services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _nid,
      _password,
      _passwordValidator,
      _fName,
      _lName,
      _licenceId,
      _email,
      _phoneNo;

  bool _isLoading = false, _initial = true, _isObscure = true;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            Container(
              height: 160,
              color: Color(0xff003b46),
              child: Center(
                  child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          // Application.router.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12.0, 130.0, 12.0, 12.0),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [BoxShadow(blurRadius: 12.0)]),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _nid = value;
                            });
                          },
                          enabled: _initial,
                          style: TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "National ID",
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Color(0xffc4dfe6),
                            filled: _initial,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(color: Color(0xff66a5ad)),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide:
                                    BorderSide(color: Color(0xff66a5ad))),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  color: Color(0xff07575b), width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide:
                                  BorderSide(color: Colors.redAccent, width: 1),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
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
                          obscureText: _isObscure,
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          enabled: _initial,
                          style: TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            suffixIcon: (_initial)
                                ? InkWell(
                                    child: Icon(
                                      (_isObscure)
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xff66a5ad),
                                    ),
                                    onTap: _changeVisibility,
                                  )
                                : null,
                            hintText: "Password",
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Color(0xffc4dfe6),
                            filled: _initial,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(color: Color(0xff66a5ad)),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide:
                                    BorderSide(color: Color(0xff66a5ad))),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  color: Color(0xff07575b), width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide:
                                  BorderSide(color: Colors.redAccent, width: 1),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
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
                        TextFormField(
                          obscureText: _isObscure,
                          onChanged: (value) {
                            setState(() {
                              _passwordValidator = value;
                            });
                          },
                          enabled: _initial,
                          style: TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            suffixIcon: (_initial)
                                ? InkWell(
                                    child: Icon(
                                      (_isObscure)
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xff66a5ad),
                                    ),
                                    onTap: _changeVisibility,
                                  )
                                : null,
                            hintText: "Confirm password",
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Color(0xffc4dfe6),
                            filled: _initial,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(color: Color(0xff66a5ad)),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide:
                                    BorderSide(color: Color(0xff66a5ad))),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  color: Color(0xff07575b), width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide:
                                  BorderSide(color: Colors.redAccent, width: 1),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide:
                                  BorderSide(color: Colors.redAccent, width: 1),
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty)
                              return "Password cannot be empty";
                            else if (val != _password)
                              return 'Passwords doesn\'t match';
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        (_initial)
                            ? FlatButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      _initial = false;
                                      _isObscure = true;
                                    });
                                  }
                                },
                                child: Text(
                                  'Continue',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Color(0xff07575b),
                              )
                            : Container(
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _fName = value;
                                        });
                                      },
                                      style: TextStyle(fontSize: 14.0),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "First Name",
                                        contentPadding: EdgeInsets.all(0),
                                        fillColor: Color(0xffc4dfe6),
                                        filled: true,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff66a5ad)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff07575b),
                                              width: 1.5),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'First name cannot be empty';
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _lName = value;
                                        });
                                      },
                                      style: TextStyle(fontSize: 14.0),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "Last Name",
                                        contentPadding: EdgeInsets.all(0),
                                        fillColor: Color(0xffc4dfe6),
                                        filled: true,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff66a5ad)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff07575b),
                                              width: 1.5),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'Last name cannot be empty';
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _licenceId = value;
                                        });
                                      },
                                      style: TextStyle(fontSize: 14.0),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "License ID",
                                        contentPadding: EdgeInsets.all(0),
                                        fillColor: Color(0xffc4dfe6),
                                        filled: true,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff66a5ad)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff07575b),
                                              width: 1.5),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'License number cannot be empty';
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _email = value;
                                        });
                                      },
                                      style: TextStyle(fontSize: 14.0),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        contentPadding: EdgeInsets.all(0),
                                        fillColor: Color(0xffc4dfe6),
                                        filled: true,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff66a5ad)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff07575b),
                                              width: 1.5),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'Email cannot be empty';
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _phoneNo = value;
                                        });
                                      },
                                      style: TextStyle(fontSize: 14.0),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "Contact Number",
                                        contentPadding: EdgeInsets.all(0),
                                        fillColor: Color(0xffc4dfe6),
                                        filled: true,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff66a5ad)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff07575b),
                                              width: 1.5),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'Contact number cannot be empty';
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Builder(
                                      builder: (context) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _handleRegistration(context);
                                              }
                                            },
                                            child: Text(
                                              'Register',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Color(0xff07575b),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
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

  void _handleRegistration(BuildContext context) {
    setState(() {
      _isLoading = true;
    });

    Driver user = new Driver(
        nid: _nid,
        password: _password,
        fName: _fName,
        lName: _lName,
        email: _email,
        licenseID: _licenceId,
        phoneNo: _phoneNo);

    AuthService().register(user).then((_) {
      setState(() {
        _isLoading = false;
      });
      if (_)
        // Application.router.navigateTo(context, '/home', clearStack: true);
        Navigator.popAndPushNamed(context, '/home');
      else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Registration Failed"),
          backgroundColor: Colors.redAccent,
        ));
      }
    });
  }

  void _changeVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }
}
