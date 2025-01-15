import 'dart:core';

class ErrObject implements Exception {
  final String err;
  final String error_description;


  ErrObject(this.err, this.error_description);


  // static ErrObject fromJson(Map<String, dynamic> json) => _$ErrObjectToJson(json);
  // Map<String, dynamic> toJson() => _$ErrObjectToJson(this);

  ErrObject.fromJson(Map<String, dynamic> json)
  : err = json['error'],
    error_description = json['error_description'];

  Map<String, dynamic> toJson() => {
    'error': err,
    'error_description': error_description,
  };

}

