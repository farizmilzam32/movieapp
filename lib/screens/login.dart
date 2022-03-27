import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieapp/constant/constant.dart';
import 'package:movieapp/screens/homepage.dart';
import 'package:movieapp/screens/register.dart';
import 'package:movieapp/services/dbhelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/usermodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();


  final _email = TextEditingController();
  final _password = TextEditingController();



  final dbHelper = DbHelper();
  void login() async{
    String email = _email.text;
    String password = _password.text;
    try{
      await dbHelper.getLoginUser(email, password).then((userData){
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
                    (Route<dynamic> route) => false);
          });
        } else {
          Fluttertoast.showToast(msg: "Data Not Found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        }
      });
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: "Error Data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("email", user.email!);
    sp.setString("password", user.password!);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.primaryColor,
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(Constant.p16),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(Constant.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sign In'.toUpperCase(),
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                     TextField(
                      controller: _email,
                      decoration: const InputDecoration(
                          labelText: 'Email', hintText: 'test@test.com'),
                    ),
                     TextField(
                      controller: _password,
                      decoration: const InputDecoration(
                          labelText: 'Password', hintText: '123456'),
                       obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                          primary: Constant.secondaryColor),
                      child: Text(
                        'Sign In'.toUpperCase(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  const RegisterScreen()));
                        },
                        child: const Text('Dont have an account? Register'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


