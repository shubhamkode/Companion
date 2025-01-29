import 'package:companion/src/features/agent/presentation/notifiers/agent_details_notifier.dart';
import 'package:companion/src/features/agent/presentation/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AgentContactsCard extends ConsumerWidget {
  const AgentContactsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsProvider = ref.watch(
      agentDetailsNotifierProvider.select(
        (s) => s.whenData((a) => a.agent.contacts),
      ),
    );

    return contactsProvider.when(
      error: (err, stack) => SizedBox.shrink(),
      loading: () {
        return _buildCard(
          context,
          child: _buildLoading(context),
        );
      },
      data: (contacts) {
        if (contacts.isEmpty) {
          return SizedBox.shrink();
        }
        return _buildCard(
          context,
          child: ListView.builder(
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
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return ListTile(
          minTileHeight: 0,
          contentPadding: EdgeInsets.only(
            left: 16.w,
            bottom: 2.h,
            top: 2.h,
            right: 12.w,
          ),
          leading: CircleAvatar().shimmer(),
          title: VxSkeleton(
            height: 12.h,
            borderRadius: BorderRadius.circular(8.r),
          ).shimmer().pOnly(bottom: 8.h),
          subtitle: VxSkeleton(
            height: 8.h,
            borderRadius: BorderRadius.circular(8.r),
          ).shimmer().pOnly(right: context.percentWidth * 50),
        );
      },
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required Widget child,
  }) {
    return Card.filled(
      child: VStack(
        [
          "Contact Info".text.titleSmall(context).make().pOnly(left: 16.w),
          4.h.heightBox,
          child,
        ],
      ).pOnly(top: 12.h, bottom: 8.h),
    ).wFull(context).pSymmetric(h: 8.w);
  }
}
