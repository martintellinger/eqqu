import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eqqu/theme/app_text_styles.dart';

class SpecItem {
  final String svgPath;
  final String label;
  final String value;

  const SpecItem({
    required this.svgPath,
    required this.label,
    required this.value,
  });
}

class SpecsGrid extends StatelessWidget {
  final List<SpecItem> specs;

  const SpecsGrid({super.key, required this.specs});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final rows = <Widget>[];

    for (var i = 0; i < specs.length; i += 2) {
      if (i > 0) {
        rows.add(const SizedBox(height: 16));
      }
      rows.add(
        Row(
          children: [
            Expanded(child: _buildSpecItem(cs, specs[i])),
            const SizedBox(width: 12),
            if (i + 1 < specs.length)
              Expanded(child: _buildSpecItem(cs, specs[i + 1]))
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _buildSpecItem(ColorScheme cs, SpecItem spec) {
    return Row(
      children: [
        SvgPicture.asset(spec.svgPath, width: 24, height: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(spec.label, style: AppTextStyles.bodyMedium(cs.tertiary)),
              Text(spec.value, style: AppTextStyles.bodyLarge(cs.secondary)),
            ],
          ),
        ),
      ],
    );
  }
}
