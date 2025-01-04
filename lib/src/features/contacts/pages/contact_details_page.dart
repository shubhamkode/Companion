import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/companies/models/company.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/pods/contact_pod.dart';
import 'package:companion/utils.dart';
import 'package:disclosure/disclosure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

// Future<Contact?> getCompanyById(final String id) async {
//   return Hive.box<i
//     id,
//     defaultValue: null,
//   );
// }

@RoutePage()
class ContactDetailsPage extends ConsumerStatefulWidget {
  final Contact contact;
  const ContactDetailsPage({
    super.key,
    required this.contact,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContactDetailsPageState();
}

class _ContactDetailsPageState extends ConsumerState<ContactDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: "View Contact".text.make(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: VStack(
        [
          30.h.heightBox,
          Hero(
            tag: 'Contact-${widget.contact.id}',
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Color(widget.contact.color),
              child: widget.contact.name[0].text.displayLarge(context).make(),
            ),
          ),
          24.h.heightBox,
          widget.contact.name.text.headlineMedium(context).make(),
          1.h.heightBox,
          16.h.heightBox,
          HStack(
            [
              Column(
                children: [
                  IconButton.filledTonal(
                    onPressed: () async {
                      context.back();

                      await ref
                          .read(contactPodProvider.notifier)
                          .deleteContact(widget.contact);
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
              48.w.widthBox,
              Column(
                children: [
                  IconButton.filledTonal(
                    onPressed: () async {
                      await makePhoneCall(widget.contact.pims[0].contact);
                    },
                    icon: Icon(
                      Icons.call_outlined,
                    ).p(8),
                  ),
                  4.h.heightBox,
                  "Call".text.titleSmall(context).medium.make(),
                ],
              ),
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
                "Contact Info".text.labelLarge(context).make(),
                8.h.heightBox,
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.contact.pims.length,
                  itemBuilder: (context, index) {
                    final pim = widget.contact.pims[index];
                    return ListTile(
                      // leading:
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      title: pim.contact
                          .formatDigitPattern(digit: 5, pattern: " ")
                          .text
                          .medium
                          .make(),
                      subtitle: (index == 0 ? "Primary" : "Others")
                          .text
                          .bodyMedium(context)
                          .color(context.colors.onSurface.withAlpha(150))
                          .make(),
                      leading: Icon(Icons.call_outlined),
                      onTap: () async {
                        await makePhoneCall(pim.contact);
                      },
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                    );
                  },
                ),
              ],
            ).pSymmetric(v: 16.h, h: 12.w),
          ).wFull(context).pSymmetric(h: 18.w),
          20.h.heightBox,
          Card(
            elevation: 0,
            child: VStack([
              "Companies Info".text.labelLarge(context).make(),
              8.h.heightBox,
              CompaniesDisclosure(
                companies: widget.contact.companies,
              ),
            ]).pSymmetric(v: 16.h, h: 12.w),
          ).wFull(context).pSymmetric(h: 18.w),
          12.h.heightBox,
        ],
        crossAlignment: CrossAxisAlignment.center,
      ).wFull(context),
    );
  }
}

class CompaniesDisclosure extends HookConsumerWidget {
  final List<Company> companies;
  const CompaniesDisclosure({
    super.key,
    required this.companies,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Disclosure(
      wrapper: (state, child) {
        return Card.outlined(
          // clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
          // borderRadius: BorderRadius.circular(10),
          child: child,
        );
      },
      header: const DisclosureButton(
        child: ListTile(
          title: Text('Dealing Companies'),
          trailing: DisclosureIcon(),
        ),
      ),
      child: DisclosureView(
        padding: EdgeInsets.all(15.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: companies.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(companies[index].color),
                child: companies[index].name[0].text.titleLarge(context).make(),
              ),
              title: companies[index].name.text.make(),
            );
          },
        ),
      ),
    );
  }
}
