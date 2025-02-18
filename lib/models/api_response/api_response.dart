import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  @JsonKey(name: 'status_code')
  final int statusCode;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'message_vi')
  final String messageVi;
  @JsonKey(name: 'data')
  final T data;

  ApiResponse({
    required this.statusCode,
    required this.message,
    required this.messageVi,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}
