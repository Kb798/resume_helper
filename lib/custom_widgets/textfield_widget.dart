import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resume_helper/utils/app_colors.dart';

class CustomField extends StatefulWidget {
  final TextEditingController fieldController;
  final String fieldName;
  final TextCapitalization? textCapitalization;
  final String? hint;
  final TextInputType? fieldInputType;
  final bool? enabled;
  final Color? bgColor;

  // final int? maxLines;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChange;
  final ValueChanged<String?>? onSave;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final double? contentpadding;
  final String? initialvalue;
  final bool? readOnly;

  const CustomField(
      {Key? key,
      required this.fieldName,
      this.textCapitalization,
      this.bgColor,
      this.fieldInputType,
      required this.fieldController,
      this.enabled,
      // this.maxLines,
      this.maxLength,
      this.validator,
      this.onTap,
      this.onSave,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      this.contentpadding,
      this.initialvalue,
      this.onChange,
      this.readOnly})
      : super(key: key);

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.fieldName),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
            readOnly: widget.readOnly ?? false,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
            initialValue: widget.initialvalue ?? null,
            controller: widget.fieldController,
            keyboardType: widget.fieldInputType ?? TextInputType.text,
            textInputAction: TextInputAction.next,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            enabled: widget.enabled ?? true,
            //maxLines:  widget.maxLines ?? null,
            //maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            validator: widget.validator ?? null,
            obscureText: widget.obscureText ?? false,
            onTap: widget.onTap ?? null,
            onChanged: widget.onChange ?? null,
            onSaved: widget.onSave ?? null,
            decoration: InputDecoration(
              counterText: '',
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(width: 0.8, color: AppColors.clrRed)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(width: 1.5, color: AppColors.clrMain)),
              hintText: widget.hint ?? "",
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
              isDense: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(width: 0.8, color: AppColors.clrMain)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(width: 1.5, color: AppColors.clrMain)),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 30, maxHeight: 20),
            )),
      ],
    ));
  }
}
