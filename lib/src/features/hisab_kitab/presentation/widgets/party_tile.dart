import 'dart:math';

import 'package:companion/src/features/hisab_kitab/domain/entity/hisab_kitab_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class PartyTile extends StatelessWidget {
  final PartyEntity party;

  const PartyTile({
    super.key,
    required this.party,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 0,
      contentPadding: EdgeInsets.only(
        left: 16.w,
        right: 4.w,
        top: 4.h,
        bottom: 4.h,
      ),
      leading: CircleAvatar(
        child: "PN".text.titleMedium(context).make(),
      ),
      title: Text(party.name),
      subtitle: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 0,
        children: [
          Icon(
            Icons.currency_rupee_outlined,
            color: true ? Vx.rose500 : Vx.emerald500,
            size: 12.sp,
          ),
          (123 * sqrt1_2)
              .numCurrency
              .text
              .color(
                true ? Vx.rose500 : Vx.emerald500,
              )
              .bodyMedium(context)
              .make(),
        ],
      ),
    );
  }
}
