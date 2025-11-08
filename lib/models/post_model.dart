class PostModel {
  final int albumId;
  final int id;
  final String title;
  String profileUrl;
  String thumbnailUrl;

  PostModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.profileUrl,
    required this.thumbnailUrl,
  });

  // Factory constructor to create a PostModel from JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      profileUrl: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  // Method to convert PostModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': profileUrl,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
