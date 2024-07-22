import 'package:flutter/material.dart';

class DropdownOutline extends StatelessWidget {
  const DropdownOutline({
    super.key,
    String? value,
    required String label,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    TextInputType? keyboardType,
    required Widget prefixIcon,
    Widget? suffixIcon,
    int? maxLines = 1,
    String? Function(String?)? validator,
    bool obscureText = false,
    bool readOnly = false,
    AutovalidateMode? autovalidateMode,
    void Function(String?)? onChanged,
  })  : _value = value,
        _label = label,
        _hint = hint,
        _items = items,
        _prefixIcon = prefixIcon,
        _validator = validator,
        _autovalidateMode = autovalidateMode,
        _onChanged = onChanged;

  final String? _value;
  final String _label;
  final String _hint;
  final List<DropdownMenuItem<String>> _items;
  final Widget _prefixIcon;
  final AutovalidateMode? _autovalidateMode;
  final String? Function(String?)? _validator;
  final void Function(String?)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(_label),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          hint: Text(_hint),
          decoration: InputDecoration(
            prefixIcon: _prefixIcon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          value: _value,
          autovalidateMode: _autovalidateMode,
          items: _items,
          onChanged: _onChanged,
          validator: _validator,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
