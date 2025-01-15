
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  final String barcode;
  final String name;
  final int ppbc;
  final int ppcc;
  final int spea;
  final int speb;
  final String spec;
  final String tax;
  final int id;

  Item(this.name, this.spec, this.speb, this.ppbc, this.barcode, this.tax, this.ppcc, this.id, this.spea);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
