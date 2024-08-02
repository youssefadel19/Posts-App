import 'package:flutter/material.dart';
import 'package:posts_app/features/domain/entities/post.dart';
import 'package:posts_app/features/presentation/widgets/post_details_widgets/delete_post_details_widget.dart';
import 'package:posts_app/features/presentation/widgets/post_details_widgets/update_post_details_widget.dart';

class PostDetailsWidget extends StatelessWidget {
  final Post post;
  const PostDetailsWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: const TextStyle(fontSize: 16),
          ),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostDetailsWidget(post: post),
              DeletePostButtonWidget(postId: post.id!)
            ],
          )
        ],
      ),
    );
  }
}
