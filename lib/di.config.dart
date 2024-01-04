// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:jitilab_test/core/data/local/app_preferences.dart' as _i4;
import 'package:jitilab_test/core/di/local_module.dart' as _i10;
import 'package:jitilab_test/core/di/network_module.dart' as _i11;
import 'package:jitilab_test/src/user/data/remote/service/user_service.dart'
    as _i6;
import 'package:jitilab_test/src/user/data/repository/user_repository.dart'
    as _i7;
import 'package:jitilab_test/src/user/data/repository/user_repository_impl.dart'
    as _i13;
import 'package:jitilab_test/src/user/di/user_di_module.dart' as _i12;
import 'package:jitilab_test/src/user/domain/usecase/detail_user_usecase.dart'
    as _i8;
import 'package:jitilab_test/src/user/domain/usecase/list_user_usecase.dart'
    as _i9;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final localModule = _$LocalModule();
    final networkModule = _$NetworkModule();
    final employeeDiModule = _$EmployeeDiModule(this);
    await gh.singletonAsync<_i3.SharedPreferences>(
      () => localModule.prefs,
      preResolve: true,
    );
    gh.singleton<String>(
      networkModule.baseUrl,
      instanceName: 'base_url',
    );
    gh.singleton<_i4.AppPreferences>(
        localModule.appPreferences(gh<_i3.SharedPreferences>()));
    gh.singleton<_i5.Dio>(
        networkModule.dio(gh<String>(instanceName: 'base_url')));
    gh.singleton<_i6.UserService>(employeeDiModule.userService(gh<_i5.Dio>()));
    gh.singleton<_i7.UserRepository>(employeeDiModule.userRepository);
    gh.factory<_i8.DetailUserUseCase>(
        () => employeeDiModule.detailUserUseCase(gh<_i7.UserRepository>()));
    gh.factory<_i9.ListUserUseCase>(
        () => employeeDiModule.listUserUseCase(gh<_i7.UserRepository>()));
    return this;
  }
}

class _$LocalModule extends _i10.LocalModule {}

class _$NetworkModule extends _i11.NetworkModule {}

class _$EmployeeDiModule extends _i12.EmployeeDiModule {
  _$EmployeeDiModule(this._getIt);

  final _i1.GetIt _getIt;

  @override
  _i13.UserRepositoryImpl get userRepository =>
      _i13.UserRepositoryImpl(_getIt<_i6.UserService>());
}
