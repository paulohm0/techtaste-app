import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../_core/theme/app_colors.dart';

class BoxDeliveryDetails extends StatelessWidget {
  final String titleBox;
  final List<Widget> widgetsBelow;

  // Construtor
  const BoxDeliveryDetails({
    super.key,
    required this.titleBox,
    this.widgetsBelow = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            child:
                Text(titleBox, style: const TextStyle(color: AppColors.grey)),
          ),
          ...widgetsBelow,
        ],
      ),
    );
  }
}
