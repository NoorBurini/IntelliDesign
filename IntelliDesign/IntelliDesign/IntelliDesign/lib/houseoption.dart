import 'package:flutter/material.dart';
import 'package:intellidesign/optionsearch.dart';
import 'package:intellidesign/preferenceslist.dart';

class houseoption extends StatefulWidget {
  static const String screenRoute = 'houseoption';
  final double housearea;

  const houseoption({
    Key? key,
    required this.housearea,
  }) : super(key: key);

  @override
  State<houseoption> createState() => _houseoptionState();
}

class _houseoptionState extends State<houseoption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      appBar: AppBar(
        title: Text(
          'house design',
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
              const SizedBox(height: 40),
              Text(
                textAlign: TextAlign.center,
                'choose from these two options:', // enforce constaint
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Readex Pro',
                  color: const Color.fromARGB(255, 18, 17, 17),
                  fontSize: 30,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Color(0xFF0F448E),
                  fixedSize: Size(300, 100),
                  elevation: 3,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => optionsearch(
                        housearea: widget.housearea,
                      ),
                    ),
                  );
                },
                child: const Text(
                  textAlign: TextAlign.center,
                  '1-House design samples', // enforce constaint
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 30,
                    letterSpacing: 0,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Color(0xFF0F448E),
                  fixedSize: Size(300, 100),
                  elevation: 3,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => preferenceslist(
                        housearea: widget.housearea,
                      ),
                    ),
                  );
                },
                child: const Text(
                  textAlign: TextAlign.center,
                  '2-preferences  list ', // enforce constaint
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 30,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
