import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/contacts/pods/contact_pod.dart';
import 'package:companion/src/features/contacts/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class ContactsPage extends ConsumerWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsProvider = ref.watch(contactPodProvider);

    return SingleChildScrollView(
      child: VStack(
        [
          8.h.heightBox,
          HStack(
            [
              6.w.widthBox,
              VxTextField(
                borderType: VxTextFieldBorderType.roundLine,
                hint: "Search",
                textInputAction: TextInputAction.search,
                style: context.textTheme.labelLarge,
                onChanged: (str) {
                  // if (_debounce?.isActive ?? false) _debounce?.cancel();
                  // _debounce = Timer(const Duration(milliseconds: 500), () {
                  //   setState(() {
                  //     searchTerm = str;
                  //   });
                  // });
                },
              ).expand(),
              8.w.widthBox,
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.sort_outlined),
                iconAlignment: IconAlignment.end,
                label: "Sort By".text.make(),
              ),
            ],
            axisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.spaceBetween,
          ).pSymmetric(h: 16.w),
          8.h.heightBox,
          contactsProvider.when(
            data: (contacts) {
              if (contacts.isEmpty) {
                return "No Contacts Found..."
                    .text
                    .bodyLarge(context)
                    .slate400
                    .makeCentered()
                    .pOnly(top: 250.h);
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactTile(
                    contact: contacts[index],
                  );
                },
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => err.toString().text.make(),
          )
        ],
      ),
    );
  }
}
