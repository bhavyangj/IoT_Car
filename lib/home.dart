import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String data = "";
  final databaseRef = FirebaseDatabase.instance.reference();
  void getData(){
    databaseRef.child("ultrasonic").once().then((DataSnapshot snapshot) {
      print('Ultrasonic value:  ${snapshot.value}');
      // data.replaceAll();
    });
    databaseRef.child("rainsensor").once().then((DataSnapshot snapshot) {
      print('rainsensor value:  ${snapshot.value}');
      // data.replaceAll();
    });
    databaseRef.child("rfid").once().then((DataSnapshot snapshot) {
      print('RFID status:  ${snapshot.value}');
      // data.replaceAll();
    });
    databaseRef.child("slideswitch").once().then((DataSnapshot snapshot) {
      print('SlideSwitch value:  ${snapshot.value}');
      // data.replaceAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              FlatButton(
                child: Text('Get Data', style: TextStyle(fontSize: 20.0),),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: getData,
              ),

              // Text("Data:", data.toString())
            ],
          ),
        ),
      ),
    );
  }
}
