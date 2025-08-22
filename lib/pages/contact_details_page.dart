import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcard/models/contact_model.dart';
import 'package:vcard/providers/contact_provider.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = 'details';
  final int id;

  const ContactDetailsPage({super.key, required this.id});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late int id;

  @override
  void initState() {
    id = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Details')),
      body: Consumer<ContactProvider>(
        builder:
            (context, provider, child) => FutureBuilder<ContactModel>(
              future: provider.getContactById(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final contact = snapshot.data!;
                  return ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: [
                      Image.file(
                        File(contact.image),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load contact'));
                }
                return const Center(child: Text('Please wait while loading'));
              },
            ),
      ),
    );
  }
}
