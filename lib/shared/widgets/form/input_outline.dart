import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputOutline extends StatelessWidget {
  const InputOutline({
    super.key,
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    required Widget prefixIcon,
    Widget? suffixIcon,
    int? maxLines = 1,
    String? Function(String?)? validator,
    bool obscureText = false,
    bool readOnly = false,
    AutovalidateMode? autovalidateMode,
    void Function()? onTap,
    List<TextInputFormatter>? inputFormatters,
  })  : _controller = controller,
        _label = label,
        _hint = hint,
        _keyboardType = keyboardType,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        _obscureText = obscureText,
        _maxLines = maxLines,
        _validator = validator,
        _readOnly = readOnly,
        _autovalidateMode = autovalidateMode,
        _onTap = onTap,
        _inputFormatters = inputFormatters;

  final TextEditingController _controller;
  final String _label;
  final String _hint;
  final TextInputType? _keyboardType;
  final Widget _prefixIcon;
  final Widget? _suffixIcon;
  final bool _obscureText;
  final bool _readOnly;
  final int? _maxLines;
  final AutovalidateMode? _autovalidateMode;
  final String? Function(String?)? _validator;
  final List<TextInputFormatter>? _inputFormatters;
  final void Function()? _onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(_label),
        const SizedBox(height: 4),
        TextFormField(
          onTap: _onTap,
          controller: _controller,
          maxLines: _maxLines,
          validator: _validator,
          obscureText: _obscureText,
          autovalidateMode: _autovalidateMode,
          keyboardType: _keyboardType,
          readOnly: _readOnly,
          inputFormatters: _inputFormatters,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: _hint,
            prefixIcon: _prefixIcon,
            suffixIcon: _suffixIcon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
