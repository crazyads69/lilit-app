import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lilit/api/api_client/api_client.dart';
import 'package:lilit/models/auth_data/auth_data.dart';
import 'package:lilit/models/refresh_token/refresh_token.dart';
import 'package:lilit/utils/device_id/device_id.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final ApiClient _apiClient;
  final DeviceIdGenerator _deviceIdGenerator;
  final FlutterSecureStorage _secureStorage;
  final String _deviceIdKey = 'DEVICE_ID';
  final String _accessTokenKey = "ACCESS_TOKEN";
  final String _refreshTokenKey = "REFRESH_TOKEN";

  _AuthStore(this._apiClient, this._deviceIdGenerator, this._secureStorage) {
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
  Future<void> login(String email, String password) async {
    try {
      final response = await _apiClient.mutate<Map<String, dynamic>>(
        '/v1/auth/login',
        {'email': email, 'password': password, 'device_id': deviceId},
        parser: (data) => data as Map<String, dynamic>,
      );
      user = AuthData.fromJson(response['user']);
      accessToken = response['access_token'];
      refreshToken = response['refresh_token'];
      deviceId = response['device_id'];
    } catch (e) {
      // Handle error
    }
  }

  @action
  Future<void> setNewToken(RefreshToken newToken) async {
    accessToken = newToken.accessToken;
    refreshToken = newToken.refreshToken;
  }

  @action
  void logOut() {
    user = null;
    accessToken = null;
    refreshToken = null;
    deviceId = null;
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
