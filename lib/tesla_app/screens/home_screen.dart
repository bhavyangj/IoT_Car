import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:iot/tesla_app/configs/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'base_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState(){
    super.initState();
    getData();
  }
  var delay = 15000;
  var HeadLight="OFF";
  var EngineStatus, ReverseGear, RainSensor=1000;
  var temperatureValue, KilloMeter=0.0;
  double fuelValue = 0.0, FuelCon = 0.0;
  var fuelPercentage=0.0;
  void getData(){
    // print("status: ${status}");
    var databaseRef = FirebaseDatabase.instance.reference();

    databaseRef.child("temperature").once().then((DataSnapshot snapshot) {
      //print('temparature:  ${snapshot.value}');
      setState(() {
        temperatureValue = snapshot.value;
      });
    });
    databaseRef.child("fuel").once().then((DataSnapshot snapshot) {
      fuelValue = double.parse((snapshot.value).toStringAsFixed(1));
      Future.delayed(Duration(milliseconds: delay), () {
        setState(() {
          fuelValue -= double.parse((0.01).toStringAsFixed(1));
          databaseRef.update({
            'fuel': fuelValue
          });
        });
      });
      fuelPercentage = fuelValue/100;
    });
    databaseRef.child("Km").once().then((DataSnapshot snapshot) {
      Future.delayed(Duration(milliseconds: delay), () {
        setState(() {
          KilloMeter = snapshot.value;
          FuelCon = KilloMeter / 12;
          KilloMeter += double.parse((0.1).toStringAsFixed(1));
          databaseRef.update({
            'Km': KilloMeter
          });
          FuelCon = double.parse((FuelCon).toStringAsFixed(1));
        });
      });
        // fuelValue = double.parse((fuelValue).toStringAsFixed(1));
      // KilloMeter += 0.1;
    });
    databaseRef.child("Engine").once().then((DataSnapshot snapshot) {
      //print('fuel value:  ${snapshot.value}');
      setState(() {
        EngineStatus = snapshot.value;
      });
    });
    databaseRef.child("Light").once().then((DataSnapshot snapshot) {
      setState(() {
        HeadLight = snapshot.value;
      });
    });
    databaseRef.child("rainsensor").once().then((DataSnapshot snapshot) {
      //print('rainsensor value:  ${snapshot.value}');
      setState(() {
        RainSensor = snapshot.value;
      });
    });
    databaseRef.child("rfid").once().then((DataSnapshot snapshot) {
      //print('RFID status:  ${snapshot.value}');
      // data.replaceAll();
    });
    databaseRef.child("slideswitch").once().then((DataSnapshot snapshot) {
      setState(() {
        ReverseGear = snapshot.value;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    // setState(() {
      getData();
    // });
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                type: MaterialType
                    .transparency, // to visible splash / ripple effect. the parent's decoration color is covering ripple effect
                child: Row(
                  children: [
                    IconButton(
                        iconSize: 50,
                        splashRadius: 25,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: kPrimaryColor,
                        )),
                    const Spacer(),
                    Stack(
                      children: [
                        IconButton(
                            iconSize: 50,
                            splashRadius: 25,
                            onPressed: () {},
                            icon: const FittedBox(
                                child: Icon(Icons.account_circle_rounded))),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                                color: kPrimaryColor, shape: BoxShape.circle),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Text(
                'BMW',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 35),
                child: Text(
                  'Model X',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w200),
                ),
              ),
              const SizedBox(height: 20,),
              HeadLight=="ON"?Image.asset('lib/tesla_app/images/homepage_tesla4.png')
              :Image.asset('lib/tesla_app/images/homepage_tesla3.png'),
              const SizedBox(height: 50,),

              Circular(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('lib/tesla_app/images/lighting.svg'),
                  const Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Text('Good Battery Health'),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: kCardColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Temperature',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              const Text('Cabin'),
                              const SizedBox(height: 10),
                              Center(
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: temperatureValue.toString(),
                                        style: const TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor)),
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0, -12),
                                        child: const Text('°C',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryColor)),
                                      ),
                                    )
                                  ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Card(
                      color: kCardColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Distance Covered',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              const Text('Today'),
                              const SizedBox(height: 10),
                              Center(
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: double.parse((KilloMeter).toStringAsFixed(1)).toString(),
                                        style: const TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor)),
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0, -5),
                                        child: const Text(' Km',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryColor)),
                                      ),
                                    )
                                  ]),
                                ),
                                // child: Text("$KilloMeter km",
                                //     style: TextStyle(
                                //         fontSize: 50,
                                //         fontWeight: FontWeight.bold,
                                //         color: kPrimaryColor)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: kCardColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Raining Outside',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              // if(RainSensor>800)
                              // Text('C'),
                              SizedBox(height: 10),
                              Center(
                                child: RichText(
                                  text: TextSpan(children: [
                                    RainSensor>2500 ? const TextSpan(text: "NO RAIN", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: kPrimaryColor))
                                        :(RainSensor<=2500&& RainSensor>2000? const TextSpan(text: "LOW", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: kPrimaryColor))
                                        :(RainSensor<=2000&& RainSensor>1500?const TextSpan(text: "MED", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: kPrimaryColor))
                                        :const TextSpan(text: "HIGH", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: kPrimaryColor)))),
                                    // else if(RainSensor<800 && RainSensor>=600)
                                    // WidgetSpan(
                                    //   child: Transform.translate(
                                    //     offset: Offset(0, -12),
                                    //     child: Text('C',
                                    //         style: TextStyle(
                                    //             fontSize: 30,
                                    //             fontWeight: FontWeight.bold,
                                    //             color: kPrimaryColor)),
                                    //   ),
                                    // )
                                  ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Card(
                      color: kCardColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Fuel Consumption',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              const Text('Today'),
                              const SizedBox(height: 10),
                              Center(
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: '$FuelCon',
                                        style: const TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor)),
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0, 0),
                                        child: const Text(' L',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryColor)),
                                      ),
                                    )
                                  ]),
                                ),
                                // child: Text('4.3',
                                //     style: TextStyle(
                                //         fontSize: 50,
                                //         fontWeight: FontWeight.bold,
                                //         color: kPrimaryColor)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget Circular(){
    if(EngineStatus == "ON"){
      delay = 15000;
      return CircularPercentIndicator(
        radius: 200.0,
        lineWidth: 25.0,
        animation: true,
        percent: fuelPercentage,
        center: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                double.parse((fuelValue).toStringAsFixed(1)).toString() + "%",
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
              ),
              const Text(
                'Fuel',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: kPrimaryColor,
        backgroundColor: kProgressBackGroundColor,
      );
    }
    else{
      delay = 99999999;
      return CircularPercentIndicator(
        radius: 200.0,
        lineWidth: 25.0,
        animation: true,
        percent: 0,
        center: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Engine",
                style:
                TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
              ),
              Text(
                'OFF',
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: kPrimaryColor,
        backgroundColor: kProgressBackGroundColor,
      );
    }
  }
}
