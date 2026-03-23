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

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    name: json['name'] as String? ?? '',
    initials: json['initials'] as String? ?? '',
    avatarAsset: json['avatarAsset'] as String? ?? '',
    lastMessage: json['lastMessage'] as String? ?? '',
    time: json['time'] as String? ?? '',
    unreadCount: json['unreadCount'] as int? ?? 0,
    productImageAsset: json['productImageAsset'] as String? ?? '',
    productName: json['productName'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'initials': initials,
    'avatarAsset': avatarAsset,
    'lastMessage': lastMessage,
    'time': time,
    'unreadCount': unreadCount,
    'productImageAsset': productImageAsset,
    'productName': productName,
  };
}
