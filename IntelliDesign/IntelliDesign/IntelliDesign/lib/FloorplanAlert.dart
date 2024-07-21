import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

class FloorplanAlert extends StatelessWidget {
  final String imageUrl;

  FloorplanAlert({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Generated Floorplan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(imageUrl),
          SizedBox(height: 16),
          Text('This is your floorplan!'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the alert
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
