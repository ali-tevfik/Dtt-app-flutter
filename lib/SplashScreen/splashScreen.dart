import 'package:dtt_app/main.dart';
import 'package:dtt_app/thema/colors.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
        color: AppColors.red,
        image: DecorationImage(
            image: AssetImage("assets/images/launcher_icon.png"),
            fit: BoxFit.scaleDown),
      )),
    );
  }
}
