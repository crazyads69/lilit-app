import 'package:auto_route/auto_route.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lilit/api/api_state/api_state.dart';
import 'package:lilit/api/auth_api/auth_api.dart';
import 'package:lilit/di/service_locator.dart';
import 'package:lilit/models/api_response/api_response.dart';
import 'package:lilit/models/auth_data/auth_data.dart';
import 'package:lilit/models/login_response/login_response.dart';
import 'package:lilit/models/refresh_token/refresh_token.dart';
import 'package:lilit/router/app_router.dart';
import 'package:lilit/schemas/auth_input/auth_input.dart';
import 'package:lilit/utils/device_id/device_id.dart';
import 'package:lilit/stores/message_store/message_store.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final AuthApi _authApi;
  final DeviceIdGenerator _deviceIdGenerator;
  final FlutterSecureStorage _secureStorage;
  final MessageStore _messageStore;
  final String _accessTokenKey = "ACCESS_TOKEN";
  final String _refreshTokenKey = "REFRESH_TOKEN";

  _AuthStore(this._authApi, this._deviceIdGenerator, this._secureStorage,
      this._messageStore) {
    _initialize();
  }

  @observable
  String? deviceId;

  @observable
  AuthData? user;

  @observable
  String? accessToken;

  @observable
  String? refreshToken;

  @observable
  bool isInitialized = false;

  @computed
  @computed
  bool get isAuthenticated => refreshToken != null && refreshToken!.isNotEmpty;

  @computed
  ApiState<ApiResponse<LoginResponse>> get loginState => _authApi.loginState;

  @computed
  ApiState<ApiResponse<LoginResponse>> get registerState =>
      _authApi.registerState;

  @action
  Future<void> setNewToken(RefreshToken newToken) async {
    accessToken = newToken.accessToken;
    refreshToken = newToken.refreshToken;

    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  @action
  Future<void> login(LoginInput input) async {
    final response = await _authApi.login(input);
    user = response.data.user;
    accessToken = response.data.accessToken;
    refreshToken = response.data.refreshToken;

    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);

    _messageStore.showMessage(MessageType.success, response.messageVi,
        description: response.message);
  }

  @action
  Future<void> logOut() async {
    await _authApi.logout();

    // Clear all stored data
    user = null;
    accessToken = null;
    refreshToken = null;
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);

    _messageStore.showMessage(MessageType.success, 'Đăng xuất thành công',
        description: "Bạn đã đăng xuất thành công");

    // Redirect to login page
    AutoRouter.of(getIt<AppRouter>().navigatorKey.currentContext!)
        .replace(LoginRoute());
  }

  @action
  Future<void> _initialize() async {
    deviceId = await _deviceIdGenerator.generateDeviceId();
    accessToken = await _secureStorage.read(key: _accessTokenKey);
    refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    isInitialized = true;
  }
}
