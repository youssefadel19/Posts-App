import 'package:equatable/equatable.dart';
import 'package:posts_app/features/domain/entities/post.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object> get props => [];
}

class PostsIntial extends PostsState {}

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  final List<Post> posts;

  const LoadedPostsState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends PostsState {
  final String errorMessage;

  const ErrorPostsState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
