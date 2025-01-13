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
    return AutoTabsRouter.pageView(
      routes: [
        ContactsRoute(),
        CompaniesRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: _buildAppBar(context),
          body: child,
          floatingActionButton: _buildFAB(context, tabsRouter),
          bottomNavigationBar: _buildBottomNavBar(context, tabsRouter),
          // drawer: Drawer(),
        );
      },
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      titleSpacing: 16.w,

      // leading: DrawerButton(
      //   onPressed: () {
      //     context.showToast(
      //       msg: "Feature Not Implemented Yet",
      //       bgColor: context.colors.errorContainer,
      //       textColor: context.colors.onErrorContainer,
      //     );
      //   },
      // ),
      title: "Companion".text.make(),
      actions: [
        (kDebugMode == true)
            ? Consumer(
                builder: (context, ref, child) {
                  return IconButton(
                    icon: Icon(Icons.refresh_outlined),
                    onPressed: () async {
                      await ref.read(settingsPodProvider.notifier).refresh();
                    },
                  );
                },
              )
            : SizedBox(),
        IconButton(
          onPressed: () async {
            context.pushRoute(SettingsRoute());
          },
          icon: Icon(Icons.person_outline_outlined),
        ),
        16.w.widthBox,
      ],
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

  _buildFAB(BuildContext context, TabsRouter router) {
    final bool isContactsPage = router.currentPath == "/contacts";

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
    ).pOnly(bottom: 8.h, right: 8.w);
  }
}
