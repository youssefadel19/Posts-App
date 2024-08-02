import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/data/datasources/post_local_datasource.dart';
import 'package:posts_app/features/data/datasources/post_remote_data_source.dart';
import 'package:posts_app/features/data/repositories/post_reposiotry_impl.dart';
import 'package:posts_app/features/domain/repositories/posts_repo.dart';
import 'package:posts_app/features/domain/use_cases/add_post.dart';
import 'package:posts_app/features/domain/use_cases/delete_post.dart';
import 'package:posts_app/features/domain/use_cases/get_all_posts.dart';
import 'package:posts_app/features/domain/use_cases/update_post.dart';
import 'package:posts_app/features/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:posts_app/features/presentation/bloc/posts/posts_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


final sl= GetIt.instance;
Future<void> init()async{

  //bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: sl(),
      deletePost: sl(),
      updatePost: sl()));

//usecases
  sl.registerLazySingleton(() => GetALLPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

  //repository
  sl.registerLazySingleton<PostsRepo>(() => PostRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource:sl(),
      localDataSource: sl()));


  //dataSources
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(sharedPreferences: sl()));


  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoimpl(sl()));

  //EXTERNAL
  final sharedPrefrences=await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefrences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}