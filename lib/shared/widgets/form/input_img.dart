import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class InputImg extends StatelessWidget {
  const InputImg({
    super.key,
    required label,
    required onTap,
    required Widget child,
  })  : _label = label,
        _onTap = onTap,
        _child = child;

  final String _label;
  final void Function()? _onTap;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(_label),
        const SizedBox(height: 4),
        DottedBorder(
          color: Colors.black,
          strokeWidth: 1,
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: _onTap,
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 180,
                child: Center(
                  child: _child,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
