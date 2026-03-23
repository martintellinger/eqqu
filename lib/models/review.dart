class Review {
  final String name;
  final String avatar;
  final String country;
  final int rating;
  final String time;
  final String text;

  const Review({
    required this.name,
    required this.avatar,
    required this.country,
    required this.rating,
    required this.time,
    required this.text,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    name: json['name'] as String? ?? '',
    avatar: json['avatar'] as String? ?? '',
    country: json['country'] as String? ?? '',
    rating: json['rating'] as int? ?? 0,
    time: json['time'] as String? ?? '',
    text: json['text'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'avatar': avatar,
    'country': country,
    'rating': rating,
    'time': time,
    'text': text,
  };
}
