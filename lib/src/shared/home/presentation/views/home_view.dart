import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/features/settings/presentation/notifiers/settings_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hugeicons/hugeicons.dart';
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
          drawer: _buildDrawer(),
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

  _buildDrawer() {
    return Drawer(
      // backgroundColor: context.colors.primaryContainer,
      child: SafeArea(
        child: VStack(
          [
            DrawerHeader(
              child: VStack(
                [
                  "Companion".text.titleLarge(context).make(),
                  "v.0.1.0".text.bodySmall(context).make(),
                ],
                alignment: MainAxisAlignment.center,
                crossAlignment: CrossAxisAlignment.center,
              ).centered(),
            ),
            16.h.heightBox,
            VStack(
              [
                DrawerActionButton(
                  icon: HugeIcons.strokeRoundedContact01,
                  title: "Contacts",
                  isSelected: true,
                ),
                // DrawerActionButton(
                //   icon: Icons.archive_outlined,
                //   title: "Manage Debtors",
                // ),
                DrawerActionButton(
                  icon: HugeIcons.strokeRoundedSettings02,
                  title: "Settings",
                  onTap: () {
                    context.maybePop();
                    context.router.push(
                      SettingsRoute(),
                    );
                  },
                ),
              ],
              spacing: 8.h,
            ),
          ],
        ).pSymmetric(h: 6.w, v: 12.h),
      ),
    );
  }
}

class DrawerActionButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final IconData icon;
  final VoidCallback? onTap;

  const DrawerActionButton({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      selected: isSelected,
      leading: Icon(icon),
      selectedTileColor: context.colors.primary,
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      selectedColor: context.colors.onPrimary,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      title: title.text
          .titleSmall(context)
          .semiBold
          .color(
            isSelected
                ? context.colors.onPrimary
                : context.colors.onPrimaryContainer,
          )
          .make(),
    );
  }
}
