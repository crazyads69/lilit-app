// lib/services/api_service.dart

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lilit/api/api_client/api_client.dart';
import 'package:lilit/models/refresh_token/refresh_token.dart';
import 'package:lilit/stores/message_store/message_store.dart';
import 'package:mobx/mobx.dart';
import 'package:lilit/stores/auth_store/auth_store.dart';

// class ApiService {
//   late final ApiClient client;
//   late final AuthStore _authStore;
//   late final MessageStore _messageStore;

//   void initialize({
//     required AuthStore authStore,
//     required MessageStore messageStore,
//   }) {
//     _authStore = authStore;
//     _messageStore = messageStore;

//     final dio = Dio();
//     client = ApiClient(dio);

//     configureClient();

//     // Observe changes to the tokens
//     reaction((_) => _authStore.accessToken, (_) => configureClient());
//     reaction((_) => _authStore.refreshToken, (_) => configureClient());
//   }

//   void configureClient() {
//     client.configure(
//       baseUrl: dotenv.env['BASE_API_URL']!,
//       getAccessToken: () => _authStore.accessToken ?? '',
//       getDeviceId: () => _authStore.deviceId ?? '',
//       getRefreshToken: () => _authStore.refreshToken ?? '',
//       setNewToken: (RefreshToken token) async {
//         await _authStore.setNewToken(token);
//       },
//       logOut: _authStore.logOut,
//       messageStore: _messageStore,
//     );
//   }
// }

class ApiService {
  late final ApiClient client;
  late String Function() getAccessToken;
  late String Function() getDeviceId;
  late String Function() getRefreshToken;
  late Future<void> Function(RefreshToken) setNewToken;
  late Function() logOut;
  late MessageStore messageStore;

  void initialize({
    required String baseUrl,
    required String Function() getAccessToken,
    required String Function() getDeviceId,
    required String Function() getRefreshToken,
    required Future<void> Function(RefreshToken) setNewToken,
    required Function() logOut,
    required MessageStore messageStore,
  }) {
    this.getAccessToken = getAccessToken;
    this.getDeviceId = getDeviceId;
    this.getRefreshToken = getRefreshToken;
    this.setNewToken = setNewToken;
    this.logOut = logOut;
    this.messageStore = messageStore;
    final dio = Dio();
    client = ApiClient(dio);

    configureClient(baseUrl);
  }

  void configureClient(String baseUrl) {
    client.configure(
      baseUrl: baseUrl,
      getAccessToken: getAccessToken,
      getDeviceId: getDeviceId,
      getRefreshToken: getRefreshToken,
      setNewToken: setNewToken,
      logOut: logOut,
      messageStore: messageStore,
    );
  }
}
