

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain (constants)/app_routes.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration (seconds: 3), (){
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/app_image/logo.png",height: 250,width: 230,),
            SizedBox(width: 15,),
            Text('Welcome to E-Commerce App!',style: TextStyle(
                color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold
            ),),
          ],
        ),
      ),
    );
  }
}