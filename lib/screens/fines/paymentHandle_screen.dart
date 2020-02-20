import 'package:flutter/material.dart';
import 'package:fpay_driver/model/fine.dart';
import 'package:fpay_driver/services/fine_service.dart';
import 'package:fpay_driver/services/payment_service.dart';
import 'package:logger/logger.dart';

class PaymentHandleScreen extends StatefulWidget {
  @override
  _PaymentHandleScreenState createState() => _PaymentHandleScreenState();

  Fine fine;

  PaymentHandleScreen({this.fine});
}

class _PaymentHandleScreenState extends State<PaymentHandleScreen> {
  bool _isLoading = false;
  bool _isFinalized = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PaymentService().isPaymentConfigured(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return AlertDialog(
              content: (!_isLoading)
                  ? FutureBuilder(
                      future: PaymentService().fetchCard(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Checkout",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                  "Card Number: ${snapshot.data.cardNumber.toString().substring(0, 4)} ${snapshot.data.cardNumber.toString().substring(4, 8)} ${snapshot.data.cardNumber.toString().substring(8, 12)}"),
                              SizedBox(height: 5.0),
                              Text("Are you sure to proceed?"),
                              SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  FlatButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      _continuePayment(widget.fine);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              )
                            ],
                          );
                        }

                        return Container(
                          child: Text("loading"),
                        );
                      },
                    )
                  : (!_isFinalized)
                      ? Container(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          height: 200,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.check),
                                SizedBox(height: 10.0),
                                Text("Fine paid successfully")
                              ]),
                        ),
            );
          } else {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Warning",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Please add a payment method first",
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            );
          }
        }

        return Container();
      },
    );
  }

  void _continuePayment(Fine fine) {
    setState(() {
      _isLoading = true;
    });

    Logger().i(fine.id);

    FineService().payFine(fine.id).then((_) {
      if (_) {
        setState(() {
          _isFinalized = true;
        });
      }
    });
  }
}
