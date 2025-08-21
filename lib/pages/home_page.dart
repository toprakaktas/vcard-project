import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard/pages/scan_page.dart';
import 'package:vcard/providers/contact_provider.dart';
import 'package:vcard/utils/helper_functions.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact List')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(ScanPage.routeName);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            _fetchData();
          },
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
      body: Consumer<ContactProvider>(
        builder:
            (context, provider, child) => ListView.builder(
              itemCount: provider.contactList.length,
              itemBuilder: (context, index) {
                final contact = provider.contactList[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: EdgeInsets.only(right: 20),
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete_outline, color: Colors.white),
                  ),
                  confirmDismiss: _showConfirmationDialog,
                  onDismissed: (_) async {
                    await provider.deleteContact(contact.id);
                    showMessage(context, 'Contact deleted!');
                  },
                  child: ListTile(
                    title: Text(contact.name),
                    trailing: IconButton(
                      onPressed: () {
                        provider.updateFavorite(contact);
                      },
                      icon: Icon(
                        contact.favorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(DismissDirection direction) {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Delete Contact'),
            content: Text('Are you sure you want to delete this contact?'),
            actions: [
              OutlinedButton(
                onPressed: () {
                  context.pop(false);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  context.pop(true);
                },
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  void _fetchData() {
    switch (_selectedIndex) {
      case 0:
        Provider.of<ContactProvider>(context, listen: false).getAllContacts();
        break;
      case 1:
        Provider.of<ContactProvider>(
          context,
          listen: false,
        ).getFavoriteContacts();
        break;
    }
  }
}
