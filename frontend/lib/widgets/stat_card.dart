import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // A StatCard can be placed in either a fixed-height GridView or a
          // height-unbounded Wrap inside a scrolling page. Spacer needs a
          // finite height, so use a fixed visual gap in the latter case.
          final contentGap = constraints.hasBoundedHeight
              ? const Spacer()
              : const SizedBox(height: 24);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 20),
              contentGap,
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.kTextDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.kTextMuted,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
