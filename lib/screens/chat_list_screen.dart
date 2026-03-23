import 'package:flutter/material.dart';
import 'package:eqqu/data/mock_conversations.dart';
import 'package:eqqu/screens/chat_detail_screen.dart';
import 'package:eqqu/theme/app_text_styles.dart';
import 'package:eqqu/widgets/app_header.dart';

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

  static const _conversations = MockConversations.conversations;

  static const _notifications = MockConversations.notifications;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        children: [
          // App bar
          const AppHeader(title: 'Zprávy'),

          // Tab bar
          TabBar(
            controller: _tabController,
            labelColor: cs.surfaceTint,
            unselectedLabelColor: cs.onSurfaceVariant,
            indicatorColor: cs.surfaceTint,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: AppTextStyles.chip(cs.surfaceTint),
            unselectedLabelStyle: AppTextStyles.chip(cs.onSurfaceVariant),
            tabs: const [
              Tab(text: 'Zprávy 1'),
              Tab(text: 'Oznámení 48'),
            ],
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
        final hasUnread = conv.unreadCount > 0;
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatDetailScreen(
                  name: conv.name,
                  initials: conv.initials,
                  avatarImage: conv.avatarAsset,
                  productImage: conv.productImageAsset,
                  productName: conv.productName,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 24, 12),
            child: Row(
              children: [
                // Avatar 64px
                _buildAvatar(cs, conv.avatarAsset, conv.initials, 64),
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
                              conv.name,
                              style: hasUnread
                                  ? AppTextStyles.productTitle(cs.onSurface)
                                  : AppTextStyles.labelMedium(cs.onSurface),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            conv.time,
                            style: AppTextStyles.bodyMedium(cs.onSurfaceVariant),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Message + unread badge row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conv.lastMessage,
                              style: hasUnread
                                  ? AppTextStyles.productBadge(cs.onSurfaceVariant)
                                  : AppTextStyles.bodyMedium(cs.onSurfaceVariant),
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
          cacheWidth: (size * 3).toInt(),
          cacheHeight: (size * 3).toInt(),
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
          style: AppTextStyles.poppins(
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
                      style: AppTextStyles.actionLink(cs.onSurface),
                    ),
                    Text(
                      notif['message']!,
                      style: AppTextStyles.bodyMedium(cs.tertiary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                notif['time']!,
                style: AppTextStyles.labelSmall(cs.tertiary),
              ),
            ],
          ),
        );
      },
    );
  }
}
