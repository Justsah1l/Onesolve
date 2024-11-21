import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:solve/models/comment.dart';

class Detailpost extends StatefulWidget {
  final int postId;
  Detailpost({Key? key, required this.postId}) : super(key: key);

  @override
  State<Detailpost> createState() => _DetailpostState();
}

class _DetailpostState extends State<Detailpost> {
  TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];
  final ip = dotenv.env['IP'] ?? '';

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  // Function to fetch comments for the post
  Future<void> fetchComments() async {
    final response =
        await http.get(Uri.parse('$ip/comments?post_id=${widget.postId}'));

    if (response.statusCode == 200) {
      print("res ------------------------------------ ");
      print(response.body);
      List jsonResponse = json.decode(response.body);
      setState(() {
        comments = jsonResponse.map((data) => Comment.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // Function to submit a comment
  Future<void> submitComment() async {
    final response = await http.post(
      Uri.parse('$ip/addcomment'),
      body: {
        'post_id': widget.postId.toString(),
        'userid': 'user123', // You can change this to the actual user ID
        'message': commentController.text,
      },
    );

    if (response.statusCode == 201) {
      // Clear the text field and refresh comments after submitting
      commentController.clear();
      fetchComments();
    } else {
      throw Exception('Failed to submit comment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text("Post ID: ${widget.postId}", style: TextStyle(fontSize: 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.network(
                    'https://via.placeholder.com/150', // Placeholder if no photo URL
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Posted by name here",
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(height: 16),
            Text(
              "A title for example with a long sentence for a long example to see if UI looks good",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "A description for example with a long sentence for a long example to see if UI looks good goodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgoodgood",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 16),
            // TextField to enter a comment
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: "Enter your comment",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // Button to submit comment
            ElevatedButton(
              onPressed: () {
                submitComment();
              },
              child: Text("Submit Comment"),
            ),
            SizedBox(height: 16),

            // Display comments
            Expanded(
              child: comments.isEmpty
                  ? Text("No comments yet")
                  : ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(comments[index].message),
                          subtitle: Text("User: ${comments[index].userId}"),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
