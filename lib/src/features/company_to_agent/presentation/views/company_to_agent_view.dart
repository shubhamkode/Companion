import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/core/utils/extensions.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_notifier.dart';
import 'package:companion/src/features/company_to_agent/presentation/notifiers/company_to_agent_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class CompanyToAgentView extends StatefulWidget {
  final String agentId;

  const CompanyToAgentView({
    super.key,
    required this.agentId,
  });

  @override
  State<CompanyToAgentView> createState() => _CompanyToAgentViewState();
}

class _CompanyToAgentViewState extends State<CompanyToAgentView> {
  String _searchStr = '';
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildBody(context),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: context.colors.surface,
      titleSpacing: 0,
      title: 'Link Company with agent'.text.make(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: VxTextField(
          onChanged: (val) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(Duration(milliseconds: 500), () {
              setState(() {
                _searchStr = val;
              });
            });
          },
          contentPaddingLeft: 16.w,
          borderType: VxTextFieldBorderType.roundLine,
          borderRadius: 8.r,
          hint: 'Search',
        ).pSymmetric(h: 16.w, v: 8.h),
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.pushRoute(NewCompanyRoute());
          },
          icon: Icon(Icons.add_outlined),
        ),
        8.w.widthBox,
      ],
    );
  }

  _buildBody(BuildContext context) {
    return VStack(
      [
        Consumer(
          builder: (context, ref, child) {
            final companies = ref.watch(companyNotifierProvider);
            return companies.onData(
              whenData: (companies) {
                final filteredCompanies = companies
                    .filter((c) =>
                        c.name.toLowerCase().contains(_searchStr.toLowerCase()))
                    .toList();

                return ref
                    .watch(companyToAgentNotifierProvider(widget.agentId))
                    .onData(
                  whenData: (companyToAgents) {
                    final linkedCompanyIds =
                        companyToAgents.builder((cToA) => cToA.companyId);

                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 20.h),
                      itemCount: filteredCompanies.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: filteredCompanies[index].name.text.make(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.w),
                          controlAffinity: ListTileControlAffinity.leading,
                          subtitle:
                              filteredCompanies[index].description.text.make(),
                          value: linkedCompanyIds
                              .contains(filteredCompanies[index].id),
                          onChanged: (val) async {
                            if (val == true) {
                              await ref
                                  .read(companyToAgentNotifierProvider(
                                          widget.agentId)
                                      .notifier)
                                  .addRelation(
                                    filteredCompanies[index].id,
                                  );
                            } else {
                              await ref
                                  .read(companyToAgentNotifierProvider(
                                          widget.agentId)
                                      .notifier)
                                  .removeRelation(
                                    filteredCompanies[index].id,
                                  );
                            }
                          },
                        );
                      },
                    ).expand();
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
