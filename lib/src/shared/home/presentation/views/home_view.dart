import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/features/settings/presentation/notifiers/settings_notifier.dart';
import 'package:companion/src/shared/home/presentation/widgets/companion_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final SearchController _searchController = SearchController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: [
        AgentsRoute(),
        CompanyRoute(),
      ],
      builder: (context, child, _) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: child,
          bottomNavigationBar: _buildBottomNavBar(context),
          floatingActionButton: _buildFAB(context),
          drawer: CompanionDrawer(),
        );
      },
    );
  }

  _buildAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: context.colors.surface,
      titleSpacing: 0,
      title: "Companion".text.make(),
      actions: [
        if (kDebugMode)
          IconButton(
            onPressed: () async {
              await ref.read(settingsNotifierProvider.notifier).addFakeData();
            },
            icon: Icon(Icons.refresh_outlined),
          ),
        IconButton(
          onPressed: () {
            context.pushRoute(SearchRoute());
          },
          icon: Icon(Icons.search_outlined),
        ),
        16.w.widthBox
      ],
    );
  }

  _buildBottomNavBar(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    return GNav(
      gap: 8.w,
      selectedIndex: tabsRouter.activeIndex,
      onTabChange: tabsRouter.setActiveIndex,
      backgroundColor: context.colors.surfaceContainer,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      tabs: [
        GButton(
          icon: Icons.person_outline,
          text: "Agents",
        ),
        GButton(
          icon: Icons.storefront_outlined,
          text: "Companies",
        ),
      ],
    );
  }

  _buildFAB(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    final isAgentsView = tabsRouter.currentPath == '/agents';
    return FloatingActionButton(
      elevation: 0,
      onPressed: () {
        if (isAgentsView) {
          context.pushRoute(NewAgentRoute());
        } else {
          context.pushRoute(NewCompanyRoute());
        }
      },
      child: Icon(
        isAgentsView ? Icons.person_add_outlined : Icons.add_business_outlined,
      ),
    );
  }
}
