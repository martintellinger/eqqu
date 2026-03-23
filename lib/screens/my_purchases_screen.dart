import 'package:flutter/material.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/widgets/filter_chip_bar.dart';
import 'package:eqqu/screens/order_detail_screen.dart';

class MyPurchasesScreen extends StatefulWidget {
  const MyPurchasesScreen({super.key});

  @override
  State<MyPurchasesScreen> createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends State<MyPurchasesScreen> {
  int _selectedFilter = 0;

  static const _filters = ['Vše', 'Aktivní', 'Dokončené', 'Stornované'];

  static const _orders = [
    {
      'id': '12345678',
      'date': '23.06.2025',
      'status': 'active',
      'price': '159 €',
      'images': ['assets/images/product_01.png', 'assets/images/product_02.png', 'assets/images/product_03.png'],
    },
    {
      'id': '12345679',
      'date': '23.06.2025',
      'status': 'completed',
      'price': '418 €',
      'images': ['assets/images/product_04.png', 'assets/images/product_05.png'],
    },
    {
      'id': '12345680',
      'date': '23.06.2025',
      'status': 'cancelled',
      'price': '159 €',
      'images': ['assets/images/product_06.png'],
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedFilter == 0) return _orders;
    final statusMap = {1: 'active', 2: 'completed', 3: 'cancelled'};
    return _orders.where((o) => o['status'] == statusMap[_selectedFilter]).toList();
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
            child: AppHeader(title: 'Moje nákupy', showBack: true),
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


  Widget _buildOrderCard(ColorScheme cs, Map<String, dynamic> order) {
    final status = order['status'] as String;
    Color cardBg;
    if (status == 'cancelled') {
      cardBg = cs.brightness == Brightness.dark
          ? const Color(0xFF5C1A10)
          : const Color(0xFFFFF2F0);
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
                        'Objednávka ${order['id']}',
                        style: AppTextStyles.actionLink(cs.secondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order['date'] as String,
                        style: AppTextStyles.bodyMedium(cs.tertiary),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(cs, status),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      for (var i = 0; i < (order['images'] as List).length; i++) ...[
                        if (i > 0) const SizedBox(width: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            (order['images'] as List)[i],
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
                  order['price'] as String,
                  style: AppTextStyles.productNewPrice(cs.surfaceTint),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(ColorScheme cs, String status) {
    String label;
    Color textColor;
    IconData icon;

    switch (status) {
      case 'active':
        label = 'Aktivní';
        textColor = const Color(0xFFA46700);
        icon = Icons.access_time;
        break;
      case 'completed':
        label = 'Dokončeno';
        textColor = cs.surfaceTint;
        icon = Icons.check_circle_outline;
        break;
      case 'cancelled':
        label = 'Storno';
        textColor = cs.error;
        icon = Icons.cancel_outlined;
        break;
      default:
        label = status;
        textColor = cs.tertiary;
        icon = Icons.info_outline;
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
