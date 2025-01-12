import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactsList extends StatelessWidget {
  final List<ContactModel> contacts;
  final RefreshCallback onRefresh;
  const ContactsList(
      {super.key, required this.contacts, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return "No Contacts Found..."
          .text
          .bodyLarge(context)
          .slate400
          .makeCentered();
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactTile(
            contact: contacts[index],
          );
        },
      ),
    );
  }
}
