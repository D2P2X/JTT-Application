class User {
  final String id;
  final String name;
  final String avatarUrl;
  final int rank;

  User({required this.id, required this.name, required this.avatarUrl, required this.rank});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      rank: json['rank'],
    );
  }
}