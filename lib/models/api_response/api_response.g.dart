// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResponse<T>(
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      messageVi: json['message_vi'] as String,
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'message_vi': instance.messageVi,
      'data': toJsonT(instance.data),
    };
