import 'package:clean_architecture_flutter/features/post/presentation/cubit/post_cubit.dart';
import 'package:clean_architecture_flutter/features/post/presentation/cubit/post_state.dart';
import 'package:clean_architecture_flutter/features/post/presentation/screens/post_screen.dart';
import 'package:clean_architecture_flutter/features/user/presentation/widgets/landing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPostsScreen extends StatelessWidget {
  const AllPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Posts"),
            ),
            body: state is GetAllPostsSuccessfully
                ? ListView(
                    children: state.posts
                        .map((post) => InkWell(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostScreen(
                                              PostId: post.id,
                                            )))
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                margin: const EdgeInsets.all(8.0),
                                child: Text("${post.id}- ${post.title}"),
                              ),
                            ))
                        .toList())
                : state is GetPostFailure
                    ? Center(child: Text(state.errMessage))
                    : const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {});
  }
}
