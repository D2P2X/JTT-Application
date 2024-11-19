class Game {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl, // 기본값을 설정하거나 유효한 URL을 제공
  });
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/150', // 기본 이미지 URL 설정
    );
  }
}