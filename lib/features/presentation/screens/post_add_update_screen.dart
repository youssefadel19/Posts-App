import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/util/snackbar.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/domain/entities/post.dart';
import 'package:posts_app/features/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:posts_app/features/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:posts_app/features/presentation/screens/posts_screen.dart';
import 'package:posts_app/features/presentation/widgets/add_delete_update_widgets/forms_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          isUpdatePost ? 'Edit Post' : 'Add Post',
          textAlign: TextAlign.center,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PostsScreen()));
            } else if (state is ErrorAddDeleteUpdatePostState) {
              SnackBarMessage().showErrorSnackBar(
                  message: state.errorMessage, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const LoadingWidget();
            }

            return FormsWidgets(
                isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
          },
        ),
      ),
    );
  }
}
