import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/data/datasources/post_remote_data_source.dart';
import 'package:posts_app/features/data/models/post_model.dart';
import 'package:posts_app/features/domain/entities/post.dart';
import 'package:posts_app/features/domain/repositories/posts_repo.dart';

import '../datasources/post_local_datasource.dart';

class PostRepositoryImpl implements PostsRepo{

  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl( {required this.networkInfo,required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async{
    final PostModel postModel=PostModel( title: post.title, body: post.body);
    return getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId)async {
    return getMessage(() => remoteDataSource.deletePost(postId));
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async{
      if(await networkInfo.isConnected){
        try{
         final remotePosts= await remoteDataSource.getAllPosts();
         localDataSource.cachPosts(remotePosts);
         return right(remotePosts);
        }on ServerException{
          return left(ServerFailure());
        }

      }
      else{
        try{
         final localPosts= await localDataSource.getCachedPosts();
         return right(localPosts);
        }on EmptyCachException{
          return left(EmptyCacheFailure());
        }
      }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async{
    final PostModel postModel=PostModel(id: post.id, title: post.title, body: post.body);
   return getMessage(() => remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> getMessage(Future<Unit>Function()deleteOrUpdateOrAdd)async{
    if(await networkInfo.isConnected){
      try{
        await deleteOrUpdateOrAdd;
        return right(unit);
      }on ServerException{
        return left(ServerFailure());
      }
    }
    else{
      return left(OfflineFailure());
    }
  }
}