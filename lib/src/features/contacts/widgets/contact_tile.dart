import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/pims/repositories/pim_repository.dart';
import 'package:companion/src/utils/color_ext.dart';
import 'package:companion/src/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactTile extends ConsumerWidget {
  final ContactModel contact;
  final EdgeInsets? contentPadding;
  final bool heroEnabled;
  final VoidCallback? onPop;

  const ContactTile({
    super.key,
    this.contentPadding,
    required this.contact,
    this.heroEnabled = true,
    this.onPop,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: HeroMode(
        enabled: heroEnabled,
        child: Hero(
          tag: "Contact-${contact.id}",
          child: CircleAvatar(
            backgroundColor: contact.hexColor.colorFromHex(),
            radius: 20,
            child: contact.name[0].text.titleLarge(context).make(),
          ).pOnly(top: 2.h).onTap(() {
            context
                .pushRoute(
              ContactDetailsRoute(contactId: contact.id),
            )
                .then((val) {
              if (onPop != null) {
                onPop!();
              }
            });
          }),
        ),
      ),
      contentPadding: contentPadding ??
          EdgeInsets.only(
            left: 24.w,
            right: 20.w,
            top: 10.h,
          ),
      title: Wrap(
        direction: Axis.vertical,
        spacing: -2,
        children: [
          contact.name.text.medium.make().onTap(() {
            context.pushRoute(
              ContactDetailsRoute(contactId: contact.id),
            );
          }),
          contact.distributor.text
              .labelLarge(context)
              .color(context.colors.inverseSurface.withAlpha(220))
              .make()
              .pOnly(left: 1.w),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.call_outlined),
        onPressed: () async {
          final pims = await ref.read(pimRepositoryProvider).readAll();
          final primaryPim =
              pims.firstWhere((pim) => pim.contactId == contact.id);
          await makePhoneCall(primaryPim.digits);
        },
      ),
    );
  }
}
