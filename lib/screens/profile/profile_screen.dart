import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpay_driver/screens/profile/addcard_screen.dart';
import 'package:fpay_driver/services/auth_service.dart';
import 'package:fpay_driver/services/payment_service.dart';
import 'package:fpay_driver/services/profile_service.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false, _isLoading = false;
  File _image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50),
          child: (_isEditing)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _revertOperations();
                          _isEditing = false;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: _onChangesSave,
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                    )
                  ],
                ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(12.0, 100.0, 12.0, 76.0),
          child: FutureBuilder(
            future: ProfileService().fetchDriver(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      (_image == null)
                          ? CircleAvatar(
                              radius: 52.0,
                              // TODO: Update to user avatar url
                              backgroundImage: (snapshot.data.avatarUrl != null)
                                  ? NetworkImage(snapshot.data.avatarUrl)
                                  : AssetImage("assets/driver_login.png"),
                            )
                          : CircleAvatar(
                              radius: 52.0,
                              backgroundImage: FileImage(_image),
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
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      InkWell(
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.redAccent,
                                        ),
                                        onTap: _removeCard,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${snapshot.data.cardNumber.toString().substring(0, 4)} ${snapshot.data.cardNumber.toString().substring(4, 8)} ${snapshot.data.cardNumber.toString().substring(8, 12)} ${snapshot.data.cardNumber.toString().substring(12, 16)}",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(snapshot.data.csv),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Valid Thru"),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(snapshot.data.expire),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                ],
                              ),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return FlatButton(
                              child: Text("Add Card"),
                              onPressed: () {
                                _handleAddCard(context);
                              },
                            );
                          }

                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
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
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            },
          ),
        ),
        (_isEditing)
            ? Container(
                margin: EdgeInsets.fromLTRB(12.0, 100.0, 12.0, 76.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color(0xaa000000),
                        radius: 52.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.file_upload,
                            color: Colors.white,
                          ),
                          onPressed: _handleImageSelect,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ))
            : Container(),
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
    );
  }

  void _handleLogout(BuildContext context) {
    AuthService().logout().then((res) {
      // Application.router.navigateTo(context, '/auth', clearStack: true);
      Navigator.popAndPushNamed(context, '/auth');
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

  void _handleImageSelect() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void _revertOperations() {
    _image = null;
  }

  void _onChangesSave() {
    if (_image == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please select an image firse"),
            );
          });
    } else {
      setState(() {
        _isLoading = true;
      });

      ProfileService().updateProfile(_image).then((_) {
        if (_) {
          setState(() {
            _isLoading = false;
            _revertOperations();
          });
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Invalid Credentials"),
            backgroundColor: Colors.redAccent,
          ));
        }
      });
    }
  }
}
