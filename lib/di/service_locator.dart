import "package:device_info_plus/device_info_plus.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get_it/get_it.dart";
import "package:dio/dio.dart";
import "package:lilit/api/api_client/api_client.dart";
import "package:lilit/api/api_service/api_service.dart";
import "package:lilit/api/auth_api/auth_api.dart";
import "package:lilit/router/app_router.dart";
import "package:lilit/stores/auth_store/auth_store.dart";
import "package:lilit/stores/message_store/message_store.dart";
import "package:lilit/utils/device_id/device_id.dart";

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register AppRouter
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

  // Register MessageStore
  getIt.registerLazySingleton<MessageStore>(() => MessageStore());

  // Register ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // Register ApiClient
  getIt.registerLazySingleton<ApiClient>(() => getIt<ApiService>().client);

  // Register AuthApi
  getIt.registerLazySingleton<AuthApi>(() {
    final authApi = AuthApi(getIt<ApiClient>());
    authApi.initialize();
    return authApi;
  });

  // Register AuthStore
  getIt.registerLazySingleton<AuthStore>(() => AuthStore(
        getIt<AuthApi>(),
        getIt<DeviceIdGenerator>(),
        getIt<FlutterSecureStorage>(),
        getIt<MessageStore>(),
      ));

  getIt.registerLazySingleton<AppRouter>(() => AppRouter(getIt<AuthStore>()));

  // Initialize ApiService
  getIt<ApiService>().initialize(
    baseUrl: dotenv.env['BASE_API_URL']!,
    getAccessToken: () => getIt<AuthStore>().accessToken ?? '',
    getDeviceId: () => getIt<AuthStore>().deviceId ?? '',
    getRefreshToken: () => getIt<AuthStore>().refreshToken ?? '',
    setNewToken: (token) => getIt<AuthStore>().setNewToken(token),
    logOut: () => getIt<AuthStore>().logOut(),
    messageStore: getIt<MessageStore>(),
  );
}
