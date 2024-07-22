import 'package:flutter/material.dart';

class InputStyled extends StatelessWidget {
  const InputStyled({
    super.key,
    required TextEditingController controller,
    required Widget prefixIcon,
    Widget? suffixIcon,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    bool obscureText = false,
    AutovalidateMode? autovalidateMode,
  })  : _controller = controller,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        _label = label,
        _hint = hint,
        _obscureText = obscureText,
        _validator = validator,
        _autovalidateMode = autovalidateMode;

  final TextEditingController _controller;
  final String _label;
  final String _hint;
  final Widget _prefixIcon;
  final Widget? _suffixIcon;
  final bool _obscureText;
  final AutovalidateMode? _autovalidateMode;
  final String? Function(String?)? _validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: _obscureText,
      autovalidateMode: _autovalidateMode,
      decoration: InputDecoration(
        labelText: _label,
        hintText: _hint,
        prefixIcon: _prefixIcon,
        suffixIcon: _suffixIcon,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
      ),
      validator: _validator,
    );
  }
}
