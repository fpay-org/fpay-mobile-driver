import 'package:flutter/material.dart';
import 'package:fpay_driver/routes/application.dart';
import 'package:fpay_driver/screens/profile/addcard_screen.dart';
import 'package:fpay_driver/services/auth_service.dart';
import 'package:fpay_driver/services/payment_service.dart';
import 'package:fpay_driver/services/profile_service.dart';
import 'package:logger/logger.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(12.0, 100.0, 12.0, 76.0),
        child: FutureBuilder(
          future: ProfileService().fetchDriver(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 36.0,
                      child: Text(snapshot.data.fName[0]),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('${snapshot.data.fName} ${snapshot.data.lName}'),
                    SizedBox(
                      height: 20.0,
                    ),
                    FutureBuilder(
                      future: PaymentService().fetchCard(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            child: Column(
                              children: <Widget>[
                                Text(snapshot.data.cardNumber),
                                Text(snapshot.data.csv),
                                Text(snapshot.data.expire),
                                FlatButton(
                                  child: Text("Remove card"),
                                  onPressed: _removeCard,
                                )
                              ],
                            ),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          return FlatButton(
                            child: Text("Add Card"),
                            onPressed: () {
                              _handleAddCard(context);
                            },
                          );
                        }

                        return Container(
                          child: Text("Loading"),
                        );
                      },
                    ),
                    //TODO: Fill others
                    Expanded(
                      child: Container(),
                    ),
                    FlatButton(
                      child: Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.redAccent,
                      onPressed: () {
                        _handleLogout(context);
                      },
                    )
                  ],
                ),
              );
            }

            return Container(
              child: Text("loading"),
            );
          },
        ));
  }

  void _handleLogout(BuildContext context) {
    AuthService().logout().then((res) {
      Application.router.navigateTo(context, '/auth', clearStack: true);
    });
  }

  void _handleAddCard(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddCardScreen();
        });
  }

  void _removeCard() {
    setState(() {
      PaymentService().removeCard();
    });
  }
}
