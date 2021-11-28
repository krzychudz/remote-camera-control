import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  const FullWidthButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          label,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
