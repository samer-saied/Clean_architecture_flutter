import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/databases/api/dio_consumer.dart';
import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/params/params.dart';
import '../../data/datasources/user_local_data_source.dart';
import '../../data/datasources/user_remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/usecases/get_user.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  eitherFailureOrUser(int id) async {
    emit(GetUserLoading());
    final failureOrUser = await GetUser(
      repository: UserRepositoryImpl(
          remoteDataSource: UserRemoteDataSource(api: DioConsumer(dio: Dio())),
          localDataSource: UserLocalDataSource(cache: CacheHelper()),
          networkInfo: NetworkInfoImpl(InternetConnectionChecker())),
    ).call(
      params: UserParams(
        id: id.toString(),
      ),
    );

    failureOrUser.fold(
      (failure) => emit(GetUserFailure(errMessage: failure.errMessage)),
      (user) => emit(GetUserSuccessfully(user: user)),
    );
  }
}
