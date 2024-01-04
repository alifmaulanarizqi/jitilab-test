import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../../core/domain/models/key_value_dto.dart';
import '../../src/user/presentation/widget/list_user_filter.dart';
import 'common_filter_dialog.dart';

class CommonDialogs {
  static Future showCustomBottomSheet(BuildContext context, Widget widget) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return WillPopScope(
          // Prevent back button from dismissing the bottom sheet
          onWillPop: () async => false,
          child: GestureDetector(
            onTap: () {
              // Do nothing on tap to prevent closing the bottom sheet
            },
            child: widget,
          ),
        );
      },
    );
  }

  static void showToastMessage(
    String? message,
  ) {
    Fluttertoast.showToast(
      msg: message ?? '',
      backgroundColor: Colors.black.withOpacity(0.3),
    );
  }

  static Future showCommonFilterDialog(
    BuildContext context, {
    required List<KeyValueDto> sortOptions,
    required String title,
    bool isSingleSelected = true,
    List<KeyValueDto> lastSelectedSorts = const [],
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return CommonFilterDialog(
          sortOptions: sortOptions,
          isSingleSelected: isSingleSelected,
          lastSelectedSorts: lastSelectedSorts,
          title: title,
        );
      },
    );
  }

  static Future showListUserFilter(
    BuildContext context, {
    required List<KeyValueDto> genderTypeOptions,
    required String title,
    bool isSingleSelected = true,
    List<KeyValueDto> lastSelectedGender = const [],
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return ListUserFilter(
          genderTypeOptions: genderTypeOptions,
          lastSelectedGenderTypeOptions: lastSelectedGender,
          isSingleSelected: isSingleSelected,
          title: title,
        );
      },
    );
  }
}
