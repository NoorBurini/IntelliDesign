import 'package:flutter/material.dart';
import 'package:intellidesign/homepage.dart';

class successfullysignup extends StatefulWidget {
  static const String screenRoute = 'successfullysignup';
  const successfullysignup({Key? key}) : super(key: key);
  @override
  State<successfullysignup> createState() => _successfullysignupState();
}

class _successfullysignupState extends State<successfullysignup> {
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
                  Align(
                    alignment: AlignmentDirectional(-0.12, -0.8),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        child: Image.asset(
                          width: 200,
                          height: 150,
                          fit: BoxFit.contain,
                          'images/page2pic.png',
                        )),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Color(0xFF0F448E),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.12, -0.93),
                              child: Text(
                                'Success!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  color: Color.fromARGB(255, 244, 248, 246),
                                  fontSize: 38,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.7, -0.23),
                              child: Text(
                                'congratulations,\n your account has been successfully created.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Color.fromARGB(255, 244, 248, 246),
                                  fontSize: 26,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: AlignmentDirectional(0, 0.7),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Color(0xFF0F448E),
                          fixedSize: Size(300, 75),
                          elevation: 3,
                        ),
                        onPressed: (() {
                          Navigator.pushNamed(context, homepage.screenRoute);
                        }),
                        child: const Text(
                          'Get started ..',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                            fontSize: 28,
                            letterSpacing: 0,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
