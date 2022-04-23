import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:iot/tesla_app/app.dart';

import 'home.dart';
import 'main.dart';

class Spalsh extends StatefulWidget {
  const Spalsh({Key? key}) : super(key: key);

  @override
  State<Spalsh> createState() => _SpalshState();
}

class _SpalshState extends State<Spalsh> {
  @override
  void initState(){
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async{
    await Future.delayed(const Duration(milliseconds: 5000),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TeslaApp()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            SizedBox(height: 350),
            Text(
              "Automatic Car",
              style: TextStyle(
                  fontSize: 28,
                  color:  Color.fromARGB(255, 1, 161, 254),
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Monitoring System",
              style: TextStyle(
                  fontSize: 28,
                  color:  Color.fromARGB(255, 1, 161, 254),
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Created By : ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Bhavyang Jariwala ( CO )",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Shiven Desai ( EC )",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Dipam Modi ( IC )",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),

          ]
        ),
      ),
    );
  }
}
