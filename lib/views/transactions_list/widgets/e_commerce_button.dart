import 'package:flutter/material.dart';

class EcommerceField extends StatelessWidget {
  const EcommerceField({
    super.key,
    required this.label,
    this.controller,
    this.icon,
    required this.onChanged,
  });
  final String label;
  final TextEditingController? controller;
  final IconData? icon;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onChanged(value);
      },
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        hintText: label,
        fillColor: Colors.white,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
      ),
    );
  }
}
