import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';

class PriceRow {
  final String label;
  final String value;
  final bool isBold;

  const PriceRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });
}

class PriceSummary extends StatelessWidget {
  final String title;
  final List<PriceRow> rows;
  final double titleOpacity;

  const PriceSummary({
    super.key,
    required this.title,
    required this.rows,
    this.titleOpacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: titleOpacity,
            child: Text(
              title,
              style: AppTextStyles.pageHeader(cs.secondary),
            ),
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < rows.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            _buildPriceRow(cs, rows[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceRow(ColorScheme cs, PriceRow row) {
    final style = row.isBold
        ? AppTextStyles.productNewPrice(cs.surfaceTint)
        : AppTextStyles.bodyMedium(cs.secondary);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(row.label, style: style)),
        Text(row.value, style: style),
      ],
    );
  }
}
