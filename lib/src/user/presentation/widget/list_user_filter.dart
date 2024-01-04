import 'package:flutter/material.dart';
import '../../../../common_ui/dialogs/common_dialogs.dart';
import '../../../../common_ui/utils/colors/common_colors.dart';
import '../../../../common_ui/utils/text_style/common_text_style.dart';
import '../../../../common_ui/widgets/common_action_tile.dart';
import '../../../../core/domain/models/key_value_dto.dart';

class ListUserFilter extends StatefulWidget {
  final List<KeyValueDto> genderTypeOptions;
  final List<KeyValueDto> lastSelectedGenderTypeOptions;
  final bool isSingleSelected;
  final String title;
  bool isResetFilter;

  ListUserFilter({Key? key,
    this.genderTypeOptions = const [],
    this.lastSelectedGenderTypeOptions = const [],
    required this.title,
    this.isSingleSelected = false,
    this.isResetFilter = false,
  }) : super(key: key);

  @override
  State<ListUserFilter> createState() =>
      _CourseDetailFileFilterDialogState();
}

class _CourseDetailFileFilterDialogState
    extends State<ListUserFilter> {
  final _selectedFileType = <KeyValueDto>[];

  @override
  void initState() {
    super.initState();
    if (widget.lastSelectedGenderTypeOptions.isNotEmpty) {
      setState(() {
        _selectedFileType.addAll(widget.lastSelectedGenderTypeOptions);
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: CommonTypography.roboto18.copyWith(
                    fontWeight: FontWeight.w700
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.isResetFilter = true;
                      _selectedFileType.clear();
                    });
                  },
                  child: Text(
                    "Reset Filter",
                    style: CommonTypography.roboto16
                        .copyWith(color: CommonColors.blueC9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CommonActionTile(
              backgroundColor: Colors.white,
              label: _selectedFileType.isEmpty
                  ? "Semua Gender"
                  : _selectedFileType[0].value,
              onClick: () {
                _onFileTypeSelected(_selectedFileType);
              },
              borderColor: CommonColors.greyD9,
              textStyle: CommonTypography.roboto14,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              endIcon: const Icon(
                Icons.keyboard_arrow_down,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
    );
  }

  void _onFileTypeSelected(List<KeyValueDto> lastSelectedSorts) async {
    var result = await CommonDialogs.showCommonFilterDialog(
      context,
      sortOptions: widget.genderTypeOptions,
      isSingleSelected: true,
      lastSelectedSorts: lastSelectedSorts,
      title: "Gender",
    );
    var strings = '';

    if (result != null) {
      try {
        List<KeyValueDto> selectedSorts = result[0];
        strings = selectedSorts[0].key;

        var tag =
        widget.genderTypeOptions.firstWhere((tag) => tag.key == strings);

        if (widget.isSingleSelected) {
          _selectedFileType.clear();
        }

        setState(() {
          _selectedFileType.add(tag);
        });
      } on Exception catch (e) {
        //_bloc.add(MainSearchCancelFilterEvent());
        CommonDialogs.showToastMessage(e.toString());
      }
    } else {
      //_bloc.add(MainSearchCancelFilterEvent());
    }
  }


  void _onApplyFilter() {
    Navigator.of(context)
        .pop([_selectedFileType, widget.isResetFilter]);
  }
}