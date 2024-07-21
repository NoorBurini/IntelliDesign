import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intellidesign/homepage.dart';
import 'package:intellidesign/successfullysignup.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class signin extends StatefulWidget {
  static const String screenRoute = 'signin';
  const signin({Key? key}) : super(key: key);
  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      appBar: AppBar(
        title: Text(
          'Sign in',
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
                alignment: AlignmentDirectional(-0.12, -0.91),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    child: Image.asset(
                      width: 186,
                      height: 133,
                      fit: BoxFit.contain,
                      'images/page2pic.png',
                    )),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: AlignmentDirectional(-0.1, -0.48),
                child: Text(
                  'Sign In ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PT Serif',
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0E0404),
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 25),
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
              const SizedBox(height: 25),
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
                        obscureText:
                            _obscureText, // Toggle this value to show/hide the password
                        decoration: InputDecoration(
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
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFF0F448E),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 40),
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
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.pushNamed(context, homepage.screenRoute);
                      } on FirebaseAuthException catch (e) {
                        print('Error code: ${e.code}');
                        print('Error message: ${e.message}');
                        String errorMessage;
                        switch (e.code) {
                          case 'invalid-email':
                            errorMessage = 'The email address is not valid.';
                            break;
                          case 'user-disabled':
                            errorMessage =
                                'The user account has been disabled.';
                            break;
                          case 'user-not-found':
                            errorMessage = 'No user found for that email.';
                            break;
                          case 'wrong-password':
                            errorMessage =
                                'Wrong password provided for that user.';
                            break;
                          case 'invalid-credential':
                            errorMessage =
                                'Please try again your email or your password is invalid';
                          default:
                            errorMessage =
                                'An unexpected error occurred. Please try again later.';
                        }

                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "Authentication Error",
                          desc: errorMessage,
                          buttons: [
                            DialogButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      }
                    },
                    child: const Text(
                      'sign in',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 0,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
