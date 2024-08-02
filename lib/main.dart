import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:posts_app/features/presentation/bloc/posts/posts_cubit.dart';
import 'package:posts_app/features/presentation/bloc/posts/posts_events.dart';
import 'package:posts_app/features/presentation/screens/posts_screen.dart';
import 'depedency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(),
            title: 'Posts App',
            home: const PostsScreen()));
  }
}
