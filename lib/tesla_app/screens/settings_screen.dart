import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iot/tesla_app/configs/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState(){
    super.initState();
    getData();
  }
  var ReverseMode = "ON";
  var ultrasonic,distancePercentage=0.0;

  void getData() {
    var databaseRef = FirebaseDatabase.instance.reference();

    databaseRef.child("slideswitch").once().then((DataSnapshot snapshot) {
      //print('temparature:  ${snapshot.value}');
      setState(() {
        ReverseMode = snapshot.value;
      });
      // data.replaceAll();
    });
    databaseRef.child("ultrasonic").once().then((DataSnapshot snapshot) {
      //print('fuel value:  ${snapshot.value}');
      setState(() {
        ultrasonic = snapshot.value;
      });
      distancePercentage = (ultrasonic*1.5) /100 ;
      // data.replaceAll();
    });
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    iconSize: 20,
                    splashRadius: 25,
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    )),
                const Text(
                  'Safe Distance',
                  style: TextStyle(fontSize: 22),
                ),
                const Spacer(),
                const Text(
                  'BMW',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20.0,),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: kCardGradient),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: 600,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Text(
                            'REVERSE GEAR $ReverseMode',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Positioned(
                        //   top: 0,
                        //   right: 0,
                        //   child: Container(
                        //       decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           gradient: buttonGradient),
                        //       child: IconButton(
                        //           iconSize: 25,
                        //           onPressed: () {},
                        //           icon: Icon(
                        //             Icons.replay_rounded,
                        //             color: Colors.white,
                        //           ))),
                        // ),
                        Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            child: SizedBox(
                              width: 350,
                              height: 650,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Center(
                                      child: Container(
                                        width: 230,
                                        height: 230,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kPrimaryColor),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(width: 350, height: 350, child: CustomRipple()),
                                  ),
                                  Positioned(
                                      top: 100,
                                      right: 40,
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: CustomRipple())),
                                  Positioned(
                                      top: 115,
                                      right: 55,
                                      child: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: CustomRipple())),
                                  Positioned(
                                      top: 100,
                                      left: 40,
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: CustomRipple())),
                                  Positioned(
                                      top: 115,
                                      left: 55,
                                      child: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: CustomRipple())),
                                  Positioned(
                                      bottom: 100,
                                      right: 40,
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: CustomRipple())),
                                  Positioned(
                                      bottom: 115,
                                      right: 55,
                                      child: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: CustomRipple())),
                                  Positioned(
                                      bottom: 100,
                                      left: 40,
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: CustomRipple())),
                                  Positioned(
                                      bottom: 115,
                                      left: 55,
                                      child: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: CustomRipple())),
                                  Center(
                                    child: SizedBox(
                                      height: 650,
                                      child: Image.asset(
                                        'lib/tesla_app/images/bird_view_tesla.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  const Text('Safe Distance',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20,),
                  LinearPercentIndicator(
                    animation: true,
                    backgroundColor: kProgressBackGroundColor.withOpacity(0.5),
                    percent: distancePercentage,
                    lineHeight: 20,
                    animationDuration: 2500,
                    center: Text('${distancePercentage*100} %'),
                    linearGradient: const LinearGradient(
                        colors: [kPrimaryColor, kSecondaryColor]),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20, bottom: 20),
                  //   child: Text('Sensors',
                  //       style: TextStyle(fontWeight: FontWeight.bold)),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Sensor(
                  //       value: 0.8,
                  //       label: 'Motors',
                  //     ),
                  //     Sensor(
                  //       value: 0.4,
                  //       label: 'Batery Temp',
                  //     ),
                  //     Sensor(
                  //       value: 0.9,
                  //       label: 'Brakes',
                  //     ),
                  //     Sensor(
                  //       value: 0.6,
                  //       label: 'Suspentions',
                  //     )
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('ReverseMode', ReverseMode));
  }
}

class Sensor extends StatelessWidget {
  const Sensor({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  final double value;
  final double heigth = 120.0;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 50,
              height: heigth,
              color: kProgressBackGroundColor.withOpacity(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: heigth * value,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: buttonGradient.colors)),
                  )
                ],
              ),
            )),
        const SizedBox(height: 5,),
        Text(label)
      ],
    );
  }
}

class CustomRipple extends StatefulWidget {
  CustomRipple({Key? key}) : super(key: key);

  @override
  _CustomRippleState createState() => _CustomRippleState();
}

class _CustomRippleState extends State<CustomRipple>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animation = Tween<double>(begin: 0.4, end: 0.8).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor, width: 8),
            shape: BoxShape.circle),
      ),
    );
  }
}
