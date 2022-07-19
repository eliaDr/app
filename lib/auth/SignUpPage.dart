import 'package:flutter/material.dart';
import 'firebaseAuth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? signUpStatusMessage;

  void sign_up({required String email, required String password}) async {
    if (email.contains('@') != true) {
      signUpStatusMessage = 'Invalid email address';
    } else if (password.length <= 5) {
      signUpStatusMessage = 'Password is too short';
    } else if (signUpStatusMessage == 'Already in use') {
      signUpStatusMessage = 'Email already in use';
    } else {
      final user = Auth(email: email, password: password);
      var signUpStatus = user.signUp();
      setState(() {
        signUpStatusMessage = '';
      });
      signUpStatusMessage = await signUpStatus;
      while (signUpStatusMessage == '') {
        await Future.delayed(Duration(seconds: 1));
        signUpStatusMessage = await signUpStatus;
      }
    }

    setState(() {
      signUpStatusMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          margin: const EdgeInsets.fromLTRB(5, 160, 5, 0),
          child: Container(
              color: const Color(0xFFFAFAFA),
              child: Column(children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                    child: const Text('Sign up',
                        style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFF1F2226),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Align(
                    child: Column(children: [
                  Card(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: const Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(17, 30, 17, 0),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(15, 7, 5, 0),
                      child: TextField(
                        controller: emailController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          labelText: 'Email Adress',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: const Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(17, 30, 17, 0),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(15, 7, 5, 0),
                      child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: InputBorder.none,
                          )),
                    ),
                  ),
                  Container(
                    child: signUpStatusMessage != null
                        ? Text(signUpStatusMessage.toString())
                        : Container(),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(500, 50),
                        primary: const Color(0xFFFBB827),
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Log in'),
                      onPressed: () => sign_up(
                          email: emailController.text,
                          password: passwordController.text),
                    ),
                  ),
                  signUpStatusMessage != null &&
                          signUpStatusMessage != 'Password is too short' &&
                          signUpStatusMessage != 'Invalid email address' &&
                          signUpStatusMessage != 'Email already in use'
                      ? Container(
                          child: CircularProgressIndicator(),
                          margin: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                        )
                      : Container()
                ]))
              ])),
        )
      ]),
    );
  }
}