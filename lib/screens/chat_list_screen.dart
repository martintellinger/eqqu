import 'package:flutter/material.dart';
import 'package:eqqu/screens/chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static const _conversations = [
    {
      'name': 'Emma Novak',
      'initials': 'EN',
      'avatar': 'assets/images/avatar_1.png',
      'message': 'Ahoj, je sedlo ještě dostupné?',
      'time': '10:30',
      'unread': '2',
      'image': 'assets/images/product_01.png',
      'productName': 'Black GP type saddle',
    },
    {
      'name': 'Jan Dvořák',
      'initials': 'JD',
      'avatar': 'assets/images/avatar_2.png',
      'message': 'Děkuji za rychlou odpověď!',
      'time': '9:15',
      'unread': '',
      'image': 'assets/images/product_02.png',
      'productName': 'Blue Comfort type saddle',
    },
    {
      'name': 'Petra Svobodová',
      'initials': 'PS',
      'avatar': 'assets/images/avatar_3.png',
      'message': 'Můžete poslat více fotek?',
      'time': 'Včera',
      'unread': '1',
      'image': 'assets/images/product_03.png',
      'productName': 'Red Racing type saddle',
    },
    {
      'name': 'Martin Horák',
      'initials': 'MH',
      'avatar': 'assets/images/avatar_4.png',
      'message': 'Dobrý den, mám zájem o uzdečku.',
      'time': 'Včera',
      'unread': '',
      'image': 'assets/images/product_07.png',
      'productName': 'Fleece bandáže Kentucky',
    },
    {
      'name': 'Lucie Králová',
      'initials': 'LK',
      'avatar': 'assets/images/avatar_5.png',
      'message': 'Posílám platbu dnes.',
      'time': 'Po',
      'unread': '',
      'image': 'assets/images/product_8.png',
      'productName': 'Deka Eskadron Classic',
    },
    {
      'name': 'Tomáš Němec',
      'initials': 'TN',
      'avatar': '',
      'message': 'Je možná sleva?',
      'time': 'Po',
      'unread': '3',
      'image': 'assets/images/product_9.png',
      'productName': 'Třmeny Flex-On',
    },
  ];

  static const _notifications = [
    {
      'title': 'Nový inzerát v kategorii Koně',
      'message': 'Podívejte se na nové sedlo od Emma Novak',
      'time': '10:30',
    },
    {
      'title': 'Snížení ceny',
      'message': 'Blue Comfort type saddle je nyní za 120 €',
      'time': 'Včera',
    },
    {
      'title': 'Hodnocení',
      'message': 'Jan Dvořák vám dal hodnocení 5 hvězdiček',
      'time': 'Po',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Zprávy',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                  height: 36 / 28,
                ),
              ),
            ),
          ),

          // Tab bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabBar(
              controller: _tabController,
              labelColor: cs.onSurface,
              unselectedLabelColor: cs.tertiary,
              indicatorColor: cs.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              tabs: const [
                Tab(text: 'Zprávy'),
                Tab(text: 'Oznámení'),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMessagesList(cs),
                _buildNotificationsList(cs),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList(ColorScheme cs) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: _conversations.length,
      separatorBuilder: (_, __) => Divider(
        color: cs.outline,
        height: 1,
        indent: 96,
      ),
      itemBuilder: (context, index) {
        final conv = _conversations[index];
        final hasUnread = conv['unread']!.isNotEmpty;
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatDetailScreen(
                  name: conv['name']!,
                  initials: conv['initials']!,
                  avatarImage: conv['avatar']!,
                  productImage: conv['image']!,
                  productName: conv['productName']!,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 24, 12),
            child: Row(
              children: [
                // Avatar 64px
                _buildAvatar(cs, conv['avatar']!, conv['initials']!, 64),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + time row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conv['name']!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: cs.onSurface,
                                letterSpacing: 0.15,
                                height: 24 / 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            conv['time']!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: cs.onSurfaceVariant,
                              letterSpacing: 0.25,
                              height: 20 / 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Message + unread badge row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conv['message']!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w400,
                                color: cs.onSurfaceVariant,
                                letterSpacing: 0.25,
                                height: 20 / 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (hasUnread)
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: cs.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatar(ColorScheme cs, String avatarPath, String initials, double size) {
    if (avatarPath.isNotEmpty) {
      return ClipOval(
        child: Image.asset(
          avatarPath,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: cs.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: size * 0.3,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsList(ColorScheme cs) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _notifications.length,
      separatorBuilder: (_, __) => Divider(color: cs.outline, height: 1, indent: 16, endIndent: 16),
      itemBuilder: (context, index) {
        final notif = _notifications[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.notifications_outlined, size: 20, color: cs.onSurface),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notif['title']!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                        height: 20 / 14,
                      ),
                    ),
                    Text(
                      notif['message']!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: cs.tertiary,
                        height: 20 / 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                notif['time']!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: cs.tertiary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
