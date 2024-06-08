import 'package:clean_architecture_flutter/features/post/presentation/cubit/post_cubit.dart';
import 'package:clean_architecture_flutter/features/post/presentation/screens/all_posts_screen.dart';
import 'package:clean_architecture_flutter/features/post/presentation/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/databases/cache/cache_helper.dart';
import 'features/user/presentation/cubit/user_cubit.dart';
import 'features/user/presentation/screens/user_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //  BlocProvider(
  //                       create: (context) =>
  //                           PostCubit()..eitherFailureOrPost(1),

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("HomePage"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                  child: const Text("Post Screen"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostScreen(
                                  PostId: 1,
                                )));
                  }),
              OutlinedButton(
                  child: const Text("Posts Screen"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      PostCubit()..eitherFailureOrAllPost(),
                                  child: AllPostsScreen(),
                                )));
                  }),
              OutlinedButton(
                  child: const Text("Users Screen"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      UserCubit()..eitherFailureOrUser(1),
                                  child: UserScreen(),
                                )));
                  }),
            ],
          ),
        ));
  }
}
