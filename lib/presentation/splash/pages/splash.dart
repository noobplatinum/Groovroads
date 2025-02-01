import 'package:flutter/material.dart';
import 'package:groovroads/core/configs/assets/appvectors.dart';
import 'package:groovroads/presentation/intro/pages/getstarted.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    redirect();
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (BuildContext context) => GetStarted()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Appvectors.logo,
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
            ),
            const SizedBox(width: 10), // Space between logo and text
            const Text(
              'Groovroads',
              style: TextStyle(
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 151, 161, 12)
              ),
            ),
          ],
        ),
      ),
    );
  }
}