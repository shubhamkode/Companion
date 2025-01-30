import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/shared/home/presentation/widgets/drawer_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:velocity_x/velocity_x.dart';

class CompanionDrawer extends StatelessWidget {
  const CompanionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final tabsRouter = AutoRouter.of(context);
    return Drawer(
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
                  // isSelected: tabsRouter.currentUrl == "/agents" ||
                  //     tabsRouter.currentUrl == '/companies',
                  onTap: () {
                    if (tabsRouter.currentUrl == "/agents" ||
                        tabsRouter.currentUrl == '/companies') {
                      context.router.maybePop();
                      return;
                    }
                    // context.router.popUntilRoot();
                  },
                ),
                DrawerActionButton(
                    icon: HugeIcons.strokeRoundedBitcoinTransaction,
                    title: "Hisab Kitab",
                    // isSelected: tabsRouter.currentPath == "/hisab-kitab",
                    onTap: () {
                      // if (tabsRouter.currentPath == "/hisab-kitab") {
                      //   context.router.maybePop();
                      //   return;
                      // }
                      context.router.popAndPush(
                        HisabKitabRoute(),
                      );
                    }),
              ],
              spacing: 8.h,
            ),
            Spacer(),
            DrawerActionButton(
              icon: HugeIcons.strokeRoundedSettings02,
              title: "Settings",
              onTap: () {
                context.router.popAndPush(
                  SettingsRoute(),
                );
              },
            ),
          ],
        ).pSymmetric(h: 8.w, v: 12.h),
      ),
    );
  }
}
