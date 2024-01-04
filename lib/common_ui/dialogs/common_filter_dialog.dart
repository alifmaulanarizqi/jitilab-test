import 'package:flutter/material.dart';

import '../../core/domain/models/key_value_dto.dart';
import '../../core/utils/typedef_util.dart';
import '../utils/colors/common_colors.dart';
import '../utils/text_style/common_text_style.dart';
import '../widgets/common_action_tile.dart';

class CommonFilterDialog extends StatefulWidget {
  final List<KeyValueDto> sortOptions;
  final bool isSingleSelected;
  final String title;

  final List<KeyValueDto> lastSelectedSorts;

  const CommonFilterDialog({
    Key? key,
    required this.sortOptions,
    required this.title,
    this.isSingleSelected = false,
    this.lastSelectedSorts = const [],
  }) : super(key: key);

  @override
  State<CommonFilterDialog> createState() => _CommonFilterDialogState();
}

class _CommonFilterDialogState extends State<CommonFilterDialog> {
  final _selectedSorts = <KeyValueDto>[];

  @override
  void initState() {
    super.initState();

    if (widget.lastSelectedSorts.isNotEmpty) {
      setState(() {
        _selectedSorts.addAll(widget.lastSelectedSorts);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 100,
                child: Divider(
                  height: 2,
                  thickness: 2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.title,
                style: CommonTypography.roboto18.copyWith(
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            const SizedBox(height: 18),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight:  MediaQuery.of(context).size.height * 0.4
              ),
              child: CommonTagList(
                tags: widget.sortOptions,
                selectedTags: _selectedSorts,
                onSelected: _onSortSelected,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: CommonColors.blueC9,
                  shape: const RoundedRectangleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: _onApplyFilter,
                child: const Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSortSelected(String key) {
    var tag = widget.sortOptions.firstWhere((tag) => tag.key == key);
    var selectedKeys = _selectedSorts.map((tag) => tag.key);

    if (selectedKeys.contains(key)) {
      setState(() {
        _selectedSorts.removeWhere((element) => element.key == key);
      });
    } else {
      if (widget.isSingleSelected) {
        _selectedSorts.clear();
      }

      setState(() {
        _selectedSorts.add(tag);
      });
    }
  }

  void _onApplyFilter() {
    Navigator.of(context).pop([_selectedSorts]);
  }
}

class CommonTagList extends StatelessWidget {
  final List<KeyValueDto> tags;
  final List<KeyValueDto> selectedTags;
  final StringCallback? onSelected;

  const CommonTagList({
    super.key,
    required this.tags,
    required this.selectedTags,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
            itemCount: tags.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (ctx, idx) {
              var tag = tags[idx];
              var selectedKeys = selectedTags.map((tag) => tag.key);
              var isSelected = selectedKeys.contains(tag.key);
              return CommonActionTile(
                backgroundColor:
                isSelected ? CommonColors.blueF9 : Colors.transparent,
                label: tag.value,
                onClick: () {
                  onSelected?.call(tag.key);
                },
                borderColor:
                isSelected ? CommonColors.blueC9 : CommonColors.greyD9,
                textStyle: CommonTypography.roboto14,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(
              height: 6,
            )));
  }
}

