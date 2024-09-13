class Post {
  final int id;
  final String name;
  final String postType;
  final String title;
  final String description;
  final String userid;
  final String? imageUrl;

  Post({
    required this.name,
    required this.id,
    required this.postType,
    required this.title,
    required this.description,
    required this.userid,
    this.imageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['ID'] as int, // Ensure the correct field name and type
      name: json['name'] as String, // Ensure the correct field
      postType: json['post_type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      userid: json['userid'] as String,
      imageUrl: json['image_url'] as String?,
    );
  }
}
