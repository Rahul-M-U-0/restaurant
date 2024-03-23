import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_1/home_screen.dart';
import 'package:restaurant_1/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const String keyEmail = "email";

  @override
  void initState() {
    splashscreenmethod();
    super.initState();
  }

  void splashscreenmethod() async {
    var sharePref = await SharedPreferences.getInstance();
    var isLoggedIn = sharePref.getString(keyEmail);

    if (isLoggedIn != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LogInScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/shopping-cart.jpg"),
      ),
    );
  }
}
