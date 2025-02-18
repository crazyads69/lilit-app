// lib/stores/auth_store/auth_store.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lilit/api/api_client/api_client.dart';
import 'package:lilit/models/auth_data/auth_data.dart';
import 'package:lilit/models/refresh_token/refresh_token.dart';
import 'package:lilit/utils/device_id/device_id.dart';
import 'package:lilit/stores/message_store/message_store.dart';
import 'package:mobx/mobx.dart';
import 'package:dio/dio.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final ApiClient _apiClient;
  final DeviceIdGenerator _deviceIdGenerator;
  final FlutterSecureStorage _secureStorage;
  final MessageStore _messageStore;
  final String _accessTokenKey = "ACCESS_TOKEN";
  final String _refreshTokenKey = "REFRESH_TOKEN";

  _AuthStore(this._apiClient, this._deviceIdGenerator, this._secureStorage,
      this._messageStore) {
    _initializeDeviceId();
  }

  @observable
  String? deviceId;

  @observable
  AuthData? user;

  @observable
  String? accessToken;

  @observable
  String? refreshToken;

  @action
  Future<void> register(String email, String password, String firstName,
      String lastName, String dateOfBirth) async {
    try {
      final response = await _apiClient.mutate<Map<String, dynamic>>(
        '/api/v1/auth/register',
        {
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'date_of_birth': dateOfBirth,
          'device_id': deviceId,
        },
        parser: (data) => data as Map<String, dynamic>,
      );

      user = AuthData.fromJson(response['user']);
      accessToken = response['access_token'];
      refreshToken = response['refresh_token'];
      deviceId = response['device_id'];

      await _secureStorage.write(key: _accessTokenKey, value: accessToken);
      await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);

      _messageStore.showMessage(MessageType.success, 'Registration successful');
    } catch (e) {
      if (e is DioException) {
        final response = e.response;
        if (response != null) {
          final data = response.data;
          if (data is Map<String, dynamic> && data.containsKey('message_vi')) {
            _messageStore.showMessage(MessageType.error, data['message_vi']);
          } else {
            _messageStore.showMessage(
                MessageType.error, 'An error occurred during registration');
          }
        } else {
          _messageStore.showMessage(MessageType.error,
              e.message ?? 'An error occurred during registration');
        }
      } else {
        _messageStore.showMessage(
            MessageType.error, 'An unexpected error occurred');
      }
    }
  }

  @action
  Future<void> login(String email, String password) async {
    try {
      final response = await _apiClient.mutate<Map<String, dynamic>>(
        '/api/v1/auth/login',
        {'email': email, 'password': password, 'device_id': deviceId},
        parser: (data) => data as Map<String, dynamic>,
      );

      user = AuthData.fromJson(response['user']);
      accessToken = response['access_token'];
      refreshToken = response['refresh_token'];
      deviceId = response['device_id'];

      await _secureStorage.write(key: _accessTokenKey, value: accessToken);
      await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);

      _messageStore.showMessage(MessageType.success, 'Login successful');
    } catch (e) {
      if (e is DioException) {
        final response = e.response;
        if (response != null) {
          final data = response.data;
          if (data is Map<String, dynamic> && data.containsKey('message_vi')) {
            _messageStore.showMessage(MessageType.error, data['message_vi']);
          } else {
            _messageStore.showMessage(
                MessageType.error, 'An error occurred during login');
          }
        } else {
          _messageStore.showMessage(
              MessageType.error, e.message ?? 'An error occurred during login');
        }
      } else {
        _messageStore.showMessage(
            MessageType.error, 'An unexpected error occurred');
      }
    }
  }

  @action
  Future<void> setNewToken(RefreshToken newToken) async {
    accessToken = newToken.accessToken;
    refreshToken = newToken.refreshToken;

    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  @action
  Future<void> logOut() async {
    try {
      await _apiClient.mutate<Map<String, dynamic>>(
        '/v1/auth/logout',
        {},
        parser: (data) => data as Map<String, dynamic>,
      );

      // Clear all stored data
      user = null;
      accessToken = null;
      refreshToken = null;
      deviceId = null;
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
    } catch (e) {
      if (e is DioException) {
        final response = e.response;
        if (response != null) {
          final data = response.data;
          if (data is Map<String, dynamic> && data.containsKey('message_vi')) {
            _messageStore.showMessage(MessageType.error, data['message_vi']);
          } else {
            _messageStore.showMessage(
                MessageType.error, 'An error occurred during login');
          }
        } else {
          _messageStore.showMessage(
              MessageType.error, e.message ?? 'An error occurred during login');
        }
      } else {
        _messageStore.showMessage(
            MessageType.error, 'An unexpected error occurred');
      }
    }
  }

  @action
  Future<void> _initializeDeviceId() async {
    deviceId = await _deviceIdGenerator.generateDeviceId();
    accessToken = await _secureStorage.read(key: _accessTokenKey);
    refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    _apiClient.configure(
      baseUrl: dotenv.env['BASE_API_URL']!,
      getAccessToken: () => accessToken ?? '',
      getDeviceId: () => deviceId ?? '',
      getRefreshToken: () => refreshToken ?? '',
      setNewToken: setNewToken,
      logOut: logOut,
    );
  }
}
