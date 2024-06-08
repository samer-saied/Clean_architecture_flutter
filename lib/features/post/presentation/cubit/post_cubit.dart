import 'package:clean_architecture_flutter/features/post/data/models/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/databases/api/dio_consumer.dart';
import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/params/params.dart';
import '../../data/datasources/post_local_data_source.dart';
import '../../data/datasources/post_remote_data_source.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/usecases/get_post.dart';
import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  eitherFailureOrPost(int id) async {
    emit(GetPostLoading());
    final failureOrPost = await GetPost(
      repository: PostRepositoryImpl(
          remoteDataSource: PostRemoteDataSource(api: DioConsumer(dio: Dio())),
          localDataSource: PostLocalDataSource(cache: CacheHelper()),
          networkInfo: NetworkInfoImpl(InternetConnectionChecker())),
    ).call(
      params: PostParams(
        id: id.toString(),
      ),
    );

    failureOrPost.fold(
      (failure) => emit(GetPostFailure(errMessage: failure.errMessage)),
      (post) => emit(GetPostSuccessfully(post: post as PostModel)),
    );
  }

  eitherFailureOrAllPost() async {
    emit(GetPostLoading());
    final failureOrPost = await GetAllPost(
      repository: PostRepositoryImpl(
          remoteDataSource: PostRemoteDataSource(api: DioConsumer(dio: Dio())),
          localDataSource: PostLocalDataSource(cache: CacheHelper()),
          networkInfo: NetworkInfoImpl(InternetConnectionChecker())),
    ).call();

    failureOrPost.fold(
      (failure) => emit(GetPostFailure(errMessage: failure.errMessage)),
      (posts) => emit(GetAllPostsSuccessfully(posts: posts as List<PostModel>)),
    );
  }
}
