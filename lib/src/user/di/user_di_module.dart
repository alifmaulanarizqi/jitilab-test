import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../data/remote/service/user_service.dart';
import '../data/repository/user_repository.dart';
import '../data/repository/user_repository_impl.dart';
import '../domain/usecase/list_user_usecase.dart';

@module
abstract class EmployeeDiModule {
  @singleton
  UserService userService(Dio dio) => UserService(dio);

  @Singleton(as: UserRepository)
  UserRepositoryImpl get userRepository;

  @injectable
  ListUserUseCase listEmployeeUseCase(UserRepository repository) =>
      ListUserUseCase(repository);
}