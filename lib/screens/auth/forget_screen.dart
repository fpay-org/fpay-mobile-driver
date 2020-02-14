import 'package:flutter/material.dart';
import 'package:fpay_driver/routes/application.dart';

class ForgetScreen extends StatefulWidget {
  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  static final _forgetformKey = new GlobalKey<FormState>();
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _forgetformKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text("Enter your email"),
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
                      labelText: "Your email",
                    ),
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
                    if (_forgetformKey.currentState.validate()) {}
                  },
                  textColor: Colors.white,
                  child: const Text('Change Password',
                      style: TextStyle(fontSize: 20)),
                  color: Colors.green,
                )),
          ],
        ),
      ),
    );
  }
}
