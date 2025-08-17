import 'package:flutter/material.dart';
import 'package:vcard/models/contact_model.dart';
import 'package:vcard/utils/constants.dart';

class FormPage extends StatefulWidget {
  static const String routeName = 'form';
  final ContactModel contactModel;

  const FormPage({super.key, required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final professionController = TextEditingController();
  final companyController = TextEditingController();
  final websiteController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.contactModel.name;
    mobileController.text = widget.contactModel.mobile;
    addressController.text = widget.contactModel.address;
    companyController.text = widget.contactModel.company;
    emailController.text = widget.contactModel.email;
    professionController.text = widget.contactModel.profession;
    websiteController.text = widget.contactModel.website;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactModel.name),
        actions: [
          IconButton(onPressed: saveContact, icon: Icon(Icons.save_as)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Contact Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrorMessage;
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: mobileController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrorMessage;
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrorMessage;
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: professionController,
              decoration: InputDecoration(labelText: 'Profession'),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: companyController,
              decoration: InputDecoration(labelText: 'Company'),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.url,
              controller: websiteController,
              decoration: InputDecoration(labelText: 'Website'),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) {
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    professionController.dispose();
    companyController.dispose();
    websiteController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void saveContact() async {
    if (_formKey.currentState!.validate()) {
      widget.contactModel.name = nameController.text;
      widget.contactModel.mobile = mobileController.text;
      widget.contactModel.email = emailController.text;
      widget.contactModel.profession = professionController.text;
      widget.contactModel.company = companyController.text;
      widget.contactModel.website = websiteController.text;
      widget.contactModel.address = addressController.text;
    }
    // TODO: Save to the db
  }
}
