import 'package:clean_architecture_flutter/features/post/presentation/cubit/post_cubit.dart';
import 'package:clean_architecture_flutter/features/post/presentation/cubit/post_state.dart';
import 'package:clean_architecture_flutter/features/user/presentation/widgets/landing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatelessWidget {
  final int PostId;
  const PostScreen({super.key, required this.PostId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit()..eitherFailureOrPost(PostId),
      child: BlocConsumer<PostCubit, PostState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Posts"),
              ),
              body: state is GetPostSuccessfully
                  ? ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          margin: const EdgeInsets.all(8.0),
                          width: MediaQuery.sizeOf(context).width,
                          child: ListTile(
                            title: Text(state.post.title),
                            subtitle: Text(state.post.body),
                            leading: Text(state.post.id.toString()),
                          ),
                        ),
                      ],
                    )
                  : state is GetPostFailure
                      ? Center(child: Text(state.errMessage))
                      : const Center(child: CircularProgressIndicator()),
            );
          },
          listener: (context, state) {}),
    );
  }
}
