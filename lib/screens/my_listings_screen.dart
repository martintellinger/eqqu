import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';
import 'package:eqqu/screens/order_detail_screen.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
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
      'price': '159 €',
      'images': ['assets/images/product_01.png', 'assets/images/product_02.png', 'assets/images/product_03.png'],
    },
    {
      'id': '12345680',
      'date': '23.06.2025',
      'status': 'cancelled',
      'price': '159 €',
      'images': ['assets/images/product_01.png', 'assets/images/product_02.png', 'assets/images/product_03.png'],
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
          SafeArea(
            bottom: false,
            child: AppHeader(title: 'Moje inzeráty', showBack: true),
          ),
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(_filters.length, (i) {
                final selected = _selectedFilter == i;
                return Padding(
                  padding: EdgeInsets.only(right: i < _filters.length - 1 ? 8 : 0),
                  child: _buildFilterChip(cs, _filters[i], selected, () {
                    setState(() => _selectedFilter = i);
                  }),
                );
              }),
            ),
          ),
          // Order list
          Expanded(
            child: ListView.separated(
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

  Widget _buildFilterChip(ColorScheme cs, String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        padding: EdgeInsets.only(
          left: selected ? 8 : 16,
          right: 16,
          top: 6,
          bottom: 6,
        ),
        decoration: BoxDecoration(
          color: selected ? cs.primary : Colors.transparent,
          border: selected ? null : Border.all(color: cs.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              Icon(Icons.check, size: 18, color: Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : cs.onSurfaceVariant,
                letterSpacing: 0.1,
                height: 20 / 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(ColorScheme cs, Map<String, dynamic> order) {
    final status = order['status'] as String;
    Color cardBg;
    if (status == 'cancelled') {
      cardBg = cs.brightness == Brightness.dark
          ? const Color(0xFF370902)
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
            // Header row: order info + status chip
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Objednávka ${order['id']}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: cs.secondary,
                          letterSpacing: 0.1,
                          height: 20 / 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order['date'] as String,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: cs.tertiary,
                          letterSpacing: 0.25,
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(cs, status),
              ],
            ),
            const SizedBox(height: 16),
            // Images row + price
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
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: cs.surfaceTint,
                    letterSpacing: 0.5,
                    height: 24 / 16,
                  ),
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
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
              letterSpacing: 0.1,
              height: 20 / 14,
            ),
          ),
        ],
      ),
    );
  }
}
