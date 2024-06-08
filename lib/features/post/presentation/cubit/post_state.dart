import '../../data/models/post_model.dart';

class PostState {}

final class PostInitial extends PostState {}

final class UpdateSLider extends PostState {}

final class GetPostSuccessfully extends PostState {
  final PostModel post;

  GetPostSuccessfully({required this.post});
}

final class GetAllPostsSuccessfully extends PostState {
  final List<PostModel> posts;

  GetAllPostsSuccessfully({required this.posts});
}

final class GetPostLoading extends PostState {}

final class GetPostFailure extends PostState {
  final String errMessage;

  GetPostFailure({required this.errMessage});
}
