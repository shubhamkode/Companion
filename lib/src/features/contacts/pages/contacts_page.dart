import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/widgets/search_field.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/pods/contact_pod.dart';
import 'package:companion/src/features/contacts/widgets/contact_tile.dart';
import 'package:companion/src/features/contacts/widgets/contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class ContactsPage extends ConsumerStatefulWidget {
  const ContactsPage({super.key});

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  late final SearchController searchController;

  @override
  void initState() {
    super.initState();
    searchController = SearchController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactsProvider = ref.watch(contactPodProvider);

    return contactsProvider.when(
      loading: () => CircularProgressIndicator().centered(),
      error: (err, stack) => err.toString().text.makeCentered(),
      data: (contacts) {
        return VStack(
          [
            SearchField<ContactModel>(
              hintEmpty: "No Contacts Found",
              hintText: "Search Contacts",
              searchController: searchController,
              suggestionsBuilder: (context, controller) {
                if (controller.text.isEmpty) {
                  return [];
                }
                final filteredContacts = contacts
                    .filter(
                      (contact) => contact.name.toLowerCase().contains(
                            controller.text.toLowerCase(),
                          ),
                    )
                    .toList();

                return filteredContacts.builder(
                  (cnt) => ContactTile(
                    contact: cnt,
                    onPop: () {
                      searchController.closeView("");
                    },
                  ),
                );
              },
            ),
            ContactsList(
              contacts: contacts,
              onRefresh: () async {
                ref.invalidate(contactPodProvider);
              },
            ).expand(),
          ],
          spacing: 8.h,
        );
      },
    );
  }
}
