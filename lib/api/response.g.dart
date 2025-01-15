// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIResponse _$APIResponseFromJson(Map<String, dynamic> json) => APIResponse(
      json['status'] as String?,
      json['message'] as String?,
      json['data'],
    );

Map<String, dynamic> _$APIResponseToJson(APIResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
