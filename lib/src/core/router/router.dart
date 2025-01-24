import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/agent/presentation/views/agent_details_view.dart';
import 'package:companion/src/features/agent/presentation/views/agent_view.dart';
import 'package:companion/src/features/agent/presentation/views/new_agent_view/new_agent_view.dart';
import 'package:companion/src/features/company/presentation/views/company_view.dart';
import 'package:companion/src/features/company/presentation/views/new_company_view.dart';
import 'package:companion/src/features/settings/presentation/views/settings_view.dart';
import 'package:companion/src/shared/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

import '../../features/company/presentation/views/company_details_view.dart';

part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'View,Route',
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          children: [
            AutoRoute(
              path: 'agents',
              page: AgentsRoute.page,
              initial: true,
            ),
            AutoRoute(
              path: 'companies',
              page: CompanyRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/agents/new',
          fullscreenDialog: true,
          page: NewAgentRoute.page,
        ),
        AutoRoute(
          path: '/agent-details',
          page: AgentDetailsRoute.page,
        ),
        AutoRoute(
          path: '/companies/new',
          page: NewCompanyRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          path: '/company-details',
          page: CompanyDetailsRoute.page,
        ),
        AutoRoute(
          path: '/settings',
          page: SettingsRoute.page,
        )
      ];
}
