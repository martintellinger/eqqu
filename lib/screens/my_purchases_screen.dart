import 'package:flutter/material.dart';
import 'package:eqqu/data/mock_orders.dart';
import 'package:eqqu/models/enums.dart';
import 'package:eqqu/models/order.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/widgets/filter_chip_bar.dart';
import 'package:eqqu/widgets/status_chip.dart';
import 'package:eqqu/screens/order_detail_screen.dart';
import 'package:eqqu/l10n/app_strings.dart';
import 'package:eqqu/theme/app_constants.dart';

class MyPurchasesScreen extends StatefulWidget {
  const MyPurchasesScreen({super.key});

  @override
  State<MyPurchasesScreen> createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends State<MyPurchasesScreen> {
  int _selectedFilter = 0;

  List<String> _filters(AppStrings s) => [s.all, s.statusActive, s.completed, s.statusCancelled];

  static const _orders = MockOrders.purchases;

  List<PurchaseOrder> get _filteredOrders {
    if (_selectedFilter == 0) return _orders;
    final statusMap = {1: OrderStatus.active, 2: OrderStatus.completed, 3: OrderStatus.cancelled};
    return _orders.where((o) => o.status == statusMap[_selectedFilter]).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = AppStrings.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(title: s.myPurchases, showBack: true),
          ),
          FilterChipBar(
            filters: _filters(s),
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


  Widget _buildOrderCard(ColorScheme cs, PurchaseOrder order) {
    final s = AppStrings.of(context);
    Color cardBg;
    if (order.status == OrderStatus.cancelled) {
      cardBg = cs.brightness == Brightness.dark
          ? AppConstants.cancelledBgDark
          : AppConstants.cancelledBgLight;
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
                        s.orderNumber(order.id),
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

  Widget _buildStatusChip(ColorScheme cs, OrderStatus status) {
    final s = AppStrings.of(context);
    final String label;
    final Color textColor;
    final IconData icon;

    switch (status) {
      case OrderStatus.active:
        label = s.statusActive;
        textColor = AppConstants.activeOrange;
        icon = Icons.access_time;
      case OrderStatus.completed:
        label = s.statusCompleted;
        textColor = cs.surfaceTint;
        icon = Icons.check_circle_outline;
      case OrderStatus.cancelled:
        label = s.statusCancelled;
        textColor = cs.error;
        icon = Icons.cancel_outlined;
    }

    return StatusChip(label: label, icon: icon, color: textColor);
  }
}
