import 'package:flutter/material.dart';
import 'package:jitilab_test/core/utils/typedef_util.dart';
import '../utils/colors/common_colors.dart';
import '../utils/text_style/common_text_style.dart';

class CommonSearchFilterAction extends StatelessWidget {
  final TextEditingController keywordController;
  final StringCallback onDoSearch;
  final VoidCallback onClearSearch;
  final bool showSearch;
  final bool showFilter;
  final VoidCallback onFilter;
  final String hintSearch;
  final bool displayBadge;
  final int badgeCounter;

  const CommonSearchFilterAction({Key? key,
    required this.keywordController,
    required this.onDoSearch,
    required this.onClearSearch,
    required this.onFilter,
    this.hintSearch = '',
    this.showSearch = true,
    this.showFilter = true,
    this.displayBadge = false,
    this.badgeCounter = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Visibility(
            visible: showSearch,
            child: TextField(
              controller: keywordController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: CommonColors.greyD9),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: CommonColors.blueC9),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: CommonColors.greyD9),
                ),
                isDense: true,
                hintText: hintSearch,
                hintStyle: CommonTypography.roboto16
                    .copyWith(color: CommonColors.greyD4),
                prefixIcon: const Icon(
                  Icons.search,
                  color: CommonColors.greyD4,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minHeight: 20,
                  minWidth: 48,
                  maxHeight: 20,
                  maxWidth: 48,
                ),
                suffixIcon: IconButton(
                  onPressed: onClearSearch,
                  splashRadius: 20,
                  icon: const Icon(
                    Icons.clear,
                    color: CommonColors.black21,
                  ),
                ),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: onDoSearch,
            ),
          ),
        ),
        Visibility(visible: showFilter, child: const SizedBox(width: 10)),
        Visibility(
          visible: showFilter,
          child: Stack(
            children: [
              displayBadge
                  ? Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: CommonColors.red52,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: Text(
                    '$badgeCounter',
                    style: CommonTypography.roboto12
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
                  : const SizedBox.shrink(),
              InkWell(
                onTap: onFilter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.filter_alt_outlined,
                      color: CommonColors.blueC9,
                    ),
                    SizedBox(width: 4), // Adjust the width as needed
                    Text(
                      'Filter',
                      style: CommonTypography.roboto16
                          .copyWith(color: CommonColors.blueC9),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
