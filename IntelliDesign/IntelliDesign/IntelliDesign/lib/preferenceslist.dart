import 'package:flutter/material.dart';
import 'package:intellidesign/genfloorpalndisplay.dart';
import 'RoomPlanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intellidesign/FloorplanAlert.dart';
import 'dart:io';

class preferenceslist extends StatefulWidget {
  static const String screenRoute = 'preferenceslist';
  final double housearea;

  const preferenceslist({
    Key? key,
    required this.housearea,
  }) : super(key: key);

  @override
  State<preferenceslist> createState() => _preferenceslistState();
}

class _preferenceslistState extends State<preferenceslist> {
  final RoomPlanner planner = RoomPlanner();
  List<String> selectedRooms = [
    "Entrance",
    "LivingRoom1",
    "Kitchen1",
    "GuestRoom"
  ];

  late double totalArea = widget.housearea; // Replace with actual value
  double remainingArea = 0.0;
  Map<String, bool> roomSelection = {
    "Bedroom1": false,
    "Bedroom2": false,
    "Bedroom3": false,
    "MasterBedroom1": false,
    "MasterBedroom2": false,
    "LivingRoom1": false,
    "LivingRoom2": false,
    "Bathroom1": false,
    "Bathroom2": false,
    "Bathroom3": false,
    "Balcony1": false,
    "Balcony2": false,
    "Kitchen1": false,
    "Kitchen2": false,
    "Store1": false,
    "Store2": false,
    "GuestRoom": false,
    // Add all other rooms here
  };

  void updateRemainingArea() {
    // Calculate the selected room numbers based on the roomSelection map
    List<int> selectedRoomNumbers = roomSelection.entries
        .where((entry) => entry.value)
        .map((entry) => planner.items.keys.firstWhere(
                (k) => planner.items[k] == entry.key,
                orElse: () => -1) // Provide a default value to avoid null
            )
        .where((number) => number != -1) // Filter out the default value
        .toList();

    // Calculate the fitting rooms and their sizes
    List<MapEntry<String, double>> fittingRooms =
        planner.calculateRoomSizes(totalArea, selectedRoomNumbers);

    // Calculate the remaining area after the rooms have been accounted for
    remainingArea = planner.calculateRemainingArea(totalArea, fittingRooms);

    // Call setState to update the UI
    setState(() {
      // This empty call is enough to trigger the build method
      // You can also perform additional state updates here if necessary
    });
  }

  @override
  void initState() {
    super.initState();
    remainingArea =
        planner.calculateWastedArea(totalArea); // Initial remaining area
  }

