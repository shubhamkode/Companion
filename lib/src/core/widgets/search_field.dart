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
        return TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
              borderSide: BorderSide.none,
            ),
            enabled: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
            filled: true,
            fillColor: context.colors.secondaryContainer.withAlpha(180),
            hintText: "Search",
            hintStyle: TextStyle(
              color: context.colors.onSecondaryContainer.withAlpha(180),
              fontWeight: FontWeight.w600,
            ),
          ),
        );
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
            (widgets.isEmpty
                    ? hintEmpty.text.bodyLarge(context).slate400.makeCentered()
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: widgets.toList().length,
                        itemBuilder: (context, index) {
                          return widgets.toList()[index];
                        },
                      ))
                .expand()
          ],
        );
      },
    ).pSymmetric(h: 16.w);
  }
}
