import 'dart:async';

import 'package:app_pengaduan_masyarakat/pages/login_page.dart';
import 'package:app_pengaduan_masyarakat/pages/staging_page.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 5), 
    () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: 
    (BuildContext context) => const StagingPage(),
    ),
  ),
);
    
    return  Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Center(
              child: Image.asset('assets/images/logo.png', ),
            ),
          ],
        ),
      ),
    );

  }
}