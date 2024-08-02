import 'package:flutter/material.dart';
import 'package:posts_app/features/domain/entities/post.dart';
import 'package:posts_app/features/presentation/screens/post_add_update_screen.dart';

class UpdatePostDetailsWidget extends StatelessWidget {
  final Post post;
  const UpdatePostDetailsWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PostAddUpdatePage(
                        isUpdatePost: true,
                        post: post,
                      )));
        },
        icon: const Icon(Icons.edit),
        label: const Text("Edit"),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple));
  }
}
