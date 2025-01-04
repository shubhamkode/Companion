import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/companies/models/company.dart';
import 'package:companion/src/features/companies/pods/companies_pod.dart';
import 'package:companion/src/features/companies/widgets/company_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class CompaniesPage extends ConsumerStatefulWidget {
  const CompaniesPage({super.key});

  @override
  ConsumerState<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends ConsumerState<CompaniesPage> {
  String? searchTerm;

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final companiesPod = ref.watch(companiesPodProvider);

    return SingleChildScrollView(
      physics: ScrollPhysics(),
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
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      searchTerm = str;
                    });
                  });
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
          companiesPod.when(
            data: (companies) {
              // companies.sort((prev, next) => prev.name.compareTo(next.name));

              final filteredCompanies = companies
                  .filter((ele) => ele.name.contains(searchTerm ?? ""))
                  .toList();

              if (filteredCompanies.isEmpty) {
                return "No Companies Found..."
                    .text
                    .titleMedium(context)
                    .slate400
                    .makeCentered()
                    .pOnly(top: 250.h);
              }
              return CompaniesList(companies: filteredCompanies);
            },
            loading: () => const CircularProgressIndicator().centered(),
            error: (error, stack) => error.toString().text.makeCentered(),
          ),
          10.h.heightBox,
        ],
      ),
    );
  }
}

class CompaniesList extends StatelessWidget {
  final List<Company> companies;
  const CompaniesList({super.key, required this.companies});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: companies.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (company, index) => CompanyCard(
        company: companies[index],
      ),
      separatorBuilder: (_, __) => SizedBox(
        height: 4.h,
      ),
    ).pSymmetric(
      h: 16.w,
      v: 4.h,
    );
  }
}
