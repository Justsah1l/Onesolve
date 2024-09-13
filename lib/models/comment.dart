import 'package:solve/models/post.dart';

class Comment {
  final int id;
  final int postId;
  final String userId;
  final String message;
  final Post? post;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.message,
    this.post,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['ID'] ?? 0,
      postId: json['post_id'] ?? 0,
      userId: json['userid'] ?? '',
      message: json['message'] ?? '',
      post: json['Post'] != null ? Post.fromJson(json['Post']) : null,
    );
  }
}
