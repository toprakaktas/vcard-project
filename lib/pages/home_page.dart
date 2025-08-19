import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard/pages/scan_page.dart';
import 'package:vcard/providers/contact_provider.dart';

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
    Provider.of<ContactProvider>(context, listen: false);
    super.didChangeDependencies();
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
                return ListTile(
                  title: Text(contact.name),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      contact.favorite ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }
}
