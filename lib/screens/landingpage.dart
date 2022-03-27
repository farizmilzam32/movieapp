import 'package:flutter/material.dart';
import 'package:movieapp/constant/constant.dart';
import 'package:movieapp/screens/login.dart';
import 'package:movieapp/screens/register.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Constant.secondaryColor),
                  child: Text(
                    'Login'.toUpperCase(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const RegisterScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Constant.secondaryColor),
                  child: Text(
                    'Register'.toUpperCase(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
