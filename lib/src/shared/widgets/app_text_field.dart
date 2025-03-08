
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.controller,
      this.hint,
      this.label,
      this.readOnly = false,
      this.enabled = true,
      this.errorText,
      this.keyboardType,
      this.obscureText = false,
      this.prefix,
      this.suffix,
      this.textInputAction,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.onTap,
      this.enableSuggestions = false,
      this.autoFillHints,
      this.minLines,
      this.maxLines = 1,
      this.inputFormatters,
      this.textAlign = TextAlign.start,
      this.focusNode,
      this.style,
      this.border = const OutlineInputBorder()});

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final String? hint;
  final String? label;
  final bool readOnly;
  final bool enabled;
  final String? errorText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final bool enableSuggestions;
  final Iterable<String>? autoFillHints;
  final Function(String)? onChanged;
  final GestureTapCallback? onTap;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      enableSuggestions: enableSuggestions,
      autofillHints: autoFillHints,
      onChanged: onChanged,
      textAlign: textAlign,
      readOnly: readOnly,
      focusNode: focusNode,
      maxLines: maxLines,
      minLines: minLines,
      inputFormatters: inputFormatters,
      enabled: enabled,
      onTap: onTap,
      style: style,
      decoration: InputDecoration(
        labelText: label,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        border: border,
        suffixIcon: suffix,
        prefixIcon: loadPrefixIcon(prefix),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: hint,
        errorText: errorText,
        
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.grey),
      ),
    );
  }

  loadPrefixIcon(prefix) {
    if (prefix != null) {
      return prefix;
    }
  }
}