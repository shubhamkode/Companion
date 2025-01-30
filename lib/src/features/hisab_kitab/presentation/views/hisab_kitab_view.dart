import 'dart:async';
import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:companion/src/core/database/tables.dart';
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/core/utils/uuid.dart';
import 'package:companion/src/features/hisab_kitab/presentation/notifiers/hisab_kitab_filter_provider.dart';
import 'package:companion/src/features/hisab_kitab/presentation/notifiers/hisab_kitab_notifier.dart';
import 'package:companion/src/features/hisab_kitab/presentation/widgets/hisab_kitab_tab_button.dart';
import 'package:companion/src/features/hisab_kitab/presentation/widgets/party_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class HisabKitabView extends StatelessWidget {
  const HisabKitabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFAB(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: context.colors.surface,
      titleSpacing: 0,
      title: "Hisab Kitab".text.make(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Consumer(builder: (context, ref, child) {
          final filterProvider = ref.watch(hisabKitabFilterProvider);

          return Column(
            children: [
              HStack(
                [
                  HisabKitabTabButton(
                    title: "Customers",
                    isSelected: filterProvider.type == PartyType.customer,
                    onTap: () {
                      ref.read(hisabKitabFilterProvider.notifier).update(
                            (state) => state.copyWith(type: PartyType.customer),
                          );
                    },
                  ),
                  HisabKitabTabButton(
                    title: "Suppliers",
                    isSelected: filterProvider.type == PartyType.supplier,
                    onTap: () {
                      ref.read(hisabKitabFilterProvider.notifier).update(
                            (state) => state.copyWith(type: PartyType.supplier),
                          );
                    },
                  ),
                ],
                spacing: 8.w,
                alignment: MainAxisAlignment.start,
                axisSize: MainAxisSize.max,
              ).pSymmetric(h: 8.w, v: 8.h),
              HisabKitabFilter().pSymmetric(h: 8.w),
              4.h.heightBox,
            ],
          );
        }),
      ),
    );
  }

  _buildFAB() {
    return Consumer(
      builder: (context, ref, child) {
        final partyType = ref.watch(hisabKitabFilterProvider).type;

        return FloatingActionButton.extended(
          onPressed: () async {
            await ref
                .read(databaseProvider)
                .managers
                .partyTable
                .create((c) => c(
                      name: "${partyType.name.toUpperCase()} ${uuid()}",
                      contacts: ["999999999", "999999999"],
                      type: partyType,
                    ));
          },
          label:
              "New ${partyType == PartyType.customer ? 'Customer' : 'Supplier'}"
                  .text
                  .titleMedium(context)
                  .make(),
          icon: Icon(HugeIcons.strokeRoundedPlusSign),
        );
      },
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: VStack(
        [
          HisabKitabPartiesView(),
        ],
        spacing: 12.h,
      ).pOnly(bottom: 40.h),
    );
  }
}

class HisabKitabFilter extends ConsumerStatefulWidget {
  const HisabKitabFilter({super.key});

  @override
  ConsumerState<HisabKitabFilter> createState() => _HisabKitabFilterState();
}

class _HisabKitabFilterState extends ConsumerState<HisabKitabFilter> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(hisabKitabFilterProvider);
    return HStack(
      [
        VxTextField(
          borderType: VxTextFieldBorderType.roundLine,
          hint:
              "Search ${filter.type == PartyType.customer ? 'Customers' : 'Suppliers'}",
          borderRadius: 8.r,
          contentPaddingLeft: 16.w,
          style: context.bodyLarge,
          textInputAction: TextInputAction.search,
          onChanged: (val) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(Duration(milliseconds: 300), () {
              ref.read(hisabKitabFilterProvider.notifier).update(
                    (state) => state.copyWith(searchText: val),
                  );
            });
          },
        ).expand(),
      ],
      spacing: 8.w,
    );
  }
}

class HisabKitabPartiesView extends ConsumerStatefulWidget {
  const HisabKitabPartiesView({super.key});

  @override
  ConsumerState<HisabKitabPartiesView> createState() =>
      _HisabKitabPartiesViewState();
}

class _HisabKitabPartiesViewState extends ConsumerState<HisabKitabPartiesView> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadMore() {
    print(true);
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      ref.read(hisabKitabFilterProvider.notifier).update(
            (state) => state.copyWith(
              limit: state.limit + 10,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final partiesProvider = ref.watch(partyNotifierProvider);

    return partiesProvider.when(
      error: (err, stack) {
        log(err.toString());
        return SizedBox.shrink();
      },
      loading: () {
        return _buildLoading(context);
      },
      skipLoadingOnReload: true,
      data: (parties) {
        if (parties.isEmpty) {
          return "No Parties Found"
              .text
              .bodyLarge(context)
              .color(context.accentColor.withAlpha(200))
              .makeCentered()
              .pOnly(top: 200.h);
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          itemCount: parties.length,
          itemBuilder: (context, index) {
            return PartyTile(
              party: parties[index],
            );
          },
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ListTile(
          minTileHeight: 0,
          contentPadding: EdgeInsets.only(
            left: 16.w,
            right: 4.w,
            top: 4.h,
            bottom: 4.h,
          ),
          leading: CircleAvatar().shimmer(),
          title: VxSkeleton(
            height: 12.h,
            borderRadius: BorderRadius.circular(8.r),
          ).shimmer(),
          subtitle: VxSkeleton(
            height: 4.h,
            borderRadius: BorderRadius.circular(8.r),
          ).shimmer().pOnly(top: 4.h),
        );
      },
    );
  }
}
