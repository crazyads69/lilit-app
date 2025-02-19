// Login input schema
import 'package:ez_validator/ez_validator.dart';

class LoginInput {
  final String email;
  final String password;
  final String deviceId;

  static final EzSchema loginInputSchema = EzSchema.shape({
    'email': EzValidator<String>().required().email(),
    'password': EzValidator<String>().required().minLength(8),
    'device_id': EzValidator<String>().required(),
  });

  LoginInput({
    required this.email,
    required this.password,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() {
    final errors = loginInputSchema.catchErrors({
      'email': email,
      'password': password,
      'device_id': deviceId,
    });

    if (errors.isNotEmpty) {
      throw Exception(errors);
    }

    return {
      'email': email,
      'password': password,
      'device_id': deviceId,
    };
  }
}
