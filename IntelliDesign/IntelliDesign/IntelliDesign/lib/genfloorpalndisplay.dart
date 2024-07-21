import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class genfloorpalndisplay extends StatefulWidget {
  static const String screenRoute = 'genfloorpalndisplay';
  final String imgurl;
  const genfloorpalndisplay({
    Key? key,
    required this.imgurl,
  }) : super(key: key);
  @override
  _genfloorpalndisplayState createState() => _genfloorpalndisplayState();
}

class _genfloorpalndisplayState extends State<genfloorpalndisplay> {
  late final String assetPath = widget.imgurl;
  Future<void> _downloadImage() async {
    try {
      final imageBytes = await http.readBytes(Uri.parse(assetPath));
      final result =
          await ImageGallerySaver.saveImage(Uint8List.fromList(imageBytes));
      if (result['isSuccess']) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Image Downloaded'),
            content: Text('The image has been saved to your gallery.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Error saving image: ${result['errorMessage']}');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(214, 243, 244, 247),
      appBar: AppBar(
        title: Text(
          'Floorplan design',
          style: TextStyle(
            color: Color.fromARGB(246, 252, 252, 253),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 57, 92, 142),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.network(
            assetPath,
            height: 450,
            width: 400,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              backgroundColor: Color(0xFF0F448E),
              fixedSize: Size(270, 70),
              elevation: 3,
            ),
            onPressed: _downloadImage,
            child: const Text(
              textAlign: TextAlign.center,
              'Download Image', // enforce constaint
              style: TextStyle(
                fontFamily: 'Readex Pro',
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 0,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
