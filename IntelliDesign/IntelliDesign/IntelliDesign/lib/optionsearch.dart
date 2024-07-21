import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart' show rootBundle;

class optionsearch extends StatefulWidget {
  static const String screenRoute = 'optionsearch';
  final double housearea;

  const optionsearch({
    Key? key,
    required this.housearea,
  }) : super(key: key);

  @override
  _optionsearchState createState() => _optionsearchState();
}

class _optionsearchState extends State<optionsearch> {
  late Future<List<String>> imageNames;

  @override
  void initState() {
    super.initState();
    imageNames = fetchImageNames(widget.housearea);
  }

  Future<List<String>> fetchImageNames(double areaValue) async {
    var url = Uri.parse(
        'http://10.0.2.2:5000/search_area'); //for emulator  http://10.0.2.2:5000
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({'Area': areaValue}),
    );

    if (response.statusCode == 200) {
      List<dynamic> names = json.decode(response.body);
      return names.cast<String>();
    } else {
      throw Exception('Failed to load image names');
    }
  }

  Future<Uint8List> loadImageBytes(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      appBar: AppBar(
        title: Text(
          'house designs',
          style: TextStyle(
            color: Color.fromARGB(246, 252, 252, 253),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 57, 92, 142),
      ),
      body: FutureBuilder<List<String>>(
        future: imageNames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  String assetPath = 'assets/' + snapshot.data![index] + '.jpg';
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Image.asset(assetPath, fit: BoxFit.cover),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Download'),
                                onPressed: () async {
                                  Uint8List imageBytes =
                                      await loadImageBytes(assetPath);
                                  final result =
                                      await ImageGallerySaver.saveImage(
                                          imageBytes);
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Image.asset(assetPath, fit: BoxFit.cover),
                  );
                },
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
