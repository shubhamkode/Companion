import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactTile extends ConsumerWidget {
  final Contact contact;
  const ContactTile({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      isThreeLine: true,
      leading: Hero(
        tag: "Contact-${contact.id}",
        child: CircleAvatar(
          backgroundColor: Color(contact.color),
          radius: 20,
          child: contact.name[0].text.titleLarge(context).make(),
        ).pOnly(top: 2.h).onTap(() {
          context.pushRoute(
            ContactDetailsRoute(contact: contact),
          );
        }),
      ),
      contentPadding: EdgeInsets.only(left: 24.w, right: 20.w),
      title: Wrap(
        direction: Axis.vertical,
        spacing: -4,
        children: [
          contact.name.text.medium.make().onTap(() {
            context.pushRoute(
              ContactDetailsRoute(contact: contact),
            );
          }),
          contact.distributor.text
              .labelLarge(context)
              .color(Vx.stone600)
              .make()
              .pOnly(left: 1.w),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (contact.pims.isNotEmpty)
          //   (contact.pims[0].contact)
          //       .formatDigitPattern(digit: 5, pattern: " ")
          //       .text
          //       .make(),
          2.h.heightBox,
          RichText(
            text: TextSpan(
              text: "${contact.companies.length}",
              style: context.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text:
                      contact.companies.length > 1 ? " Companies" : " Company",
                  style: context.textTheme.labelLarge,
                )
              ],
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.call_outlined),
        onPressed: () async {
          await makePhoneCall(contact.pims[0].contact);
        },
      ),
    );
  }
}
