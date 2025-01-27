import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/utils/extensions.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_notifier.dart';
import 'package:companion/src/features/company/presentation/widgets/companies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class CompanyView extends ConsumerWidget {
  const CompanyView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyProvider = ref.watch(companyNotifierProvider);

    return companyProvider.onData(
      whenData: (companies) {
        return VStack([
          RefreshIndicator(
            onRefresh: () => ref.refresh(companyNotifierProvider.future),
            child: CompaniesList(
              companies: companies,
            ),
          ).expand(),
        ]);
      },
      whenEmpty: () {
        return "No Companies Found..."
            .text
            .bodyLarge(context)
            .color(context.accentColor.withAlpha(200))
            .makeCentered();
      },
    );
  }
}
