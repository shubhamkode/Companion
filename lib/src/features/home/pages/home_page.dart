import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/features/settings/pods/settings_pod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: [
        ContactsRoute(),
        CompaniesRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: _buildAppBar(context),
          body: child,
          floatingActionButton: _buildFAB(context, tabsRouter),
          bottomNavigationBar: _buildBottomNavBar(context, tabsRouter),
        );
      },
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      titleSpacing: 0,
      leadingWidth: 0,
      title: HStack(
        [
          CircleAvatar(
            backgroundColor: context.colors.surfaceContainer,
            radius: 24,
            child: Icon(
              Icons.person_2_outlined,
              color: context.colors.onSurface.withAlpha(200),
              size: 20.w,
            ),
          ).pOnly(left: 12.w).onTap(() {
            context.pushRoute(SettingsRoute());
          }),
          8.w.widthBox,
          "Companion".text.make(),
        ],
        crossAlignment: CrossAxisAlignment.center,
      ),
      actions: kDebugMode
          ? [
              Consumer(
                builder: (context, ref, child) {
                  return IconButton(
                    icon: Icon(Icons.refresh_outlined),
                    onPressed: () async {
                      await ref.read(settingsPodProvider.notifier).refresh();
                    },
                  );
                },
              ),
              8.w.widthBox,
            ]
          : null,
    );
  }

  _buildBottomNavBar(BuildContext context, TabsRouter tabsRouter) {
    return GNav(
      gap: 8.w,
      selectedIndex: tabsRouter.activeIndex,
      onTabChange: tabsRouter.setActiveIndex,
      backgroundColor: context.colors.surfaceContainer,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      tabs: [
        GButton(
          icon: Icons.person_outline,
          text: "Contacts",
        ),
        GButton(
          icon: Icons.storefront_outlined,
          text: "Companies",
        ),
      ],
    );
  }

  _buildFAB(BuildContext context, TabsRouter tabsRouter) {
    final bool isContactsPage = tabsRouter.currentPath == "/contacts";

    return FloatingActionButton(
      elevation: 0,
      onPressed: () {
        if (isContactsPage) {
          context.router.navigate(
            NewContactRoute(),
          );
        } else {
          context.router.navigate(
            NewCompanyRoute(),
          );
        }
      },
      child: Icon(
        isContactsPage
            ? Icons.person_add_outlined
            : Icons.add_business_outlined,
      ),
    );
  }
}
