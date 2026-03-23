import 'package:flutter/material.dart';
import 'package:eqqu/data/mock_orders.dart';
import 'package:eqqu/models/enums.dart';
import 'package:eqqu/models/order.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/widgets/filter_chip_bar.dart';
import 'package:eqqu/screens/order_detail_screen.dart';

class MySalesScreen extends StatefulWidget {
  const MySalesScreen({super.key});

  @override
  State<MySalesScreen> createState() => _MySalesScreenState();
}

class _MySalesScreenState extends State<MySalesScreen> {
  int _selectedFilter = 0;

  static const _filters = ['Vše', 'Nové', 'Vyřízeno', 'Odesláno'];

  static const _orders = MockOrders.sales;

  List<SaleOrder> get _filteredOrders {
    if (_selectedFilter == 0) return _orders;
    final statusMap = {1: SaleStatus.newOrder, 2: SaleStatus.processed, 3: SaleStatus.shipped};
    return _orders.where((o) => o.status == statusMap[_selectedFilter]).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SafeArea(
            bottom: false,
            child: AppHeader(title: 'Moje prodeje', showBack: true),
          ),
          FilterChipBar(
            filters: _filters,
            selectedIndex: _selectedFilter,
            onSelected: (i) => setState(() => _selectedFilter = i),
          ),
          // Order list
          Expanded(
            child: ListView.separated(
              addAutomaticKeepAlives: false,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredOrders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildOrderCard(cs, _filteredOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildOrderCard(ColorScheme cs, SaleOrder order) {
    Color cardBg;
    if (order.status == SaleStatus.paidOut) {
      cardBg = cs.brightness == Brightness.dark
          ? const Color(0xFF3A3939)
          : const Color(0xFFF5F5F5);
    } else {
      cardBg = cs.surfaceContainerLow;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OrderDetailScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Objednávka ${order.id}',
                        style: AppTextStyles.actionLink(cs.secondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.date,
                        style: AppTextStyles.bodyMedium(cs.tertiary),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(cs, order.status),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      for (var i = 0; i < order.images.length; i++) ...[
                        if (i > 0) const SizedBox(width: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            order.images[i],
                            width: 40,
                            height: 43,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  order.price,
                  style: AppTextStyles.productNewPrice(cs.surfaceTint),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(ColorScheme cs, SaleStatus status) {
    final String label;
    final Color textColor;
    final IconData icon;

    switch (status) {
      case SaleStatus.newOrder:
        label = 'Nové';
        textColor = cs.surfaceTint;
        icon = Icons.add_circle_outline;
      case SaleStatus.processed:
        label = 'Vyřízeno';
        textColor = cs.surfaceTint;
        icon = Icons.check_circle_outline;
      case SaleStatus.shipped:
        label = 'Odesláno';
        textColor = cs.surfaceTint;
        icon = Icons.access_time;
      case SaleStatus.delivered:
        label = 'Doručeno';
        textColor = cs.surfaceTint;
        icon = Icons.local_shipping_outlined;
      case SaleStatus.paidOut:
        label = 'Vyplaceno';
        textColor = cs.tertiary;
        icon = Icons.account_balance_wallet_outlined;
    }

    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 8, right: 16, top: 6, bottom: 6),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.chip(textColor),
          ),
        ],
      ),
    );
  }
}
