// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../network/api_client.dart' as _i3;
import '../network/services/camera/camera_service.dart' as _i5;
import '../network/services/camera/camera_service_interface.dart' as _i4;
import '../network/services/user/user_service.dart' as _i7;
import '../network/services/user/user_service_interface.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ApiClient>(_i3.ApiClient());
  gh.lazySingleton<_i4.CameraServiceInterface>(
      () => _i5.CameraService(get<_i3.ApiClient>()));
  gh.lazySingleton<_i6.UserServiceInterface>(
      () => _i7.UserService(get<_i3.ApiClient>()));
  return get;
}
