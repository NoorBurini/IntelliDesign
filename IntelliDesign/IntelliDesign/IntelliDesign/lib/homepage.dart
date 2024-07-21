import 'package:flutter/material.dart';
import 'package:intellidesign/inputresidential.dart';
import 'package:intellidesign/mainscreen.dart';

class homepage extends StatefulWidget {
  static const String screenRoute = 'homepage';
  const homepage({Key? key}) : super(key: key);
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
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
                    alignment: AlignmentDirectional(0, -0.91),
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
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Container(
                        width: double.infinity,
                        height: 400,
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
                                '   please follow these steps to get the best result: ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.2, -0.2),
                              child: Text(
                                '   1-Enter the area of land.\n   2-choose the type of land.\n   3-press enforce constraints.\n   4-choose your preferred    preferences from the list. \n   5-press generate design. ',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Mukta',
                                  color: Colors.white,
                                  fontSize: 22,
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
                      alignment: AlignmentDirectional(0, 0.63),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Color(0xFF0F448E),
                          fixedSize: Size(300, 47),
                          elevation: 3,
                        ),
                        onPressed: (() {
                          Navigator.pushNamed(
                              context, InputResidential.screenRoute);
                        }),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                            fontSize: 28,
                            letterSpacing: 0,
                          ),
                        ),
                      )),
                  Align(
                      alignment: AlignmentDirectional(0, 0.82),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Color(0xFF0F448E),
                          fixedSize: Size(300, 47),
                          elevation: 3,
                        ),
                        onPressed: (() {
                          Navigator.pushNamed(context, mainscreen.screenRoute);
                        }),
                        child: const Text(
                          'Back',
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
