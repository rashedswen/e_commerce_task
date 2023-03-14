import 'dart:convert';

import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:e_commerce_task/views/add_item/add_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EcommerceButton extends StatelessWidget {
  const EcommerceButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.color
  });

  final String label;
  final IconData icon;
  final Color? color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
