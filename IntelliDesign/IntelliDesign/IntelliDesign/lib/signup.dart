import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intellidesign/signin.dart';
import 'package:intellidesign/successfullysignup.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class signup extends StatefulWidget {
  static const String screenRoute = 'signup';
  const signup({Key? key}) : super(key: key);
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      appBar: AppBar(
        title: Text(
          'Sign up',
          style: TextStyle(
            color: Color.fromARGB(246, 252, 252, 253),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 57, 92, 142),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),
              Align(
                alignment: AlignmentDirectional(-0.1, -0.48),
                child: Text(
                  'sign up ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PT Serif',
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0E0404),
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: AlignmentDirectional(-0.86, -0.3),
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0,
                    fontSize: 18,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.21, -0.2),
                child: Container(
                  width: 340,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your Email',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(35),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0F448E),
                          width: 5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(35),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0F448E),
                          width: 5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(35),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: AlignmentDirectional(-0.86, -0.05),
                child: Text(
                  'password',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0,
                    fontSize: 18,
                  ),
                ),
              ),
              Align(
                  alignment: AlignmentDirectional(-0.12, 0.06),
                  child: Container(
                    width: 340,
                    child: Container(
                      width: 340,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your password',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0F448E),
                              width: 5,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0F448E),
                              width: 5,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 35),
              Align(
                  alignment: AlignmentDirectional(-0.24, 0.32),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      backgroundColor: Color(0xFF0F448E),
                      fixedSize: Size(349, 47),
                      elevation: 3,
                    ),
                    onPressed: () async {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        Navigator.pushNamed(
                            context, successfullysignup.screenRoute);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          Alert(
                            context: context,
                            type: AlertType.error,
                            title: "Error",
                            desc: "This email is already in use",
                            buttons: [
                              DialogButton(
                                // ignore: sort_child_properties_last
                                child: const Text(
                                  "Try again",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        } else if (e.code == 'invalid-email') {
                          Alert(
                            context: context,
                            type: AlertType.error,
                            title: "Error",
                            desc: "The email address is not accepted",
                            buttons: [
                              DialogButton(
                                // ignore: sort_child_properties_last
                                child: const Text(
                                  "Try again",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        } else if (e.code == 'weak-password') {
                          Alert(
                            context: context,
                            type: AlertType.error,
                            title: "Error",
                            desc: "Password must be at least 6 characters",
                            buttons: [
                              DialogButton(
                                // ignore: sort_child_properties_last
                                child: const Text(
                                  "Try again",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        } else {
                          Alert(
                            context: context,
                            type: AlertType.error,
                            title: "Error",
                            desc: e.code,
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "Try again",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                      }
                    },
                    child: const Text(
                      'sign up',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 0,
                      ),
                    ),
                  )),
              const SizedBox(height: 50),
              Row(children: [
                Text(
                  '        Already have an account?',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 18,
                    letterSpacing: 0,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    fixedSize: Size(100, 40),
                    elevation: 0,
                  ),
                  onPressed: (() {
                    Navigator.pushNamed(context, signin.screenRoute);
                  }),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F448E),
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
