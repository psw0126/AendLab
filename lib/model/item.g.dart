// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['name'] as String,
      json['spec'] as String,
      json['speb'] as int,
      json['ppbc'] as int,
      json['barcode'] as String,
      json['tax'] as String,
      json['ppcc'] as int,
      json['id'] as int,
      json['spea'] as int,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'barcode': instance.barcode,
      'name': instance.name,
      'ppbc': instance.ppbc,
      'ppcc': instance.ppcc,
      'spea': instance.spea,
      'speb': instance.speb,
      'spec': instance.spec,
      'tax': instance.tax,
      'id': instance.id,
    };
