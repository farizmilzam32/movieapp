import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieapp/screens/homepage.dart';
import 'package:movieapp/services/dbhelper.dart';
import '../constant/constant.dart';
import '../model/usermodel.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  final dbHelper = DbHelper();

  void signUp() async {
    String userName = _userName.text;
    String email = _email.text;
    String password = _password.text;
    try {
      _formKey.currentState?.save();
      UserModel? userModel = UserModel(userName, email, password);
      await dbHelper.saveData(userModel).then((userData) {
        Fluttertoast.showToast(
            msg: "Successfully Saved",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      });
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Error Data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
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
                      'Register'.toUpperCase(),
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      controller: _userName,
                      decoration: const InputDecoration(
                          labelText: 'Username', hintText: 'username'),
                    ),
                    TextField(
                      controller: _email,
                      decoration: const InputDecoration(
                          labelText: 'Email', hintText: 'email'),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Password', hintText: 'password'),
                    ),
                    ElevatedButton(
                      onPressed: signUp,
                      style: ElevatedButton.styleFrom(
                          primary: Constant.secondaryColor),
                      child: Text(
                        'Register'.toUpperCase(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen()));
                        },
                        child: const Text('Already have an account? Login'))
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
