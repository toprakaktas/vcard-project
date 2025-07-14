import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  static const String routeName = 'scan';

  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Page')),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                label: Text('Capture'),
                icon: Icon(Icons.camera_alt_outlined),
              ),
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                label: Text('Gallery'),
                icon: Icon(Icons.photo_library_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      print(image.path);
    }
  }
}
