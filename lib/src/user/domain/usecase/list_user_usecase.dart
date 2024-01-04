import 'package:either_dart/either.dart';

import '../../../../core/utils/typedef_util.dart';
import '../../data/remote/response/user_response.dart';
import '../../data/repository/user_repository.dart';

class ListUserUseCase {
  final UserRepository _repository;

  ListUserUseCase(this._repository);

  FutureOrError<List<UserResponse>> execute({
    int? page,
    int? limit,
    bool? isMale,
  }) async {
    return _repository.getListUser(
      page: page,
      limit: limit,
      isMale: isMale
    ).mapRight((response) {
      return response;
    });
  }
}