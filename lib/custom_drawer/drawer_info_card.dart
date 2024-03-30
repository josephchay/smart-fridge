import 'package:flutter/material.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class AppDrawerInfoCard extends StatelessWidget {
  const AppDrawerInfoCard({
    super.key,
    required this.brand,
    required this.slogan,
  });

  final String brand, slogan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 54,
            height: 54,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.nearlyWhite.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Icon(
                Icons.kitchen_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            brand,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            slogan,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
