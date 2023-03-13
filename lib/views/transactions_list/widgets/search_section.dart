import 'package:e_commerce_task/views/transactions_list/widgets/e_commerce_button.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: constraints.maxHeight,
        child: Row(
          children: [
            const Expanded(
              flex: 5,
              child: EcommerceField(
                label: "Search",
                icon: Icons.search,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: const Icon(Icons.filter_alt),
              ),
            )
          ],
        ),
      );
    });
  }
}
