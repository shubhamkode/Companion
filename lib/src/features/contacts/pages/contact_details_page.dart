import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/core/widgets/action_icon_button.dart';
import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies/repositories/company_repository.dart';
import 'package:companion/src/features/companies_to_contact/repositories/company_to_contact_repository.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/pages/contacts/new/sections/companies_select_section.dart';
import 'package:companion/src/features/contacts/pods/contact_pod.dart';
import 'package:companion/src/features/contacts/repositories/contact_repository.dart';
import 'package:companion/src/features/contacts/widgets/companies_disclosure.dart';
import 'package:companion/src/features/pims/models/pim_model.dart';
import 'package:companion/src/features/pims/repositories/pim_repository.dart';
import 'package:companion/src/utils/color_ext.dart';
import 'package:companion/src/utils/helpers.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class ContactDetailsPage extends ConsumerWidget {
  final String contactId;
  const ContactDetailsPage({
    super.key,
    required this.contactId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(contactDetailsProvider);
        },
        child: _buildBody(context),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar();
  }

  _buildBody(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final contactDetailPod = ref.watch(contactDetailsProvider(contactId));
        return contactDetailPod.when(
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            error: (err, stack) => err.toString().text.makeCentered(),
            data: (details) {
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: VStack(
                  [
                    _buildDescription(context, contact: details.contact),
                    _buildActions(context, details: details),
                    _buildPimsInfo(context, pims: details.contactPims),
                    _buildCompanies(context,
                        relatedCompanies: details.relatedCompanies),
                  ],
                  spacing: 30.h,
                ).pOnly(left: 24.w, right: 24.w, top: 15.h),
              );
            });
      },
    );
  }

  _buildDescription(
    BuildContext context, {
    required ContactModel contact,
  }) {
    return VStack(
      [
        VxBox(
          child: contact.name[0].text
              .displayLarge(context)
              .color(Vx.white)
              .makeCentered(),
        )
            .make()
            .circle(
              radius: 160,
              backgroundColor: contact.hexColor.colorFromHex(),
            )
            .hero('Contact-${contact.id}'),
        24.h.heightBox,
        contact.name.text.headlineMedium(context).start.make(),
        4.h.heightBox,
        contact.distributor.text.bodyLarge(context).make(),
      ],
    );
  }

  _buildActions(
    BuildContext context, {
    required ContactDetailModel details,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return HStack(
          [
            ActionIconButton(
              onPressed: () async {
                if (await confirm(
                  context,
                  canPop: true,
                  textOK: Text('Sure'),
                  textCancel: Text("Cancel"),
                  content: Text("Contact will be deleted Forever"),
                  title: Text("Delete Contact").wFull(context),
                )) {
                  await ref
                      .read(contactPodProvider.notifier)
                      .deleteContact(details.contact);
                  if (context.mounted) {
                    context.maybePop();
                  }
                }
              },
              icon: Icons.delete_outline_rounded,
              actionText: "Delete",
            ),
            ActionIconButton(
              onPressed: () async {
                final relations = (await ref
                        .read(companyToContactRepositoryProvider)
                        .readAll())
                    .filter((rel) => rel.contactId == contactId)
                    .toList();

                ref
                    .read(multiSelectCompanyNotifier.notifier)
                    .setSelectedCompanies(
                      relations.builder((rel) => rel.companyId),
                    );

                if (context.mounted) {
                  await context
                      .pushRoute<bool>(
                    EditContactRoute(
                      contact: details.contact,
                      contactPims: details.contactPims,
                      relations: relations,
                    ),
                  )
                      .then(
                    (val) {
                      if (val == true) {
                        ref.invalidate(contactDetailsProvider);
                      }
                    },
                  );
                }
              },
              icon: Icons.edit_note_outlined,
              actionText: "Edit",
            ),
            ActionIconButton(
              onPressed: () async {
                final PimModel primaryPim = details.contactPims[0];
                await makePhoneCall(primaryPim.digits);
              },
              icon: Icons.call_outlined,
              actionText: "Call",
            ),
          ],
          spacing: 40.w,
          crossAlignment: CrossAxisAlignment.center,
        );
      },
    );
  }

  _buildPimsInfo(
    BuildContext context, {
    required List<PimModel> pims,
  }) {
    if (pims.isEmpty) {
      return "No PIMs".text.bodyLarge(context).slate400.make();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        "Contacts".text.make().pOnly(left: 4.w),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: pims.length,
          reverse: true,
          itemBuilder: (context, index) {
            return PimTile(
              pim: pims[index],
              isPrimary: index == pims.length - 1,
            );
          },
        ),
      ],
    );
  }

  _buildCompanies(
    BuildContext context, {
    required List<CompanyModel> relatedCompanies,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            relatedCompanies.isEmpty
                ? 'No Companies'
                    .text
                    .bodyLarge(context)
                    .slate400
                    .makeCentered()
                    .pOnly(top: 24.h)
                : CompaniesDisclosure(
                    companies: relatedCompanies,
                  )
          ],
        );
      },
    );
  }
}

class PimTile extends StatelessWidget {
  final PimModel pim;
  final bool isPrimary;
  const PimTile({
    super.key,
    required this.pim,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      title: pim.digits
          .formatDigitPattern(digit: 5, pattern: " ")
          .text
          .medium
          .make(),
      subtitle: (isPrimary ? "Primary" : "Others")
          .text
          .bodyMedium(context)
          .color(context.colors.onSurface.withAlpha(150))
          .make(),
      leading: Icon(Icons.call_outlined),
      onTap: () async {
        await makePhoneCall(pim.digits);
      },
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
  }
}

class ContactDetailModel {
  final ContactModel contact;
  final List<PimModel> contactPims;
  final List<CompanyModel> relatedCompanies;

  ContactDetailModel({
    required this.contact,
    required this.contactPims,
    required this.relatedCompanies,
  });
}

final contactDetailsProvider =
    FutureProvider.family<ContactDetailModel, String>(
  (ref, contactId) async {
    final repo = ref.read(contactRepositoryProvider);
    final contact = (await repo.read(contactId))!;

    final pims =
        (await ref.read(pimRepositoryProvider).readAll()).sortedBy((a, b) {
      return -DateTime.parse(b.created).compareTo(DateTime.parse(a.created));
    });
    final contactPims =
        pims.filter((pim) => pim.contactId == contact.id).toList();

    final relations =
        await (ref.read(companyToContactRepositoryProvider)).readAll();

    final companyRelationIds = relations
        .filter((rel) => rel.contactId == contact.id)
        .toList()
        .builder((a) => a.companyId);

    final companies = await (ref.read(companyRepositoryProvider)).readAll();

    final relatedCompanies =
        companies.filter((cmp) => companyRelationIds.contains(cmp.id)).toList();

    return ContactDetailModel(
      contact: contact,
      contactPims: contactPims,
      relatedCompanies: relatedCompanies,
    );
  },
);
