import "package:device_info_plus/device_info_plus.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get_it/get_it.dart";
import "package:dio/dio.dart";
import "package:lilit/api/api_client/api_client.dart";
import "package:lilit/stores/auth_store/auth_store.dart";
import "package:lilit/utils/device_id/device_id.dart";

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register DeviceInfoPlugin
  getIt.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());

  // Register FlutterSecureStorage
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => FlutterSecureStorage());

  // Register DeviceIdGenerator
  getIt.registerLazySingleton<DeviceIdGenerator>(() => DeviceIdGenerator(
        getIt<FlutterSecureStorage>(),
        getIt<DeviceInfoPlugin>(),
      ));

  // Register Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register ApiClient
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));

  // Register AuthStore
  getIt.registerLazySingleton<AuthStore>(() => AuthStore(
        getIt<ApiClient>(),
        getIt<DeviceIdGenerator>(),
        getIt<FlutterSecureStorage>(),
      ));
}
