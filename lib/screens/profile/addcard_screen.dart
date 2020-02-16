import 'package:flutter/material.dart';
import 'package:fpay_driver/model/card.dart';
import 'package:fpay_driver/services/payment_service.dart';
import 'package:logger/logger.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  String _number, _csv, _month, _year;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isComplete = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: (!_isLoading)
            ? Container(
                height: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _number = value;
                        });
                      },
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                      decoration: InputDecoration(
                        hintText: "Card Number",
                        contentPadding: EdgeInsets.all(0),
                        fillColor: Color(0xffc4dfe6),
                        filled: true,
                        border: InputBorder.none,
                        counterText: "",
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
                          return 'Card number cannot be empty';
                        } else if (val.length != 16) {
                          //TODO: Add new nid validation
                          return "Invalid Card number";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _csv = value;
                        });
                      },
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      decoration: InputDecoration(
                        hintText: "CSV",
                        contentPadding: EdgeInsets.all(0),
                        fillColor: Color(0xffc4dfe6),
                        filled: true,
                        border: InputBorder.none,
                        counterText: "",
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
                          return 'CSV cannot be empty';
                        } else if (val.length != 3) {
                          //TODO: Add new nid validation
                          return "Invalid CSV";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              "Expire Date",
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 60.0,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _month = value;
                              });
                            },
                            style: TextStyle(fontSize: 14.0),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            decoration: InputDecoration(
                              hintText: "MM",
                              contentPadding: EdgeInsets.all(0),
                              fillColor: Color(0xffc4dfe6),
                              filled: true,
                              border: InputBorder.none,
                              counterText: "",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide:
                                    BorderSide(color: Color(0xff66a5ad)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(
                                    color: Color(0xff07575b), width: 1.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 1),
                              ),
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Month cannot be empty';
                              } else if (val.length != 2) {
                                //TODO: Add new nid validation
                                return "Invalid month format";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          width: 60.0,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _year = value;
                              });
                            },
                            style: TextStyle(fontSize: 14.0),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            decoration: InputDecoration(
                              hintText: "YY",
                              contentPadding: EdgeInsets.all(0),
                              fillColor: Color(0xffc4dfe6),
                              filled: true,
                              border: InputBorder.none,
                              counterText: "",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide:
                                    BorderSide(color: Color(0xff66a5ad)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(
                                    color: Color(0xff07575b), width: 1.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 1),
                              ),
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Year cannot be empty';
                              } else if (val.length != 2) {
                                //TODO: Add new nid validation
                                return "Invalid year format";
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    FlatButton(
                      child: Text(
                        "Add Card",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xff07575b),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _addCard();
                        }
                      },
                    )
                  ],
                ),
              )
            : (!_isComplete)
                ? Container(
                    height: 250,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    height: 250,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.beenhere,
                            color: Color(0xff07575b),
                            size: 36.0,
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Text("Card details securely saved")
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  void _addCard() {
    setState(() {
      _isLoading = true;
    });

    CardData card =
        new CardData(cardNumber: _number, csv: _csv, expire: "$_month/$_year");

    PaymentService().saveCard(card).then((_) {
      Logger().i(_);

      if (_) {
        setState(() {
          _isComplete = true;
        });
      }
    });
  }
}
