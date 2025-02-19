import 'package:get_it/get_it.dart';
import 'package:lilit/api/api_client/api_client.dart';
import 'package:lilit/api/api_service/api_service.dart';
import 'package:lilit/api/api_state/api_state.dart';
import 'package:lilit/models/api_response/api_response.dart';
import 'package:lilit/models/login_response/login_response.dart';
import 'package:lilit/schemas/auth_input/auth_input.dart';

class AuthApi {
  final ApiClient _apiClient;

  AuthApi(this._apiClient);

  late final ApiState<ApiResponse<LoginResponse>> loginState;
  late final ApiState<ApiResponse<LoginResponse>> registerState;
  late final ApiState<ApiResponse<void>> logoutState;

  void initialize() {
    loginState = ApiState<ApiResponse<LoginResponse>>(_apiClient);
    registerState = ApiState<ApiResponse<LoginResponse>>(_apiClient);
    logoutState = ApiState<ApiResponse<void>>(_apiClient);
  }

  Future<ApiResponse<LoginResponse>> login(LoginInput input) async {
    await loginState.run('/v1/auth/login',
        method: 'POST',
        requestData: input.toJson(),
        parser: (data) => ApiResponse<LoginResponse>.fromJson(
              data,
              (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
            ));
    return loginState.data!;
  }

  Future<void> logout() => logoutState.run(
        '/v1/auth/logout',
        method: 'POST',
        parser: (data) => ApiResponse<void>.fromJson(data, (_) => null),
      );
}
