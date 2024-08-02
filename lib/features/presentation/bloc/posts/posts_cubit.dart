import 'package:bloc/bloc.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/domain/use_cases/get_all_posts.dart';
import 'package:posts_app/features/presentation/bloc/posts/posts_events.dart';
import 'package:posts_app/features/presentation/bloc/posts/posts_state.dart';

import '../../../../../core/strings/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/entities/post.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetALLPostsUseCase getAllPosts;
  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsIntial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(errorMessage: _mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(
        posts: posts,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCacheFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
