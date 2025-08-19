import 'package:flutter/foundation.dart';
import 'package:vcard/db/db_helper.dart';
import 'package:vcard/models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];
  final db = DBHelper();

  Future<int> insertContact(ContactModel contact) async {
    final rowId = await db.insertContact(contact);
    contact.id = rowId;
    contactList.add(contact);
    notifyListeners();
    return rowId;
  }

  Future<void> getAllContacts() async {
    contactList = await db.getAllContacts();
    notifyListeners();
  }
}
