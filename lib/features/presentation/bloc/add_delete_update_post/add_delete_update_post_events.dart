import 'package:equatable/equatable.dart';
import 'package:posts_app/features/domain/entities/post.dart';

abstract class AddDeleteUpdatePostEvent extends Equatable {
  const AddDeleteUpdatePostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostEvent {
  final Post post;

  const AddPostEvent({required this.post});

  List<Object> get props => [];
}

class UpdatePostEvent extends AddDeleteUpdatePostEvent {
  final Post post;

  const UpdatePostEvent({required this.post});

  List<Object> get props => [];
}

class DeletePostEvent extends AddDeleteUpdatePostEvent {
  final int? postId;

  const DeletePostEvent({required this.postId});

  List<Object> get props => [];
}
