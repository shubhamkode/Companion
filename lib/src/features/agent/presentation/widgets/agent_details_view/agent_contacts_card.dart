import 'package:companion/src/features/agent/presentation/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AgentContactsCard extends StatelessWidget {
  final List<String> contacts;
  const AgentContactsCard({
    super.key,
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return SizedBox();
    }
    return Card.filled(
      child: VStack(
        [
          "Contact Info".text.titleSmall(context).make().pOnly(left: 16.w),
          4.h.heightBox,
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return ContactTile(
                contact: contacts[index],
                isPrimary: index == 0,
              );
            },
          ),
        ],
      ).pOnly(top: 12.h, bottom: 8.h),
    ).wFull(context).pSymmetric(h: 8.w);
  }
}