  Future<void> sendRoomSelection(totalArea, selectedRooms) async {
    final url = Uri.parse(
        'http://10.0.2.2:5000/receive_data'); //for emulator  http://10.0.2.2:5000

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'total_area': totalArea,
        'selected_rooms': selectedRooms,
      }),
    );
    if (response.statusCode == 200) {
      // List processed successfully
      final responseData = jsonDecode(response.body);
      print(responseData['message']);
      print(responseData['image_url']);
      // Show the received image in an alert
      if (responseData['message'] == 'ok') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => genfloorpalndisplay(
              imgurl: responseData['image_url'],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      appBar: AppBar(
        title: Text(
          'preferences list',
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
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  child: Image.asset(
                    width: 70,
                    height: 70,
                    fit: BoxFit.contain,
                    'images/page2pic.png',
                  )),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   'Remaining Area: ${remainingArea.toStringAsFixed(2)} square units',
              //   style: TextStyle(
              //       // Your text style here
              //       ),
              // ),
              SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.left,
                '- Check the preference you preferer from the list below :', // enforce constaint
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Readex Pro',
                  color: const Color.fromARGB(255, 18, 17, 17),
                  fontSize: 20,
                  letterSpacing: 0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Color(0xFF0F448E),
                width: double.infinity,
                height: 420,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(' - bedroom =',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Text(' 1-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          focusColor: Color.fromARGB(255, 250, 248, 248),
                          value: roomSelection["Bedroom1"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              roomSelection["Bedroom1"] = newValue!;
                              updateRemainingArea();
                              selectedRooms.add("Bedroom1");
                            });
                          },
                        ),
                        Text(' 2-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          focusColor: Color.fromARGB(255, 250, 248, 248),
                          value: roomSelection["Bedroom2"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              roomSelection["Bedroom2"] = newValue!;
                              updateRemainingArea();
                              selectedRooms.add("Bedroom1");
                              selectedRooms.add("Bedroom2");
                            });
                          },
                        ),
                        Text(' 3-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          focusColor: Color.fromARGB(255, 250, 248, 248),
                          value: roomSelection["Bedroom3"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              roomSelection["Bedroom3"] = newValue!;
                              updateRemainingArea();
                              selectedRooms.add("Bedroom1");
                              selectedRooms.add("Bedroom2");
                              selectedRooms.add("Bedroom3");
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(' - Master bedroom =',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Text(' 1-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          focusColor: Color.fromARGB(255, 250, 248, 248),
                          value: roomSelection["MasterBedroom1"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              roomSelection["MasterBedroom1"] = newValue!;
                              updateRemainingArea();
                              selectedRooms.add("MasterBedroom1");
                            });
                          },
                        ),
                        Text(' 2-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          focusColor: Color.fromARGB(255, 250, 248, 248),
                          value: roomSelection["MasterBedroom2"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              roomSelection["MasterBedroom2"] = newValue!;
                              updateRemainingArea();
                              selectedRooms.add("MasterBedroom1");
                              selectedRooms.add("MasterBedroom2");
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(' - livingroom =',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Text(' 1-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          value: true, // Already checked
                          onChanged: null, // Disable the checkbox
                          activeColor: Color(
                              0xFF0F448E), // Set the color for the checkmark
                          checkColor:
                              Colors.white, // Set the color of the checkmark
                        ),
                        Text(' 2-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          focusColor: Color.fromARGB(255, 250, 248, 248),
                          value: roomSelection["LivingRoom2"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              roomSelection["LivingRoom2"] = newValue!;
                              updateRemainingArea();
                              selectedRooms.add("LivingRoom2");
                            });
                          },
                        ),
                        SizedBox(
                          width: 0.5,
                        ),
                      ],
                    ),
                    Row(children: [
                      Text(' - bathroom =',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Readex Pro',
                            color: Color.fromARGB(255, 250, 248, 248),
                            fontSize: 20,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(' 1-',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Readex Pro',
                            color: Color.fromARGB(255, 250, 248, 248),
                            fontSize: 20,
                          )),
                      SizedBox(
                        width: 0.5,
                      ),
                      Checkbox(
                        focusColor: Color.fromARGB(255, 250, 248, 248),
                        value: roomSelection["Bathroom1"],
                        onChanged: (bool? newValue) {
                          setState(() {
                            roomSelection["Bathroom1"] = newValue!;
                            updateRemainingArea();
                            selectedRooms.add("Bathroom1");
                          });
                        },
                      ),
                      Text(' 2-',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Readex Pro',
                            color: Color.fromARGB(255, 250, 248, 248),
                            fontSize: 20,
                          )),
                      SizedBox(
                        width: 0.5,
                      ),
                      Checkbox(
                        focusColor: Color.fromARGB(255, 250, 248, 248),
                        value: roomSelection["Bathroom2"],
                        onChanged: (bool? newValue) {
                          setState(() {
                            roomSelection["Bathroom2"] = newValue!;
                            updateRemainingArea();
                            selectedRooms.add("Bathroom1");
                            selectedRooms.add("Bathroom2");
                          });
                        },
                      ),
                      Text(' 3-',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Readex Pro',
                            color: Color.fromARGB(255, 250, 248, 248),
                            fontSize: 20,
                          )),
                      SizedBox(
                        width: 0.5,
                      ),
                      Checkbox(
                        focusColor: Color.fromARGB(255, 250, 248, 248),
                        value: roomSelection["Bathroom3"],
                        onChanged: (bool? newValue) {
                          setState(() {
                            roomSelection["Bathroom3"] = newValue!;
                            updateRemainingArea();
                            selectedRooms.add("Bathroom1");
                            selectedRooms.add("Bathroom2");
                            selectedRooms.add("Bathroom3");
                          });
                        },
                      ),
                    ]),
                    Row(
                      children: [
                        Text(' - balcony =',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Text(' 1-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          focusColor: Color.fromARGB(255, 250, 248, 248),
                          value: roomSelection["Balcony1"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              roomSelection["Balcony1"] = newValue!;
                              updateRemainingArea();
                              selectedRooms.add("Balcony1");
                            });
                          },
                        ),
                        Text(' 2-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          focusColor: Color.fromARGB(255, 250, 248, 248),
                          value: roomSelection["Balcony2"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              roomSelection["Balcony2"] = newValue!;
                              updateRemainingArea();
                              selectedRooms.add("Balcony1");
                              selectedRooms.add("Balcony2");
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          ' - Kitchen = 1-',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Readex Pro',
                            color: Color.fromARGB(255, 250, 248, 248),
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 0.5),
                        Checkbox(
                          value: true, // Already checked
                          onChanged: null, // Disable the checkbox
                          activeColor: Color(
                              0xFF0F448E), // Set the color for the checkmark
                          checkColor:
                              Colors.white, // Set the color of the checkmark
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(' - store=',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Text(' 1-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          focusColor: Color.fromARGB(255, 250, 248, 248),
                          value: roomSelection["Store1"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              roomSelection["Store1"] = newValue!;
                              updateRemainingArea();
                              selectedRooms.add("Store1");
                            });
                          },
                        ),
                        Text(' 2-',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Readex Pro',
                              color: Color.fromARGB(255, 250, 248, 248),
                              fontSize: 20,
                            )),
                        SizedBox(
                          width: 0.5,
                        ),
                        Checkbox(
                          focusColor: Color.fromARGB(255, 250, 248, 248),
                          value: roomSelection["Store2"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              roomSelection["Store2"] = newValue!;
                              updateRemainingArea();
                              selectedRooms.add("Store1");
                              selectedRooms.add("Store2");
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          ' - GuestRoom = 1-',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Readex Pro',
                            color: Color.fromARGB(255, 250, 248, 248),
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 0.5),
                        Checkbox(
                          value: true, // Already checked
                          onChanged: null, // Disable the checkbox
                          activeColor: Color(
                              0xFF0F448E), // Set the color for the checkmark
                          checkColor:
                              Colors.white, // Set the color of the checkmark
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Color(0xFF0F448E),
                  fixedSize: Size(200, 70),
                  elevation: 3,
                ),
                onPressed: () {
                  // List<String> selectedRooms = roomSelection.entries
                  //     .where((entry) => entry.value == true)
                  //     .map((entry) => entry.key)
                  //     .toList();
                  // selectedRooms.add("Entrance");
                  // selectedRooms.add("LivingRoom1");
                  // selectedRooms.add("Kitchen1");
                  // selectedRooms.add("GuestRoom");

                  print(selectedRooms);
                  sendRoomSelection(totalArea, selectedRooms);
                },
                child: const Text(
                  textAlign: TextAlign.center,
                  'Generate ', // enforce constaint
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
