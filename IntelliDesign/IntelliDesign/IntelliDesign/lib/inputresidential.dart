import 'package:flutter/material.dart';
import 'package:intellidesign/LandArea.dart';
import 'package:intellidesign/homepage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class InputResidential extends StatefulWidget {
  static const String screenRoute = 'inputresidential';
  const InputResidential({Key? key}) : super(key: key);
  @override
  State<InputResidential> createState() => _InputResidentialState();
}

class _InputResidentialState extends State<InputResidential> {
  late double userFront;
  late double userBack;
  late double userSide;
  bool valueareaA = false;
  bool valueareaB = false;
  bool valueareaC = false;
  bool valueareaD = false;
  bool valueareaAgricultural = false;
  bool valueareaCountryside = false;
  String getSelectedAreaType() {
    if (valueareaA) return 'RA';
    if (valueareaB) return 'RB';
    if (valueareaC) return 'RC';
    if (valueareaD) return 'RD';
    if (valueareaAgricultural) return 'Agricultural';
    if (valueareaCountryside) return 'Countryside';
    return 'None'; // Default value if no checkbox is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      appBar: AppBar(
        title: Text(
          'Residential areas type',
          style: TextStyle(
            color: Color.fromARGB(246, 252, 252, 253),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 57, 92, 142),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(-0.03, -0.86),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        child: Image.asset(
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                          'images/page2pic.png',
                        )),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.86, -0.45),
                    child: Text(
                      'Residential areas type : ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'PT Serif',
                        color: Color(0xF30E0404),
                        fontSize: 28,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.87, -0.3),
                    child: Checkbox(
                      value: this.valueareaA,
                      onChanged: (bool? newValue) {
                        setState(() {
                          this.valueareaA = newValue!;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.25, -0.3),
                    child: Text(
                      'residential sector (A)',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.87, -0.15),
                    child: Checkbox(
                      value: this.valueareaB,
                      onChanged: (bool? newValue) {
                        setState(() {
                          this.valueareaB = newValue!;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.25, -0.15),
                    child: Text(
                      'residential sector (B)',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.87, 0),
                    child: Checkbox(
                      value: this.valueareaC,
                      onChanged: (bool? newValue) {
                        setState(() {
                          this.valueareaC = newValue!;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.25, 0),
                    child: Text(
                      'residential sector (C)',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.87, 0.15),
                    child: Checkbox(
                      value: this.valueareaD,
                      onChanged: (bool? newValue) {
                        setState(() {
                          this.valueareaD = newValue!;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.25, 0.15),
                    child: Text(
                      'residential sector (D)',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.87, 0.3),
                    child: Checkbox(
                      value: this.valueareaAgricultural,
                      onChanged: (bool? newValue) {
                        setState(() {
                          this.valueareaAgricultural = newValue!;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.25, 0.3),
                    child: Text(
                      'Agricultural residential ',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.87, 0.45),
                    child: Checkbox(
                      value: this.valueareaCountryside,
                      onChanged: (bool? newValue) {
                        setState(() {
                          this.valueareaCountryside = newValue!;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.25, 0.45),
                    child: Text(
                      'Countryside residential ',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                      alignment: AlignmentDirectional(0, 0.7),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Color(0xFF0F448E),
                          fixedSize: Size(300, 47),
                          elevation: 3,
                        ),
                        onPressed: (() {
                          String s = getSelectedAreaType();
                          if (s != 'None') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LandArea(
                                    selectedAreaType: getSelectedAreaType()),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Alert'),
                                  content: Text(
                                      'Attention: Please ensure that you select the land type.'),
                                  actions: <Widget>[
                                    DialogButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Color(0xFF0F448E),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
