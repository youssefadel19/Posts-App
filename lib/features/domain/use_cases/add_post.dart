import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/domain/entities/post.dart';
import 'package:posts_app/features/domain/repositories/posts_repo.dart';

class AddPostUseCase {
  final PostsRepo repository;

  AddPostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
