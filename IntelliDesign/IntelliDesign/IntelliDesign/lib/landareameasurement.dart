import 'package:flutter/material.dart';
import 'package:intellidesign/LandArea.dart';
import 'package:intellidesign/remainingarea.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'ResidentialArea.dart';

class landareameasurement extends StatefulWidget {
  static const String screenRoute = 'landareameasurement';
  final String selectedAreaType;
  final String selectedShape;

  const landareameasurement({
    Key? key,
    required this.selectedAreaType,
    required this.selectedShape,
  }) : super(key: key);
  @override
  State<landareameasurement> createState() => _landareameasurementState();
}

class _landareameasurementState extends State<landareameasurement> {
  late double width;
  late double length;
  late double remainland;

  late ResidentialArea area;
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    area = getResidentialArea(widget.selectedAreaType);
  }

  ResidentialArea getResidentialArea(String areaType) {
    print('Getting residential area for type: $areaType');
    switch (areaType) {
      case 'RA':
        return ResidentialAreaA();
      case 'RB':
        return ResidentialAreaB();
      case 'RC':
        return ResidentialAreaC();
      case 'RD':
        return ResidentialAreaD();
      case 'Agricultural':
        return AgriculturalResidentialArea();
      case 'Countryside':
        return CountrysideResidentialArea();

      default:
        throw Exception('Unknown area type: $areaType');
    }
  }

  @override
  void dispose() {
    _widthController.dispose();
    _lengthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      appBar: AppBar(
        title: Text(
          'Land Area',
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
              SizedBox(height: 50),
              Align(
                alignment: AlignmentDirectional(-0.7, -0.55),
                child: Text(
                  'Enter the estimated area of land \n depends on  front side of your house :',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 22,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: AlignmentDirectional(-0.8, -0.3),
                child: Text(
                  ' - width value:',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 22,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                  alignment: AlignmentDirectional(-0.8, -0.3),
                  child: Container(
                      width: 150,
                      child: TextFormField(
                        controller: _widthController,
                        decoration: InputDecoration(
                          labelText: 'Enter the front side  length',
                          labelStyle: TextStyle(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 24,
                            letterSpacing: 0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0F448E),
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Use setState inside onChanged to update the value
                          setState(() {
                            width = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ))),
              const SizedBox(height: 30),
              Align(
                alignment: AlignmentDirectional(-0.8, -0.1),
                child: Text(
                  ' - length value :',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 22,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                  alignment: AlignmentDirectional(-0.8, -0.1),
                  child: Container(
                      width: 150,
                      child: TextFormField(
                        controller: _lengthController,
                        decoration: InputDecoration(
                          labelText: 'Enter the  side length value',
                          labelStyle: TextStyle(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 24,
                            letterSpacing: 0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0F448E),
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            length = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ))),
              const SizedBox(height: 30),
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
                    remainland = area.calculateRemainingArea(width, length);
                    print(remainland);
                    if (remainland == 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alert'),
                            content: Text(
                                'Please consider adjusting the orientation of your future house, as it should not exceed the available land area.'),
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
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RemainingArea(
                            remainland: remainland,
                          ),
                        ),
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
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
