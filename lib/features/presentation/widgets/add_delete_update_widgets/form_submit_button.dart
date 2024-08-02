import 'package:flutter/material.dart';

class FormSubmitButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;
  const FormSubmitButton(
      {super.key, required this.onPressed, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: isUpdatePost ? const Icon(Icons.edit) : const Icon(Icons.add),
        label: Text(isUpdatePost ? "update" : "Add"),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple));
  }
}
