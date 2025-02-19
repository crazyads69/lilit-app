import 'package:json_annotation/json_annotation.dart';
import 'package:lilit/models/auth_data/auth_data.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final AuthData user;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  LoginResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
