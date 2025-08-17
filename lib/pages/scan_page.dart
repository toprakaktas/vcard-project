import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcard/models/contact_model.dart';
import 'package:vcard/pages/form_page.dart';
import 'package:vcard/utils/constants.dart';
import 'package:vcard/widgets/drag_target_item.dart';
import 'package:vcard/widgets/line_item.dart';

class ScanPage extends StatefulWidget {
  static const String routeName = 'scan';

  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanned = false;
  List<String> lines = [];
  String name = '',
      mobile = '',
      email = '',
      address = '',
      company = '',
      profession = '',
      website = '',
      image = '';

  void createContact() {
    final contact = ContactModel(
      name: name,
      mobile: mobile,
      email: email,
      address: address,
      company: company,
      profession: profession,
      website: website,
      image: image,
    );
    context.goNamed(FormPage.routeName, extra: contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Page'),
        actions: [
          IconButton(
            onPressed: image.isEmpty ? null : createContact,
            icon: Icon(Icons.arrow_forward, color: Colors.black),
          ),
        ],
      ),
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
          if (isScanned)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DragTargetItem(
                      property: ContactProperties.name,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.mobile,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.email,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.profession,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.company,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.website,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.address,
                      onDrop: getPropertyValue,
                    ),
                  ],
                ),
              ),
            ),
          Wrap(children: lines.map((line) => LineItem(line: line)).toList()),
        ],
      ),
    );
  }

  void getImage(ImageSource source) async {
    final imageFile = await ImagePicker().pickImage(source: source);
    if (imageFile != null) {
      setState(() {
        image = imageFile.path;
      });
      EasyLoading.show(status: 'Please wait while getting information');
      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );
      final recognizedText = await textRecognizer.processImage(
        InputImage.fromFilePath(imageFile.path),
      );
      EasyLoading.dismiss();
      final tempList = <String>[];
      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          tempList.add(line.text);
        }
      }
      setState(() {
        lines = tempList;
      });
    }
    isScanned = true;
  }

  getPropertyValue(String property, String value) {
    switch (property) {
      case ContactProperties.name:
        name = value;
        break;
      case ContactProperties.mobile:
        mobile = value;
        break;
      case ContactProperties.email:
        email = value;
        break;
      case ContactProperties.profession:
        profession = value;
        break;
      case ContactProperties.company:
        company = value;
        break;
      case ContactProperties.website:
        website = value;
        break;
      case ContactProperties.address:
        address = value;
        break;
    }
  }
}
