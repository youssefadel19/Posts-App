import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/util/snackbar.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:posts_app/features/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:posts_app/features/presentation/screens/posts_screen.dart';
import 'package:posts_app/features/presentation/widgets/post_details_widgets/delete_dialog_widget.dart';

class DeletePostButtonWidget extends StatelessWidget {
  final int postId;
  const DeletePostButtonWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () => deleteDialog(context, postId),
        icon: const Icon(Icons.delete),
        label: const Text("Delete"),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent));
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeletDialogWidget(postId: postId);
          }, listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PostsScreen()));
            } else if (state is ErrorAddDeleteUpdatePostState) {
              Navigator.of(context).pop();
              SnackBarMessage().showErrorSnackBar(
                  message: state.errorMessage, context: context);
            }
          });
        });
  }
}
