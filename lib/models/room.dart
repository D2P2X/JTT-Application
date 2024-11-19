class Room {
  final String id;
  final String name;
  final int participants;
  final int maxParticipants;

  Room({
    required this.id,
    required this.name,
    required this.participants,
    required this.maxParticipants,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      participants: json['participants'],
      maxParticipants: json['maxParticipants'],
    );
  }
}