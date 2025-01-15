// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preference _$PreferenceFromJson(Map<String, dynamic> json) => Preference(
      json['token'] as String,
      UserDTO.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
