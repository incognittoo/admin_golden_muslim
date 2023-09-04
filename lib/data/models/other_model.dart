class Other {
  final String id;
  final String name;
  final String photo;
  final String? description;
  final String? note;

  Other({
    this.description,
    this.note,
    required this.name,
    required this.photo,
    required this.id,
  });

  factory Other.fromJson(Map<String, dynamic> json, String id) {
    try {
      return Other(
        id: id,
        name: json['name'],
        photo: json['photo'],
        description: json['description'],
        note: json['note'],
      );
    } catch (e) {
      print('Error creating Other from JSON: $e');
      rethrow;
    }
  }
}
