import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_notifier.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  String searchStr = "";
  Timer? _debounce;
  final FocusNode _searchFieldNode = FocusNode();
  bool _searchTypeNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      toolbarHeight: 40.h,
      title: VxTextField(
        autofocus: true,
        focusNode: _searchFieldNode,
        icon: Icon(Icons.arrow_back).onTap(() {
          context.maybePop();
        }),
        hint: "Search",
        borderType: VxTextFieldBorderType.roundLine,
        borderRadius: 8.r,
        keyboardType:
            _searchTypeNumber ? TextInputType.phone : TextInputType.text,
        contentPaddingLeft: 16.w,
        onChanged: (val) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(Duration(milliseconds: 300), () {
            setState(() {
              searchStr = val;
            });
          });
        },
      ).pSymmetric(h: 16.w),
      actions: [
        IconButton(
          onPressed: () {
            _searchFieldNode.unfocus();

            setState(() {
              _searchTypeNumber = !_searchTypeNumber;
            });
            Future.delayed(Duration(milliseconds: 500), () {
              _searchFieldNode.requestFocus();
            });
          },
          icon: Icon(
            _searchTypeNumber
                ? HugeIcons.strokeRoundedKeyboard
                : HugeIcons.strokeRoundedDialpadCircle02,
          ),
        ),
        8.w.widthBox,
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: VStack(
        [
          if (!_searchTypeNumber) _buildCompanies(),
          _buildAgents(),
        ],
        spacing: 24.h,
      ).pSymmetric(h: 12.w, v: 18.h),
    );
  }

  _buildCompanies() {
    final companyProvider = ref.watch(companyNotifierProvider);

    return VStack(
      [
        "Companies".text.labelMedium(context).make(),
        12.h.heightBox,
        companyProvider.when(
          loading: () {
            return CircularProgressIndicator().centered().h(120.h);
          },
          error: (err, stack) {
            return err.toString().text.makeCentered();
          },
          data: (companies) {
            final filteredCompanies = companies
                .filter(
                  (c) => c.name.toLowerCase().contains(
                        searchStr.toLowerCase(),
                      ),
                )
                .toList();

            if (filteredCompanies.isEmpty) {
              return "No Companies Found..."
                  .text
                  .color(context.colors.onSurface.withAlpha(200))
                  .makeCentered()
                  .h(120.h);
            }
            return SizedBox(
              height: 120.h,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: filteredCompanies.length,
                itemBuilder: (context, index) {
                  final company = filteredCompanies[index];
                  return GridTile(
                    child: Card.outlined(
                      child: VStack(
                        [
                          CircleAvatar(
                            backgroundColor: company.hexColor,
                            child: company.name[0].text
                                .color(context.colors.surface)
                                .titleLarge(context)
                                .make(),
                          ),
                          12.h.heightBox,
                          GridTileBar(
                            title: company.name.text
                                .bodyMedium(context)
                                .center
                                .make()
                                .pSymmetric(h: 4.w),
                          ),
                          // company.name.text.center.make().pSymmetric(h: 4.w),
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                        alignment: MainAxisAlignment.center,
                      ),
                    ),
                  ).onTap(() {
                    context.router.popAndPush(
                      CompanyDetailsRoute(companyId: company.id),
                    );
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  _buildAgents() {
    final agentProvider = ref.watch(agentNotifierProvider);

    return VStack(
      [
        "Agents".text.labelMedium(context).make(),
        12.h.heightBox,
        agentProvider.when(
          loading: () {
            return Card.filled(
              child: 120.h.heightBox,
            ).wFull(context).shimmer();
          },
          error: (err, stack) {
            return err.toString().text.makeCentered();
          },
          data: (agents) {
            final List<AgentEntity> filteredAgents = _searchTypeNumber
                ? (agents
                    .filter((a) => a.contacts.any((c) => c.contains(searchStr)))
                    .toList())
                : (agents
                    .filter(
                      (a) => a.name.toLowerCase().contains(
                            searchStr.toLowerCase(),
                          ),
                    )
                    .toList());

            if (filteredAgents.isEmpty) {
              return "No Agents Found..."
                  .text
                  .color(context.colors.onSurface.withAlpha(200))
                  .makeCentered()
                  .h(120.h);
            }
            return SizedBox(
              height: 120.h,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: filteredAgents.length,
                itemBuilder: (context, index) {
                  final agent = filteredAgents[index];
                  return GridTile(
                    child: Card.outlined(
                      child: VStack(
                        [
                          CircleAvatar(
                            backgroundColor: agent.hexColor,
                            child: agent.name[0].text
                                .color(context.colors.surface)
                                .titleLarge(context)
                                .make(),
                          ),
                          12.h.heightBox,
                          GridTileBar(
                            title: agent.name.text
                                .bodyMedium(context)
                                .center
                                .make()
                                .pSymmetric(h: 4.w),
                          ),
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                        alignment: MainAxisAlignment.center,
                      ),
                    ),
                  ).onTap(() {
                    context.router.popAndPush(
                      AgentDetailsRoute(agentId: agent.id),
                    );
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
