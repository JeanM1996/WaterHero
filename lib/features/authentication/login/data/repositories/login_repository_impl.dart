import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';
import 'package:waterhero/features/authentication/login/data/data_sources/login_data_source.dart';
import 'package:waterhero/features/authentication/login/domain/repositories/login_repository.dart';

final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepositoryImpl(ref.read(loginDataSourceProvider)),
);

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this.dataSource);

  final LoginDataSource dataSource;

  @override
  Future<Either<CommonFailure, bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dataSource.login(email, password);
      if (response.success!) {
        return const Right(true);
      }
      throw Exception();
    } catch (e) {
      return left(
        const CommonFailure.server(code: 500, message: 'Bad request'),
      );
    }
  }

  @override
  Future<Either<CommonFailure, String>> getUserInfoCurrentSession() async {
    try {
      final response = await dataSource.getUserInfoCurrentSession();

      if (response.success!) {
        final data = jsonDecode(response.body!);
        final code = data[0]['code'];

        return Right(code);
      }
      throw Exception();
    } catch (e) {
      print('error $e');
      return left(
        const CommonFailure.server(code: 500, message: 'Bad request'),
      );
    }
  }
}
