import 'package:flutter/material.dart';
import 'package:posts_app/features/domain/entities/post.dart';
import 'package:posts_app/features/presentation/widgets/post_details_widgets/post_details_widget.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;
  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Post Details',
          textAlign: TextAlign.center,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: PostDetailsWidget(post: post),
      ),
    );
  }
}
