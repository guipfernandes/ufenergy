import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final GlobalKey<FormFieldState>? key;
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? icon;
  final TextEditingController? controller;
  final bool? validate;
  final double? fontSize;
  final Function? onTap;
  final Function? onChanged;
  final Function? onEditingComplete;
  final bool? enableInteractiveSelection;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final FormFieldValidator<String>? validator;
  final TextCapitalization? textCapitalization;
  final String? helperText;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;

  TextFieldWidget(
      {required this.label,
        this.controller,
        this.key,
        this.prefixIcon,
        this.suffixIcon,
        this.icon,
        this.validate = false,
        this.fontSize,
        this.onTap,
        this.onChanged,
        this.onEditingComplete,
        this.enableInteractiveSelection,
        this.textInputType,
        this.textInputAction,
        this.currentFocus,
        this.nextFocus,
        this.textCapitalization,
        this.validator,
        this.helperText,
        this.contentPadding,
        this.obscureText = false,
        this.enableSuggestions = true,
        this.autocorrect = true}
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: Theme.of(context).backgroundColor,
      ),
      child: TextFormField(
        key: key,
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        textInputAction: textInputAction ?? TextInputAction.done,
        style: Theme.of(context).inputDecorationTheme.labelStyle!.copyWith(fontSize: fontSize ?? 16.0),
        focusNode: currentFocus,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        enableInteractiveSelection: enableInteractiveSelection ?? true,
        maxLines: textInputType == TextInputType.multiline ? null : 1,
        inputFormatters: textInputType == TextInputType.numberWithOptions() &&
            !textInputType!.decimal!
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
        autocorrect: autocorrect,
        decoration: InputDecoration(
            labelText: label,
            contentPadding: contentPadding,
            prefixIcon: prefixIcon ?? null,
            icon: icon ?? null,
            suffixIcon: suffixIcon ?? null,
            helperText: helperText ?? null
        ),
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, nextFocus);
        },
        validator: validator ??
                (value) {
              if (value != null && value.isEmpty && validate!) {
                return 'Campo obrigatório!';
              } else {
                return null;
              }
            },
        onTap: onTap as void Function()?,
        onChanged: (value) {
          if (validate!) {
            key?.currentState?.validate();
          }
          if (onChanged != null) {
            onChanged!();
          }
        },
        onEditingComplete: onEditingComplete as void Function()?,
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode? nextFocus) {
    currentFocus?.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
