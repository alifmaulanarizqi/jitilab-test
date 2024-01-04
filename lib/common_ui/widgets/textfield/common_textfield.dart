import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/typedef_util.dart';
import '../../utils/colors/common_colors.dart';
import '../../utils/text_style/common_text_style.dart';

class CommonTextField extends StatefulWidget {
  final String? label;
  final double? formHeight;
  final String hint;
  final TextEditingController? controller;
  final EdgeInsets padding;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final bool isObscureText;
  final bool isShowObscuredText;
  final BooleanCallback? onSuffixClick;
  final List<CommonTextFieldValidator> validators;
  final String defaultValue;
  final bool isEnable;
  final bool expands;
  final Color? disabledFillColor;
  final TextAlignVertical? textAlignVertical;

  const CommonTextField({
    Key? key,
    this.label,
    required this.hint,
    this.controller,
    this.padding = EdgeInsets.zero,
    this.inputAction = TextInputAction.done,
    this.inputType = TextInputType.text,
    this.isObscureText = false,
    this.isShowObscuredText = false,
    this.onSuffixClick,
    this.disabledFillColor = CommonColors.greyE7,
    this.validators = const [],
    this.defaultValue = '',
    this.isEnable = true,
    this.formHeight,
    this.expands = false,
    this.textAlignVertical,
  }) : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label != null
              ? Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.label!,
              style: CommonTypography.roboto14.copyWith(
                fontWeight: FontWeight.w700
              ),
            ),
          )
              : const SizedBox.shrink(),
          const SizedBox(height: 4),
          SizedBox(
            height: widget.formHeight,
            child: TextFormField(
              textAlignVertical: widget.textAlignVertical,
              enabled: widget.isEnable,
              expands: widget.expands,
              maxLines: widget.expands == true ? null : 1,
              controller: _controller,
              textInputAction: widget.inputAction,
              keyboardType: widget.inputType,
              obscureText: widget.isObscureText && !widget.isShowObscuredText,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: CommonColors.whiteFB,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: CommonColors.whiteFB,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: CommonColors.whiteFB,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: CommonColors.blueB5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: CommonColors.red52,
                  ),
                ),
                filled: true,
                isDense: true,
                focusColor: CommonColors.whiteFB,
                fillColor:
                widget.isEnable ? CommonColors.whiteFB : widget.disabledFillColor,
                hintText: widget.hint.isEmpty ? widget.label : widget.hint,
                suffixIcon: widget.isObscureText
                    ? IconButton(
                  onPressed: onSuffixIconClick,
                  splashRadius: 16,
                  icon: widget.isShowObscuredText
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                )
                    : null,
              ),
              validator: _handleValidator,
            ),
          ),
        ],
      ),
    );
  }

  String? _handleValidator(String? value) {
    var isRequired = widget.validators.contains(
      CommonTextFieldValidator.noEmpty,
    );

    if (isRequired && (value == null || value.isEmpty)) {
      return "${widget.label} can't be Empty";
    }

    return null;
  }

  void onSuffixIconClick() {
    if (widget.isShowObscuredText) {
      widget.onSuffixClick?.call(false);
    } else {
      widget.onSuffixClick?.call(true);
    }
  }
}

enum CommonTextFieldValidator {
  noEmpty,
  email,
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
