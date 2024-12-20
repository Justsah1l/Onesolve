import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:solve/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:solve/widgets/detailpost.dart';

class Ownposts extends StatefulWidget {
  const Ownposts({super.key});

  @override
  State<Ownposts> createState() => _OwnpostsState();
}

class _OwnpostsState extends State<Ownposts> {
  final ip = dotenv.env['IP'] ?? '';
  List<Post> posts = [];
  User? user = FirebaseAuth.instance.currentUser;
  String? userId;
  Map<String, Color> problemTypeColors = {
    "Technical Issues": Colors.black,
    "Product Recommendations": Colors.blue,
    "Health & Wellness": Colors.cyan,
    "Career Advice": Colors.orange,
    "Education & Learning": Colors.purple,
    "Personal Finance": Colors.yellow,
    "Other": Colors.grey,
  };
  void _getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      userId = user?.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('$ip/myposts?userid=$userId'),
      );
      print("posts response");
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Post> fetchedPosts = jsonData
            .map((data) {
              try {
                return Post.fromJson(data);
              } catch (e) {
                print('Error parsing post: $e');
                return null;
              }
            })
            .whereType<Post>()
            .toList();

        setState(() {
          posts = fetchedPosts;
        });
      } else {
        print('Failed to load posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const int maxLength = 200;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Posts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            SizedBox(height: 20),
            Expanded(
              child: posts.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        final bool isLongDescription =
                            post.description.length > maxLength;
                        final String truncatedDescription = isLongDescription
                            ? '${post.description.substring(0, maxLength)}...'
                            : post.description;
                        final Color problemColor =
                            problemTypeColors[post.postType] ?? Colors.grey;
                        final bool hasImage =
                            post.imageUrl != null && post.imageUrl!.isNotEmpty;
                        return GestureDetector(
                          onTap: () {
                            int postid = post.id;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Detailpost(postId: postid),
                                ));
                          },
                          child: Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 5),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 1,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(post.name),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 7),
                                            decoration: BoxDecoration(
                                                color: problemColor,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Text(
                                              post.postType,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        post.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      hasImage
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                post.imageUrl!,
                                                height: 200,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: truncatedDescription,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  if (isLongDescription)
                                                    TextSpan(
                                                      text: ' more',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 228, 64, 64),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                )),
                          ),
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
