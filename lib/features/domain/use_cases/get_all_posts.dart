import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/domain/entities/post.dart';
import 'package:posts_app/features/domain/repositories/posts_repo.dart';

class GetALLPostsUseCase {
  final PostsRepo repoisotry;

  GetALLPostsUseCase(this.repoisotry);

  Future<Either<Failure, List<Post>>> call() async {
    return await repoisotry.getAllPosts();
  }
}
