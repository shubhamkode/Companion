import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchField<T> extends StatelessWidget {
  final SearchController searchController;
  final String hintText;
  final String hintEmpty;
  final SuggestionsBuilder suggestionsBuilder;

  const SearchField({
    super.key,
    required this.hintText,
    required this.searchController,
    required this.suggestionsBuilder,
    required this.hintEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: searchController,
      viewLeading: BackButton(
        onPressed: () {
          searchController.closeView("");
        },
      ),
      builder: (context, controller) {
        return VxTextField(
          borderType: VxTextFieldBorderType.roundLine,
          hint: "Search",
          style: context.textTheme.labelLarge,
          controller: controller,
          enabled: false,
        ).onTap(() {
          controller.openView();
        });
      },
      suggestionsBuilder: suggestionsBuilder,
      viewHintText: hintText,
      isFullScreen: true,
      viewTrailing: [
        CloseButton(
          onPressed: () {
            searchController.clear();
          },
        )
      ],
      headerHeight: 40.h,
      viewBackgroundColor: context.colors.surface,
      viewBuilder: (widgets) {
        return VStack(
          [
            widgets.isEmpty
                ? hintEmpty.text
                    .bodyLarge(context)
                    .slate400
                    .makeCentered()
                    .pOnly(top: 100.h)
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widgets.toList().length,
                    itemBuilder: (context, index) {
                      return widgets.toList()[index];
                    },
                  ).expand()
          ],
        );
      },
    ).pSymmetric(h: 16.w);
  }
}
