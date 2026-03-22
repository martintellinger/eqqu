class Conversation {
  final String name;
  final String initials;
  final String avatarAsset;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String productImageAsset;
  final String productName;

  const Conversation({
    required this.name,
    required this.initials,
    this.avatarAsset = '',
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.productImageAsset = '',
    this.productName = '',
  });
}
