library iot.base_screen;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot/tesla_app/configs/colors.dart';
import 'package:iot/tesla_app/screens/settings_screen.dart';

import 'home_screen.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  void initState(){
    super.initState();
    getRev();
  }

  getRev(){
    var databaseRef = FirebaseDatabase.instance.reference();
    setState(() {
      databaseRef.child("slideswitch").once().then((DataSnapshot snapshot) {
        setState(() {
          ReverseGear = snapshot.value;
          if(ReverseGear.toString() == "ON"){
            navigateTo(2);
          }
          else{
            navigateTo(0);
          }
        });
      });
    });
  }
  navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  var EngineStatus, ReverseGear;
  setData(){
    var databaseRef = FirebaseDatabase.instance.reference();
    databaseRef.child("Engine").once().then((DataSnapshot snapshot) {
      setState(() {
        EngineStatus = snapshot.value;
      });
    });
    if(EngineStatus.toString() == "OFF"){
      databaseRef.update({
        'Engine': 'ON'
      });
      // navigateTo(2);
    }
    else{
      databaseRef.update({
      'Engine': 'OFF'
      });
    }
}



  Widget _bottomAppBarIcon({required int index, required IconData icon}) {
    getRev();
    return IconButton(
      onPressed: () {
        navigateTo(index);
      },
      icon: Icon(
        icon,
        color: _selectedIndex == index ? kPrimaryColor : null,
      ),
      iconSize: 35,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: SafeArea(
          child: Container(
            height: 70,
            color: kBottomAppBarColor,
            child: Material(
              type: MaterialType.transparency,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _bottomAppBarIcon(index: 0, icon: Icons.home_rounded),
                  _bottomAppBarIcon(index: 1, icon: Icons.bar_chart_rounded),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: 20,
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: buttonGradient),
                              child: IconButton(
                                  iconSize: 60,
                                  onPressed: setData,
                                  icon: Icon(
                                    Icons.power_settings_new_rounded,
                                    color: Colors.white,
                                  ))),
                        ),
                      ],
                    ),
                  ),
                  _bottomAppBarIcon(index: 2, icon: Icons.directions_car_sharp),
                  _bottomAppBarIcon(index: 3, icon: Icons.account_circle_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: kBackGroundGradient
        ),
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            HomeScreen(),
            Container(
              child: Center(child: Text('page 02', style: TextStyle(color: Colors.blue),)),
            ),
            SettingsScreen(),
            Container()
          ],
        ),
      ),
    );
  }
}
