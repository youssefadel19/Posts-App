import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/presentation/bloc/posts/posts_cubit.dart';
import 'package:posts_app/features/presentation/bloc/posts/posts_events.dart';
import 'package:posts_app/features/presentation/bloc/posts/posts_state.dart';
import 'package:posts_app/features/presentation/screens/post_add_update_screen.dart';
import 'package:posts_app/features/presentation/widgets/home_widgets/message_display_widget.dart';
import 'package:posts_app/features/presentation/widgets/home_widgets/posts_list_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Posts'),
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.errorMessage);
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: PostsListWidget(posts: state.posts));
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }

  Future<void> _onRefresh(context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const PostAddUpdatePage(isUpdatePost: false)));
      },
      backgroundColor: Colors.deepPurple,
      child: const Icon(Icons.add),
    );
  }
}
