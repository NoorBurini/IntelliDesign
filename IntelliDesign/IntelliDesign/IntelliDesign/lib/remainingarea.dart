import 'package:flutter/material.dart';
import 'package:intellidesign/houseoption.dart';
import 'ResidentialArea.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RemainingArea extends StatefulWidget {
  static const String screenRoute = 'RemainingArea';
  final double remainland;

  const RemainingArea({
    Key? key,
    required this.remainland,
  }) : super(key: key);

  @override
  State<RemainingArea> createState() => _RemainingAreaState();
}

class _RemainingAreaState extends State<RemainingArea> {
  late double housearea;
  final TextEditingController _houseareaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      appBar: AppBar(
        title: Text(
          'Remaining Area',
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
                  '- The remaining area of land : ${widget.remainland.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Color.fromARGB(255, 57, 92, 142),
                    fontFamily: 'Readex Pro',
                    fontSize: 30,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'please enter the estimated  house area that proportional to the remaining land area :',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 22,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  width: 150,
                  child: TextFormField(
                    controller: _houseareaController,
                    decoration: InputDecoration(
                      labelText: 'Enter the area of house',
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
                        housearea = double.tryParse(value) ?? 0.0;
                      });
                    },
                  )),
              const SizedBox(height: 50),
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
                      if (housearea <= widget.remainland) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => houseoption(
                              housearea: housearea,
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
                                  'Attention: House size must not exceed the available land area.'),
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
                      'Next', // enforce constaint
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
      ),
    );
  }
}
