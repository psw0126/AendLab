
import 'dart:convert';

import 'package:aendlab/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preference.g.dart';

final String _PREFERENCE_NAME = "AENDLAB_PREFERENCE";

@JsonSerializable()
class Preference {
  String? token;
  UserDTO user;

  Preference(this.token, this.user);

  String? getToken() {
    return this.token;
  }

  User getUser() {
    return User.fromDTO(this.user);
  }

  bool? isLogin() {
    return this.token?.isNotEmpty;
  }

  factory Preference.fromJson(Map<String, dynamic> json) => _$PreferenceFromJson(json);
  Map<String, dynamic> toJson() => _$PreferenceToJson(this);
}

Future<Preference?> loadPreference() async {
  SharedPreferences p = await SharedPreferences.getInstance();
  String? v = p.getString(_PREFERENCE_NAME);
  if (v == null || v.isEmpty) {
    return null;
  }

  return Preference.fromJson(json.decode(v));
}

Future<void> clearPreference() async {
  SharedPreferences p = await SharedPreferences.getInstance();
  p.clear();
}