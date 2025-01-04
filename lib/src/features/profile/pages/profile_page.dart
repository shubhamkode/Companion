import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/pods/shared_prefs_pod.dart';
import 'package:companion/src/features/profile/pods/profile_pod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: "Settings".text.make(),
      titleSpacing: 0,
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: VStack([
        ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            16.h.heightBox,
            "Basic Settings".text.labelSmall(context).make().pOnly(left: 12.w),
            SwitchListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
              title: "Enable Dark Mode".text.make(),
              value: false,
              onChanged: (val) {},
            ),
            8.h.heightBox,
            "Backup and Restore"
                .text
                .labelSmall(context)
                .make()
                .pOnly(left: 12.w),
            12.h.heightBox,
            HStack(
              [
                OutlinedButton.icon(
                  icon: Icon(Icons.file_download_outlined),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () async {
                    final cancelLoading = context.showLoading(
                      msg: "Loading..",
                      bgColor: context.colors.primaryContainer,
                      textColor: context.colors.onPrimaryContainer,
                    );
                    try {
                      String? backupDir = ref
                          .read(sharedPrefsPodProvider)
                          .getString("backupDir");

                      if (backupDir.isEmptyOrNull &&
                          await Permission.manageExternalStorage
                              .request()
                              .isGranted) {
                        final path =
                            "${await FilePicker.platform.getDirectoryPath()}/Companion/";

                        await ref
                            .read(sharedPrefsPodProvider)
                            .setString("backupDir", path);

                        backupDir = path;
                      }

                      if (await Directory(backupDir!).exists() == false) {
                        throw Exception("Backup directory not Found");
                      }
                      await ref.read(profilePodProvider.notifier).importData(
                            Directory(backupDir),
                          );

                      if (mounted) {
                        context.showToast(
                          msg: "Data Imported Successfully",
                          bgColor: context.colors.secondary,
                          textColor: context.colors.onSecondary,
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        debugPrint("[ERROR]: ${e.toString()}");
                        context.showToast(
                          msg: e.toString(),
                          bgColor: context.colors.errorContainer,
                          textColor: context.colors.onErrorContainer,
                        );
                      }
                    } finally {
                      await cancelLoading();
                    }
                  },
                  label: "Import Data".text.make(),
                ).expand(),
                12.w.widthBox,
                OutlinedButton.icon(
                  icon: Icon(Icons.share_outlined),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () async {
                    final cancelLoading = context.showLoading(
                      msg: "Loading..",
                      bgColor: context.colors.primaryContainer,
                      textColor: context.colors.onPrimaryContainer,
                    );

                    try {
                      String? backupDir = ref
                          .read(sharedPrefsPodProvider)
                          .getString("backupDir");

                      if (backupDir.isEmptyOrNull &&
                          await Permission.manageExternalStorage
                              .request()
                              .isGranted) {
                        final path =
                            "${await FilePicker.platform.getDirectoryPath()}/Companion/";

                        await ref
                            .read(sharedPrefsPodProvider)
                            .setString("backupDir", path);

                        backupDir = path;
                      }

                      await ref.read(profilePodProvider.notifier).exportData(
                            Directory(backupDir!)..createSync(),
                          );

                      if (mounted) {
                        context.showToast(
                          msg: "Backup Created Sucessfully",
                          bgColor: context.colors.secondary,
                          textColor: context.colors.onSecondary,
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        context.showToast(
                          msg: e.toString(),
                          bgColor: context.colors.errorContainer,
                          textColor: context.colors.onErrorContainer,
                        );
                      }
                    } finally {
                      await cancelLoading();
                    }
                  },
                  label: "Export Data".text.make(),
                ).expand(),
              ],
              axisSize: MainAxisSize.max,
              alignment: MainAxisAlignment.spaceBetween,
            ).pSymmetric(h: 16.w),
            4.h.heightBox,
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () async {
                final cancelLoading = context.showLoading(
                  msg: "Loading..",
                  bgColor: context.colors.secondary,
                  textColor: context.colors.onSecondary,
                );
                await ref.read(profilePodProvider.notifier).clearAllData();
                await cancelLoading();
                if (mounted) {
                  context.showToast(
                    msg: "All Data Cleared",
                    bgColor: context.colors.secondary,
                    textColor: context.colors.onSecondary,
                  );
                }
              },
              child: Text("Clear all Data"),
            ).pSymmetric(h: 16.w)
            // GridTile(child: child),

            // ListTile(
            //   leading: Icon(Icons.share_outlined),
            //   title: "Export Data".text.make(),
            // ),
            // ListTile(
            //   leading: Icon(Icons.download_outlined),
            //   title: "Import Data".text.make(),
            // ),
          ],
        ),
      ]),
    );
  }
}
