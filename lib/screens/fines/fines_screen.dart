import 'package:flutter/material.dart';
import 'package:fpay_driver/services/fine_service.dart';
import 'package:fpay_driver/services/payment_service.dart';
import 'package:logger/logger.dart';

class FinesScreen extends StatefulWidget {
  @override
  _FinesScreenState createState() => _FinesScreenState();
}

class _FinesScreenState extends State<FinesScreen> {
  int _tabIndex = 0;

  static List<Widget> _tabs = [ActiveFines(), PaidFines()];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.0, 100.0, 12.0, 0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                child: Container(
                  width: 100,
                  height: (_tabIndex.isEven) ? 43 : 41,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0)),
                      color: (_tabIndex.isEven)
                          ? Colors.white
                          : Color(0xff003b46)),
                  child: Center(
                    child: Text(
                      "On Going",
                      style: TextStyle(
                        color: (_tabIndex.isEven) ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _tabIndex = 0;
                  });
                },
              ),
              InkWell(
                child: Container(
                  width: 100,
                  height: (_tabIndex.isOdd) ? 43 : 41,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0)),
                      color:
                          (_tabIndex.isOdd) ? Colors.white : Color(0xff003b46)),
                  child: Center(
                    child: Text(
                      "Paid",
                      style: TextStyle(
                        color: (_tabIndex.isOdd) ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _tabIndex = 1;
                  });
                },
              ),
            ],
          ),
          Expanded(child: _tabs.elementAt(_tabIndex))
        ],
      ),
    );
  }
}

class ActiveFines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FineService().fetchActiveFines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      '${snapshot.data.elementAt(index).totalValue.toString()} ${snapshot.data.elementAt(index).currency.toUpperCase()}'),
                  subtitle: Text(
                      snapshot.data.elementAt(index).issuedAt.split("T")[0]),
                  trailing: FlatButton(
                    child: Text(
                      "Pay",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color(0xff07575b),
                    onPressed: () {
                      _handlePayment(context, snapshot.data.elementAt(index));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("No fines yet"),
            );
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _handlePayment(BuildContext context, fine) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
            future: PaymentService().isPaymentConfigured(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data) {
                  return AlertDialog(
                    content: FutureBuilder(
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
                                    onPressed: () {},
                                  ),
                                  FlatButton(
                                    child: Text("No"),
                                    onPressed: () {},
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
                    ),
                  );
                } else {
                  return AlertDialog(
                    content: Text(
                        "Please add a payment method first\nFollow profile to add payment method"),
                  );
                }
              }

              return Container();
            },
          );
        });
  }
}

class PaidFines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FineService().fetchPaidFines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      snapshot.data.elementAt(index).totalValue.toString()),
                );
              },
            );
          } else {
            return Center(
              child: Text("No fines yet"),
            );
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
