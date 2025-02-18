import 'package:json_annotation/json_annotation.dart';
part 'refresh_token.g.dart';

@JsonSerializable()
class RefreshToken {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  RefreshToken({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshToken.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenToJson(this);
}
