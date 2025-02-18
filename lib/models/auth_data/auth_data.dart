import 'package:json_annotation/json_annotation.dart';

part 'auth_data.g.dart';

@JsonSerializable()
class AuthData {
  final String id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String dateOfBirth;

  AuthData({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}
