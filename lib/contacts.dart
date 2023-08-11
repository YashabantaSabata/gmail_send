import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ListContact extends StatefulWidget {
  const ListContact({Key? key}) : super(key: key);

  @override
  _ListContactState createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  _getContacts() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      final Iterable<Contact> contactsData = await ContactsService.getContacts();
      setState(() {
        contacts = contactsData.toList();
      });
    } else {
      print("Permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          final name = contact.displayName;
          final phone = contact.phones?.isEmpty ?? true
              ? ''
              : contact.phones!.first.value;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(name![0], style: TextStyle(color: Colors.white)),
            ),
            title: Text(name),
            subtitle: Text(phone!),
          );
        },
      ),
    );
  }
}
