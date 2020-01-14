import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpay_driver/routes/application.dart';
import 'package:fpay_driver/services/auth_service.dart';
import 'package:fpay_driver/services/fine_service.dart';
import 'package:fpay_driver/services/profile_service.dart';
import 'package:logger/logger.dart';
import 'dart:ui' as ui;

class MyFines extends StatefulWidget {
  @override
  _MyFinesState createState() => _MyFinesState();
}

class _MyFinesState extends State<MyFines> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // Card(
        //   child: Row(
        //     children: <Widget>[
        //       Expanded(
        //         child: ListTile(
        //           title: Text('Fine ID: 017'),
        //           subtitle: Text(
        //               'Fines: ${fines[0]["name"]},${fines[1]["name"]}\nValue:${value}'),
        //         ),
        //       ),
        //       Padding(
        //           padding: EdgeInsets.only(left: 45),
        //           child: RaisedButton(
        //             onPressed: () {},
        //             child: Text("Pay"),
        //             color: Colors.green,
        //           ))
        //     ],
        //   ),
        // ),
        // Card(
        //   child: Row(
        //     children: <Widget>[
        //       Expanded(
        //         child: ListTile(
        //           title: Text('Fine ID: 008'),
        //           subtitle: Text(
        //               'Fines: Fine 2\nValue:1500'),
        //         ),

        //       ),
        //       Padding(
        //           padding: EdgeInsets.only(left: 45),
        //           child: RaisedButton(
        //             onPressed: () {},
        //             child: Text("Pay"),
        //             color: Colors.green,
        //           ))
        //     ],
        //   ),
        // ),
        child: FutureBuilder(
      future: FineService().getFines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          Logger().i("snap");
          Logger().i("snap-null: ${snapshot.data}");
          return Container(
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else {
          Logger().i("snapshotttttt: ${snapshot.data[0].fineId}");
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  "Fine ID: ${snapshot.data[index].fineId}",
                ),
                subtitle: Text(
                  "Value: ${snapshot.data[index].value}",
                ),
                trailing: RaisedButton(
                  onPressed: () {},
                  child: Text("Pay"),
                  color: Colors.green,
                ),
              );
            },
          );
        }
      },
    )

        // Card(
        //   Row(children: <Widget>[
        //     Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       const ListTile(
        //         title: Text('Fine ID: 3265'),
        //         title: Text("${snapshot.data[index].fineId}"
        //       ),
        //     ],),
        //     RaisedButton(
        //       onPressed: () {},
        //     )

        //   ],)
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       const ListTile(
        //         title: Text('Fine ID: 3265'),
        //         subtitle: Text('Fines: Crossing double line\novertaking on pedestrian crossing'),
        //       ),
        //     ],
        //   ),
        // )

        );
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List details;

    void initState() {

    super.initState();
          Logger().i("initstate");
    details = ProfService().getDetails() as List;
    // Logger().i("initstate");

  }






  Future _handleLogout(BuildContext context) async {
    await AuthService().logout().then((res) async {
      Logger().i("true");
      if (res) {
        Application.router.navigateTo(context, '/', clearStack: true);
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

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: Column(
  //       children: <Widget>[
  //         SizedBox(
  //           height: 100,
  //         ),
  //         Center(
  //           //child: getProfilePhoto(),
  //           child: SizedBox(
  //             height: 150
  //           ),
  //         ),
  //         TextField(

  //         ),
  //
  //         )
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl =
        'https://pixel.nymag.com/imgs/daily/selectall/2017/12/26/26-eric-schmidt.w700.h700.jpg';
    TextStyle _style(){
      return TextStyle(
        //color:
        fontWeight: FontWeight.bold,
  
      );
    }
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.greenAccent,
        ),
        //Image.network(imgUrl, fit: BoxFit.fill,),
        BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 6.0,
              sigmaY: 6.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
            )),
        SingleChildScrollView(
            //drawer: Drawer(child: Container(),),
            //backgroundColor: Colors.transparent,
          
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height / 12,
              ),
              CircleAvatar(
                radius: _width < _height ? _width / 4 : _height / 4,
                backgroundImage: NetworkImage(imgUrl),
              ),
              SizedBox(
                height: _height / 25.0,
              ),
              Text(
                'Sashika Nawaratne',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _width / 15,
                    color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _height / 30, left: _width / 8, right: _width / 8),
                // child:Text('Snowboarder, Superhero and writer.\nSometime I work at google as Executive Chairman ',
                //   style: TextStyle(fontWeight: FontWeight.normal, fontSize: _width/25,color: Colors.white),textAlign: TextAlign.center,)
              ),
              // Divider(
              //   height: _height / 30,
              //   color: Colors.white,
              // ),
              // Row(
              //   children: <Widget>[
              //     rowCell(343, 'POSTS'),
              //     rowCell(673826, 'FOLLOWERS'),
              //     rowCell(275, 'FOLLOWING'),
              //   ],
              // ),
              Divider(height: _height / 30, color: Colors.white),
                Column(
                children: <Widget>[
                  Text("NIC No"),
              Text("961881579v",style:_style()),
              SizedBox(height: _height / 25.0,),
              Text("Email"),
              Text("cazci@gmail.com",style:_style()),
              SizedBox(height: _height / 25.0,),
              Text("Driver's Licence No"),
              Text("123456789",style:_style()),
              SizedBox(height: _height / 25.0,),
              Text("Contact No"),
              Text("Not in used",style:_style()),
              SizedBox(height: _height / 25.0,),
                ],
              ),
                Padding(
                padding: EdgeInsets.only(left: _width / 8, right: _width / 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        _handleLogout(context);
                        //_handle();
                      },
                      textColor: Colors.white,
                      child: const Text('Logout', style: TextStyle(fontSize: 20)),
                      color: Colors.red,
                    ),
                    RaisedButton(
                      onPressed: (){},
                      textColor: Colors.white,
                      child: const Text('Edit Details', style: TextStyle(fontSize: 20)),
                      color: Colors.orange,
                    )
                  ],
                ),
              ),

            ])),
              
              
              
            ],
          );
        
      
    
  }

  Widget rowCell(int count, String type) => Expanded(
          child: Column(
        children: <Widget>[
          Text(
            '$count',
            style: TextStyle(color: Colors.white),
          ),
          Text(type,
              style:TextStyle(color: Colors.white, fontWeight: FontWeight.normal))
        ],
      ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List _widgetOptions = <Widget>[
    //Center(child:Text("Bar One")),

    // SizedBox(
    //     height: 50,
    //     child: Column(
    //       children: <Widget>[
    //         Text("Fine Id", style: TextStyle(fontSize: 12)),
    //         Text("Fine Type", style: TextStyle(fontSize: 10)),
    //       ],
    //     ))

    MyFines(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            title: Text('My Fines'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Fine {
  final int fineId;
  final int value;
  //final List penalties;
  // final int policeOfficerId;
  // final int secondOfficerId;
  // final double long;
  // final double lat;

  Fine(
    this.fineId,
    this.value,
    /*this.penalties,this.policeOfficerId,this.secondOfficerId,this.lat,this.long*/
  );
}
