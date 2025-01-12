import 'dart:async';

import 'package:companion/src/features/companies/pods/company_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class FullScreenCompanySelector extends ConsumerStatefulWidget {
  const FullScreenCompanySelector({
    super.key,
  });

  @override
  ConsumerState<FullScreenCompanySelector> createState() =>
      _FullScreenCompanySelectorState();
}

class _FullScreenCompanySelectorState
    extends ConsumerState<FullScreenCompanySelector> {
  late TextEditingController searchTextController;
  late FocusNode _searchFocus;
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    searchTextController = TextEditingController();
    _searchFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: searchTextController.text.isEmpty,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        setState(() {
          searchTextController.text = "";
          _searchFocus.unfocus();
          _debounce?.cancel();
        });
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: "Select Companies".text.make(),
    );
  }

  _buildBody(BuildContext context) {
    return VStack(
      [
        8.h.heightBox,
        VxTextField(
          borderType: VxTextFieldBorderType.roundLine,
          borderRadius: 8.r,
          contentPaddingLeft: 16.w,
          controller: searchTextController,
          hint: "Search",
          focusNode: _searchFocus,
          onChanged: (str) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              setState(() {});
            });
          },
        ),
        8.h.heightBox,
        Consumer(
          builder: (context, ref, child) {
            final List<String> selectedCompanies =
                ref.watch(multiSelectCompanyNotifier);
            final companies = ref.watch(companyPodProvider);

            return companies.when(
              loading: () => CircularProgressIndicator().centered(),
              error: (err, stack) => err.toString().text.makeCentered(),
              data: (data) {
                final filteredCompanies = data
                    .where(
                      (cmp) => cmp.name.toLowerCase().contains(
                            searchTextController.text.toLowerCase(),
                          ),
                    )
                    .toList();

                if (filteredCompanies.isEmpty) {
                  return "No Companies Found..."
                      .text
                      .bodyLarge(context)
                      .slate400
                      .makeCentered();
                }

                return ListView.builder(
                  itemCount: filteredCompanies.length,
                  itemBuilder: (context, index) {
                    final company = filteredCompanies[index];
                    return ListTile(
                      title: company.name.text.make(),
                      subtitle: company.description.text.make(),
                      trailing: Checkbox(
                        value: selectedCompanies.contains(company.id),
                        onChanged: (value) {
                          ref
                              .read(multiSelectCompanyNotifier.notifier)
                              .toggleCompany(company.id);
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ).expand()
      ],
    ).pSymmetric(h: 16.w);
  }
}

// class MultiSelectCompanyNotifier extends StateNotifier<List<String>> {
//   MultiSelectCompanyNotifier() : super([]);

// }

// final multiSelectCompanyProvider = StateNotifierProvider(
//   (ref) => MultiSelectCompanyNotifier(),
// );

class MultiSelectCompanyNotifier extends StateNotifier<List<String>> {
  MultiSelectCompanyNotifier() : super([]);

  void toggleCompany(String cmpId) {
    if (state.contains(cmpId)) {
      state = state.filter((id) => id != cmpId).toList();
    } else {
      state = [...state, cmpId];
    }
  }

  void setSelectedCompanies(List<String> selected) {
    state = selected;
  }
}

final multiSelectCompanyNotifier =
    StateNotifierProvider<MultiSelectCompanyNotifier, List<String>>(
  (ref) {
    return MultiSelectCompanyNotifier();
  },
);
