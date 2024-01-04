import 'package:jitilab_test/src/user/data/repository/user_repository.dart';

import '../../../../core/utils/future_util.dart';
import '../../../../core/utils/typedef_util.dart';
import '../remote/response/user_response.dart';
import '../remote/service/user_service.dart';

class UserRepositoryImpl extends UserRepository {
  final UserService userService;

  UserRepositoryImpl(this.userService);

  @override
  FutureOrError<List<UserResponse>> getListUser({
    int? page,
    int? limit,
    bool? isMale,
    String? keyword,
  }) {
    return callOrError(() => userService.getListUser(
      page: page,
      limit: limit,
      isMale: isMale,
      keyword: keyword
    ));
  }

  @override
  FutureOrError<UserResponse> getUserById({
    int? id
  }) {
    return callOrError(() => userService.getUserById(id: id));
  }
}