import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/core/widgets/action_icon_button.dart';
import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies/pods/company_pod.dart';
import 'package:companion/src/features/companies/repositories/company_repository.dart';
import 'package:companion/src/features/companies_to_contact/repositories/company_to_contact_repository.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/repositories/contact_repository.dart';
import 'package:companion/src/features/contacts/widgets/contact_tile.dart';
import 'package:companion/src/utils/color_ext.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class CompanyDetailsPage extends ConsumerWidget {
  final String companyId;
  const CompanyDetailsPage({
    super.key,
    required this.companyId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(companyDetailsProvider);
        },
        child: _buildBody(context),
      ),
    );
  }

  _buildAppBar() {
    return AppBar();
  }

  _buildBody(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final companyDetailsPod = ref.watch(companyDetailsProvider(companyId));

        return companyDetailsPod.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (err, stack) => err.toString().text.makeCentered(),
          data: (companyDetails) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: VStack(
                [
                  _buildDescription(
                    context,
                    company: companyDetails.company,
                  ),
                  // 30.h.heightBox,
                  _buildAction(
                    context,
                    company: companyDetails.company,
                  ),
                  // 30.h.heightBox,
                  _buildContacts(
                    context,
                    contacts: companyDetails.relatedContacts,
                  ),
                ],
                spacing: 30.h,
              ).pOnly(left: 24.w, right: 24.w, top: 15.h),
            );
          },
        );
      },
    );
  }

  Widget _buildDescription(
    BuildContext context, {
    required CompanyModel company,
  }) {
    return VStack(
      [
        VxBox(
          child: company.name[0].text
              .displayLarge(context)
              .color(Vx.white)
              .makeCentered(),
        )
            .make()
            .circle(
              radius: 160,
              backgroundColor: company.hexColor.colorFromHex(),
            )
            .hero('Company-${company.id}'),
        24.h.heightBox,
        company.name.text.headlineMedium(context).start.make(),
        4.h.heightBox,
        company.description.text.bodyLarge(context).lineHeight(1.1).make(),
      ],
    );
  }

  _buildAction(
    BuildContext context, {
    required CompanyModel company,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return HStack(
          [
            ActionIconButton(
              onPressed: () async {
                if (await confirm(
                  context,
                  content: Text("Company will be deleted forever"),
                  title: Text("Delete Company").wFull(context),
                  textOK: Text("Sure"),
                  textCancel: Text("Cancel"),
                )) {
                  await ref.read(companyPodProvider.notifier).delete(company);
                  if (context.mounted) {
                    context.back();
                  }
                }
              },
              icon: Icons.delete_outline_rounded,
              actionText: "Delete",
            ),
            ActionIconButton(
              onPressed: () async {
                await context.pushRoute(
                  EditCompanyRoute(company: company),
                );
              },
              icon: Icons.edit_note_outlined,
              actionText: "Edit",
            ),
          ],
          spacing: 40.w,
          crossAlignment: CrossAxisAlignment.center,
        );
      },
    );
  }

  _buildContacts(
    BuildContext context, {
    required List<ContactModel> contacts,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return VStack(
          [
            "Contacts".text.labelLarge(context).make().pOnly(left: 4.w),
            12.h.heightBox,
            (contacts.isEmpty)
                ? "No Contacts Found..."
                    .text
                    .bodyLarge(context)
                    .slate400
                    .makeCentered()
                    .pOnly(top: 10.h)
                : ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      return ContactTile(
                        contact: contacts[index],
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                        heroEnabled: false,
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(
                      height: 2.h,
                    ),
                  ),
          ],
        );
      },
    ).wFull(context);
  }
}

class CompanyDetailsView {
  final CompanyModel company;
  final List<ContactModel> relatedContacts;

  CompanyDetailsView({
    required this.company,
    required this.relatedContacts,
  });
}

final companyDetailsProvider =
    FutureProvider.family<CompanyDetailsView, String>(
  (ref, companyId) async {
    final repo = ref.read(companyRepositoryProvider);
    final company = (await repo.read(companyId))!;

    final relatedContactIds =
        (await ref.read(companyToContactRepositoryProvider).readAll())
            .filter((ele) => ele.companyId == companyId)
            .toList()
            .builder((rel) => rel.contactId);

    final relatedContacts =
        (await ref.read(contactRepositoryProvider).readAll())
            .filter((cnt) => relatedContactIds.contains(cnt.id))
            .toList();

    return CompanyDetailsView(
      company: company,
      relatedContacts: relatedContacts,
    );
  },
);
