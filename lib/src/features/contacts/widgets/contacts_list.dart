import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          .color(
            context.colors.onSurface.withAlpha(200),
          )
          .makeCentered();
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 10.h, top: 0.h),
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
