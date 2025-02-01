import 'package:flutter/material.dart';
import 'package:groovroads/common/helpers/isdarkmode.dart';
import 'package:groovroads/common/widgets/appbar/appbar.dart';
import 'package:groovroads/common/widgets/button/entrybutton.dart';
import 'package:groovroads/core/configs/assets/appvectors.dart';
import 'package:groovroads/presentation/authentication/signin.dart';
import 'package:groovroads/presentation/authentication/signup.dart';

class SignX extends StatelessWidget {
  const SignX({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Appbar(),
          Align(
            alignment: Alignment.topRight,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xFFB8860B),
                BlendMode.srcIn,
              ),
              child: Image.asset(
                Appvectors.topB,
                width: 150,
                height: 150,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xFFB8860B),
                BlendMode.srcIn,
              ),
              child: Image.asset(
                Appvectors.botB,
                width: 150,
                height: 150,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Appvectors.logo,
                    width: 250,
                    height: 150,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'On Any Road You Travel',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(179, 175, 150, 80),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Start by making an account or signing in',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(179, 97, 96, 93),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: EntryButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignupPage()
                            )
                          );
                          }, 
                          title: "Register",
                          height: 60,
                        ),
                      ),
                      const SizedBox(width: 10), 
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SigninPage()
                            )
                          );
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size(150, 50),
                          ), 
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: context.isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}