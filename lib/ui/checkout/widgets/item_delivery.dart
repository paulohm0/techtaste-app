import 'package:flutter/material.dart';
import 'package:techtaste_app/ui/_core/theme/app_colors.dart';

Widget itemDelivery({
  required BuildContext context,
  required int quantity,
  required String orderedItem,
  required int itemPrice,
}) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Text(
          '$quantity',
          style: const TextStyle(
              color: AppColors.black, fontWeight: FontWeight.w500),
        ),
      ),
      Expanded(
        flex: 4,
        child: Text(orderedItem,
            style: const TextStyle(
                color: AppColors.black, fontWeight: FontWeight.w500)),
      ),
      Expanded(
        flex: 2,
        child: Text(
          'R\$ ${itemPrice.toStringAsFixed(2)}',
          style: const TextStyle(
              color: AppColors.black, fontWeight: FontWeight.w500),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}
