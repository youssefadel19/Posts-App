import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/domain/entities/post.dart';
import 'package:posts_app/features/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:posts_app/features/presentation/bloc/add_delete_update_post/add_delete_update_post_events.dart';
import 'package:posts_app/features/presentation/widgets/add_delete_update_widgets/form_submit_button.dart';
import 'package:posts_app/features/presentation/widgets/add_delete_update_widgets/text_form_field_widget.dart';

class FormsWidgets extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormsWidgets({super.key, required this.isUpdatePost, this.post});

  @override
  State<FormsWidgets> createState() => _FormsWidgetsState();
}

class _FormsWidgetsState extends State<FormsWidgets> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdatePost) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
  }

  void validateFormThenUpdatePost() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
          id: widget.isUpdatePost ? widget.post!.id : 0,
          title: titleController.text,
          body: bodyController.text);
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
              multiLines: false,
              name: 'Title',
              controller: titleController,
            ),
            TextFormFieldWidget(
              multiLines: true,
              name: 'Body',
              controller: bodyController,
            ),
            FormSubmitButton(
              onPressed: validateFormThenUpdatePost,
              isUpdatePost: widget.isUpdatePost,
            )
          ],
        ));
  }
}
