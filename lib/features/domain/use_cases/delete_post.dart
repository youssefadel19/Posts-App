import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/domain/repositories/posts_repo.dart';

class DeletePostUseCase {
  final PostsRepo repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int? postId) async {
    return await repository.deletePost(postId!);
  }
}
