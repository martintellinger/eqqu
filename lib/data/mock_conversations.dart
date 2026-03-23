import 'package:eqqu/models/conversation.dart';
import 'package:eqqu/models/review.dart';

/// Centralised mock conversation, notification, and review data.
class MockConversations {
  MockConversations._();

  static const conversations = [
    Conversation(
      name: 'Emma Novak',
      initials: 'EN',
      avatarAsset: 'assets/images/avatar_1.png',
      lastMessage: 'Ahoj, je sedlo ještě dostupné?',
      time: '10:30',
      unreadCount: 2,
      productImageAsset: 'assets/images/product_01.png',
      productName: 'Black GP type saddle',
    ),
    Conversation(
      name: 'Petra Svobodová',
      initials: 'PS',
      avatarAsset: 'assets/images/avatar_3.png',
      lastMessage: 'Můžete poslat více fotek?',
      time: 'Včera',
      unreadCount: 1,
      productImageAsset: 'assets/images/product_03.png',
      productName: 'Red Racing type saddle',
    ),
    Conversation(
      name: 'Tomáš Němec',
      initials: 'TN',
      lastMessage: 'Je možná sleva?',
      time: 'Po',
      unreadCount: 3,
      productImageAsset: 'assets/images/product_9.png',
      productName: 'Třmeny Flex-On',
    ),
    Conversation(
      name: 'Jan Dvořák',
      initials: 'JD',
      avatarAsset: 'assets/images/avatar_2.png',
      lastMessage: 'Děkuji za rychlou odpověď!',
      time: '9:15',
      productImageAsset: 'assets/images/product_02.png',
      productName: 'Blue Comfort type saddle',
    ),
    Conversation(
      name: 'Martin Horák',
      initials: 'MH',
      avatarAsset: 'assets/images/avatar_4.png',
      lastMessage: 'Dobrý den, mám zájem o uzdečku.',
      time: 'Včera',
      productImageAsset: 'assets/images/product_07.png',
      productName: 'Fleece bandáže Kentucky',
    ),
    Conversation(
      name: 'Lucie Králová',
      initials: 'LK',
      avatarAsset: 'assets/images/avatar_5.png',
      lastMessage: 'Posílám platbu dnes.',
      time: 'Po',
      productImageAsset: 'assets/images/product_8.png',
      productName: 'Deka Eskadron Classic',
    ),
  ];

  static const reviews = [
    Review(
      name: 'Anna K.',
      avatar: 'assets/images/avatar_2.png',
      country: 'Česká republika',
      rating: 5,
      time: 'před 2 dny',
      text: 'Skvělá komunikace a rychlé odeslání. Sedlo odpovídá popisu, jsem velmi spokojená!',
    ),
    Review(
      name: 'Markéta P.',
      avatar: 'assets/images/avatar_3.png',
      country: 'Slovensko',
      rating: 4,
      time: 'před 5 dny',
      text: 'Vše v pořádku, jen doručení trvalo trochu déle. Jinak super prodejce.',
    ),
    Review(
      name: 'Jan N.',
      avatar: 'assets/images/avatar_4.png',
      country: 'Česká republika',
      rating: 5,
      time: 'před 1 týdnem',
      text: 'Výborná kvalita, přesně jak bylo popsáno. Doporučuji!',
    ),
    Review(
      name: 'Petra S.',
      avatar: 'assets/images/avatar_5.png',
      country: 'Česká republika',
      rating: 3,
      time: 'před 2 týdny',
      text: 'Produkt ok, ale komunikace mohla být lepší. Odpovědi přicházely se zpožděním.',
    ),
  ];

  static const notifications = [
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
}
