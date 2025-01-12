import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/core/widgets/search_field.dart';
import 'package:companion/src/features/companies/pods/company_pod.dart';
import 'package:companion/src/features/companies/widgets/companies_list.dart';
import 'package:companion/src/utils/color_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class CompaniesPage extends ConsumerStatefulWidget {
  const CompaniesPage({super.key});

  @override
  ConsumerState<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends ConsumerState<CompaniesPage> {
  late final SearchController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final companiesPod = ref.watch(companyPodProvider);

    return companiesPod.when(
      loading: () => CircularProgressIndicator().centered(),
      error: (err, stack) => err.toString().text.makeCentered(),
      data: (companies) {
        return VStack(
          [
            12.h.heightBox,
            SearchField(
              hintText: "Search Companies",
              hintEmpty: "No Companies Found",
              searchController: _searchController,
              suggestionsBuilder: (context, controller) {
                if (controller.text.isEmpty) {
                  return [];
                }
                return companies
                    .filter((cmp) => cmp.name
                        .toLowerCase()
                        .contains(controller.text.toLowerCase()))
                    .toList()
                    .builder(
                      (cmp) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: cmp.hexColor.colorFromHex(),
                          child: Text(cmp.name[0]),
                        ).onTap(() {
                          context
                              .pushRoute(CompanyDetailsRoute(
                            companyId: cmp.id,
                          ))
                              .then((val) {
                            _searchController.closeView("");
                          });
                          // _searchController.closeView("");
                        }),
                        title:
                            cmp.name.text.titleMedium(context).make().onTap(() {
                          context
                              .pushRoute(CompanyDetailsRoute(
                            companyId: cmp.id,
                          ))
                              .then((val) {
                            _searchController.closeView("");
                          });
                          // _searchController.closeView("");
                        }),
                        subtitle:
                            cmp.description.text.bodyMedium(context).make(),
                      ),
                    );
              },
            ),
            8.h.heightBox,
            CompaniesList(
              onRefresh: () async {
                ref.invalidate(companyPodProvider);
              },
              companies: companies,
            )
                .pSymmetric(
                  h: 16.w,
                  v: 4.h,
                )
                .expand(),
          ],
        );
      },
    );
  }
}
