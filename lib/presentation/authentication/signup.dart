import 'package:flutter/material.dart';
import 'package:groovroads/common/widgets/appbar/appbar.dart';
import 'package:groovroads/common/widgets/button/entrybutton.dart';
import 'package:groovroads/core/configs/assets/appvectors.dart';
import 'package:groovroads/data/models/auth/createuser.dart';
import 'package:groovroads/domain/usecases/auth/signup.dart';
import 'package:groovroads/presentation/authentication/signin.dart';
import 'package:groovroads/presentation/home/pages/home.dart';
import 'package:groovroads/servicelocator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signInText(context),
      appBar: Appbar(
        title: Image.asset(
          Appvectors.logo,
          width: 100,
          height: 100,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 60),
            _fullNameField(context),
            const SizedBox(height: 20),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 100),
            EntryButton(
              onPressed: () async {
                var result = await sl<SignupUseCase>().call(
                  params: CreateUserReq(
                    fullName: _fullName.text.toString(),
                    email: _email.text.toString(),
                    password: _password.text.toString(),
                  )
                );
                result.fold((l){
                  var snackBar = SnackBar(content: Text(l));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }, (r){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()), (route) => false);
                });
              },
              title: 'Create Your Account',
              width: 400,
              height: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              "By making an account, you agree to Groovroads' terms and conditions.",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: InputDecoration(hintText: 'Full Name Here').applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(hintText: 'Email Here').applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(hintText: 'Password Here').applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SigninPage()
                            )
                          );
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}