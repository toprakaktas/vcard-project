import 'package:path/path.dart' as P;
import 'package:sqflite/sqflite.dart';
import 'package:vcard/models/contact_model.dart';

class DBHelper {
  final String _createTableContact = '''create table $tableContact(
  $tblContactColId integer primary key autoincrement,
  $tblContactColName text,
  $tblContactColMobile text,
  $tblContactColEmail text,
  $tblContactColProfession text,
  $tblContactColCompany text,
  $tblContactColWebsite text,
  $tblContactColAddress text,
  $tblContactColImage text,
  $tblContactColFavorite integer)''';

  Future<Database> _open() async {
    final root = await getDatabasesPath();
    final dbPath = P.join(root, 'contact.db');
    return openDatabase(
      dbPath,
      version: 2,
      onCreate: (db, version) {
        db.execute(_createTableContact);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1) {
          await db.execute(
            'alter table $tableContact rename to ${'contact_old'}',
          );
          await db.execute(_createTableContact);
          final rows = await db.query('contact_old');
          for (var row in rows) {
            await db.insert(tableContact, row);
          }
          await db.execute('drop table if exists ${'contact_old'}');
        }
      },
    );
  }

  Future<int> insertContact(ContactModel contact) async {
    final db = await _open();
    return db.insert(tableContact, contact.toMap());
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await _open();
    final mapList = await db.query(tableContact);
    return List.generate(
      mapList.length,
      (index) => ContactModel.fromMap(mapList[index]),
    );
  }

  Future<int> deleteContact(int id) async {
    final db = await _open();
    return db.delete(
      tableContact,
      where: '$tblContactColId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateFavorite(int id, int value) async {
    final db = await _open();
    return db.update(
      tableContact,
      {tblContactColFavorite: value},
      where: '$tblContactColId = ?',
      whereArgs: [id],
    );
  }
}
