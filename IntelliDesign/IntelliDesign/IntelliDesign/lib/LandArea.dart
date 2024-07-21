import 'package:flutter/material.dart';
import 'package:intellidesign/inputresidential.dart';
import 'package:intellidesign/landareameasurement.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LandArea extends StatefulWidget {
  static const String screenRoute = 'LandArea';
  final String selectedAreaType; // Add this line

  // Modify the constructor to include the selectedAreaType
  const LandArea({Key? key, required this.selectedAreaType}) : super(key: key);

  @override
  State<LandArea> createState() => _LandAreaState();
}

class _LandAreaState extends State<LandArea> {
  bool square = false;
  bool rectangular = false;
  String getSelectedShape() {
    if (square) return 'Square';
    if (rectangular) return 'Rectangular';
    return 'None'; // Default value if no shape is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      appBar: AppBar(
        title: Text(
          'Land shape ',
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
                    alignment: AlignmentDirectional(-0.8, -0.40),
                    child: Text(
                      'Check the closest land shape : ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'PT Serif',
                        color: Color(0xF30E0404),
                        fontSize: 24,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.9, -0.2),
                    child: Checkbox(
                      value: this.square,
                      onChanged: (bool? newValue) {
                        setState(() {
                          this.square = newValue!;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.6, -0.2),
                    child: Text(
                      'square',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.6, 0),
                    child: Icon(
                      Icons.square_sharp,
                      color: Color(0xFF0F448E),
                      size: 120,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.1, -0.2),
                    child: Checkbox(
                      value: this.rectangular,
                      onChanged: (bool? newValue) {
                        setState(() {
                          this.rectangular = newValue!;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.6, -0.2),
                    child: Text(
                      'rectangular',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                      alignment: AlignmentDirectional(0.6, 0),
                      child: Icon(
                        Icons.rectangle,
                        color: Color(0xFF0F448E),
                        size: 130,
                      )),
                  Align(
                      alignment: AlignmentDirectional(0, 0.57),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Color(0xFF0F448E),
                          fixedSize: Size(300, 47),
                          elevation: 3,
                        ),
                        onPressed: () {
                          String s = getSelectedShape();
                          if (s != 'None') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => landareameasurement(
                                  selectedAreaType: widget.selectedAreaType,
                                  selectedShape: getSelectedShape(),
                                ),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Alert'),
                                  content: Text(
                                      'Attention: Please ensure that you select the appropriate shape of the land.'),
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
                        },
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
