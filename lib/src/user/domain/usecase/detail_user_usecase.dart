import 'package:either_dart/either.dart';
import 'package:jitilab_test/src/user/data/remote/response/user_response.dart';

import '../../../../core/utils/typedef_util.dart';
import '../../data/repository/user_repository.dart';

class DetailUserUseCase {
  final UserRepository _repository;
  DetailUserUseCase(this._repository);

  FutureOrError<UserResponse> execute({
    int? id,
  }) {
    return _repository.getUserById(id: id ?? 0).mapRight((response) {
      return response;
    });
  }
}