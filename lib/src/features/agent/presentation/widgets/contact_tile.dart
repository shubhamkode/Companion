import 'package:companion/src/core/utils/make_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactTile extends StatelessWidget {
  final String contact;
  final bool isPrimary;
  const ContactTile({
    super.key,
    required this.contact,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await makeCallTo(contact);
      },
      leading: isPrimary ? Icon(Icons.call_outlined) : SizedBox(),
      minTileHeight: 0,
      contentPadding: EdgeInsets.only(
        left: 16.w,
        bottom: 2.h,
        top: 2.h,
        right: 12.w,
      ),
      title: contact.formatDigitPattern(digit: 5, pattern: ' ').text.make(),
      subtitle:
          (isPrimary ? "Primary" : "Other").text.labelMedium(context).make(),
    );
  }
}
