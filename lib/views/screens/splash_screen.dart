import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late bool animate;
  late bool positionText;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushNamed('/');
    });
    changePosition();
  }

  changePosition() async {
    animate = false;
    positionText = false;
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        animate = true;
        positionText = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.easeInOut,
              top: -150.0,
              left: animate ? -550.0 : -1000.0,
              child: Image.asset(
                'lib/assets/images/earth_home.jpg',
                fit: BoxFit.fill,
              ),
            ),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 2500),
                left: 22,
                right: 22,
                bottom: positionText ? 40 : -150,
                child:const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Solar System",
                      style: TextStyle(
                        fontSize: 32,
                        color: Color(0xFF0090CE),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
