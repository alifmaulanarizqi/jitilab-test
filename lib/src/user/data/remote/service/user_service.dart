import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../response/user_response.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio) => _UserService(dio);

  @GET('/users')
  Future<List<UserResponse>> getListUser({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('is_male') bool? isMale,
    @Query('name') String? keyword,
  });
}