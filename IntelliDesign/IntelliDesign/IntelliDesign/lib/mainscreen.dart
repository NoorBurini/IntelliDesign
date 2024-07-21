import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intellidesign/signin.dart';
import 'package:intellidesign/signup.dart';

class mainscreen extends StatefulWidget {
  static const String screenRoute = 'mainscreen';
  const mainscreen({Key? key}) : super(key: key);
  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'images/photo-1479839672679-a46483c0e7c8.jpeg'),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0.6),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Text(
                        'IntelliDesign such a tool to experience a new journey by design your house.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: AlignmentDirectional(0, 0.76),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          backgroundColor: Color(0xFF0F448E),
                          fixedSize: Size(180, 40),
                          elevation: 3,
                        ),
                        onPressed: (() {
                          Navigator.pushNamed(context, signup.screenRoute);
                        }),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 244, 248, 246),
                          ),
                        ),
                      )),
                  Align(
                    alignment: AlignmentDirectional(-0.18, 0.84),
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 19, 20, 19),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.62, 0.87),
                    child: ElevatedButton(
                      onPressed: (() {
                        Navigator.pushNamed(context, signin.screenRoute);
                      }),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F448E),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Color(0x00E0E3E7),
                        fixedSize: Size(113, 40),
                        side: BorderSide(
                          color: Color(0x00FFFFFF),
                          width: 1,
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
