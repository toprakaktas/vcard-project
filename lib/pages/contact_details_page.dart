import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vcard/models/contact_model.dart';
import 'package:vcard/providers/contact_provider.dart';
import 'package:vcard/utils/helper_functions.dart';

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
                      ListTile(
                        title: Text(contact.mobile),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                callContact(contact.mobile);
                              },
                              icon: Icon(Icons.call),
                            ),
                            IconButton(
                              onPressed: () {
                                smsContact(contact.mobile);
                              },
                              icon: Icon(Icons.sms),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(contact.email),
                        trailing: IconButton(
                          onPressed: () {
                            mailContact(contact.email);
                          },
                          icon: Icon(Icons.email),
                        ),
                      ),
                      ListTile(
                        title: Text(contact.website),
                        trailing: IconButton(
                          onPressed: () {
                            websiteContact(contact.website);
                          },
                          icon: Icon(Icons.language),
                        ),
                      ),
                      ListTile(
                        title: Text(contact.address),
                        trailing: IconButton(
                          onPressed: () {
                            addressContact(contact.address);
                          },
                          icon: Icon(Icons.location_on),
                        ),
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

  void callContact(String mobile) async {
    final url = 'tel:$mobile';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMessage(context, 'Cannot call this phone number!');
    }
  }

  void smsContact(String mobile) async {
    final url = 'sms:$mobile';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMessage(context, 'Cannot send sms to this phone number!');
    }
  }

  void mailContact(String email) async {
    final url = Uri(scheme: 'mailto', path: email);
    await launchUrl(url);
  }

  void websiteContact(String website) async {
    final url = Uri(scheme: 'https', path: website);
    await launchUrl(url);
  }

  void addressContact(String address) async {
    final url = 'geo:0,0?q=$address';
    await launchUrlString(url);
  }
}
