import '../../../../core/utils/typedef_util.dart';
import '../remote/response/user_response.dart';

abstract class UserRepository {
  FutureOrError<List<UserResponse>> getListUser({
    int? page,
    int? limit,
  });
}