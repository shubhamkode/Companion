import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies/pages/companies_page.dart';
import 'package:companion/src/features/companies/pages/company_details_page.dart';
import 'package:companion/src/features/companies/pages/edit_company_page.dart';
import 'package:companion/src/features/companies/pages/new_company_page.dart';
import 'package:companion/src/features/companies_to_contact/models/comp_to_conc_model.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/pages/contact_details_page.dart';
import 'package:companion/src/features/contacts/pages/contacts/edit/page.dart';
import 'package:companion/src/features/contacts/pages/contacts/new/page.dart';
import 'package:companion/src/features/contacts/pages/contacts_page.dart';
import 'package:companion/src/features/home/pages/home_page.dart';
import 'package:companion/src/features/pims/models/pim_model.dart';
import 'package:companion/src/features/settings/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: "/",
          usesPathAsKey: true,
          initial: true,
          children: [
            AutoRoute(
              page: ContactsRoute.page,
              path: "contacts",
              initial: true,
            ),
            AutoRoute(
              page: CompaniesRoute.page,
              path: "companies",
            ),
          ],
        ),
        AutoRoute(
          path: "/new-company",
          page: NewCompanyRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          path: '/edit-company',
          page: EditCompanyRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          path: "/new-contact",
          page: NewContactRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          path: '/edit-contact',
          page: EditContactRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          path: "/company-details",
          page: CompanyDetailsRoute.page,
        ),
        AutoRoute(
          path: "/contact-details",
          page: ContactDetailsRoute.page,
        ),
        AutoRoute(path: "/settings", page: SettingsRoute.page)
      ];
}

@riverpod
Raw<AppRouter> routerPod(Ref ref) {
  return AppRouter();
}
