import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/ui/_core/providers/bag_provider.dart';
import 'package:techtaste_app/ui/checkout/check_order_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showShopButton;

  const CustomAppBar({
    super.key,
    this.title,
    this.showShopButton = true,
  });

  @override
  Widget build(BuildContext context) {
    BagProvider bagProvider = Provider.of<BagProvider>(context);
    return AppBar(
      forceMaterialTransparency: true,
      elevation: 0,
      title: title != null ? Text(title!) : null,
      centerTitle: true,
      actions: [
        if (showShopButton)
          badges.Badge(
            showBadge: bagProvider.dishesOnBag.isNotEmpty,
            position: badges.BadgePosition.bottomStart(start: 0, bottom: 0),
            badgeContent: Text(
              bagProvider.dishesOnBag.length.toString(),
              style: const TextStyle(fontSize: 10),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CheckOrderScreen();
                }));
              },
              icon: const Icon(Icons.shopping_basket),
            ),
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
