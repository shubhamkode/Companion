import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/companies/models/company.dart';
import 'package:companion/src/features/companies/pods/companies_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

// Future<Company?> getCompanyById(final String id) async {
//   return Hive.box<Company>("companies").get(
//     id,
//     defaultValue: null,
//   );
// }

@RoutePage()
class CompanyDetailsPage extends ConsumerStatefulWidget {
  final Company company;
  const CompanyDetailsPage({
    super.key,
    required this.company,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends ConsumerState<CompanyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: "View Company".text.make(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: VStack(
        [
          30.h.heightBox,
          Hero(
            tag: "Company-${widget.company.id}",
            child: CircleAvatar(
              backgroundColor: Color(widget.company.color),
              radius: 80,
              child: widget.company.name[0].text.displayLarge(context).make(),
            ),
          ),
          24.h.heightBox,
          widget.company.name.text.headlineMedium(context).make(),
          1.h.heightBox,
          widget.company.description.text.bodyLarge(context).make(),
          16.h.heightBox,
          HStack(
            [
              Column(
                children: [
                  IconButton.filledTonal(
                    onPressed: () async {
                      await ref
                          .read(companiesPodProvider.notifier)
                          .deleteCompany(widget.company.id);
                      if (mounted) {
                        context.back();
                      }
                    },
                    icon: Icon(
                      Icons.delete_outline_rounded,
                    ).p(8),
                  ),
                  4.h.heightBox,
                  "Delete".text.titleSmall(context).medium.make(),
                ],
              ),
              48.w.widthBox,
              Column(
                children: [
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit_note_rounded,
                    ).p(8),
                  ),
                  4.h.heightBox,
                  "Edit".text.titleSmall(context).medium.make(),
                ],
              ),
              // 48.w.widthBox,
            ],
            axisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.center,
            crossAlignment: CrossAxisAlignment.center,
          ),
          24.h.heightBox,
          Card(
            elevation: 0,
            child: VStack(
              [
                "Contacts".text.labelLarge(context).make(),
              ],
            ).pSymmetric(v: 8.h, h: 16.w),
          ).wFull(context).pSymmetric(h: 18.w),
        ],
        crossAlignment: CrossAxisAlignment.center,
      ).wFull(context),
    );
  }
}
