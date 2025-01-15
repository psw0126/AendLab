import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class APIResponse {
  final String? status;
  final String? message;
  final dynamic data;

  APIResponse(this.status, this.message, this.data);

  static APIResponse fromJson(Map<String, dynamic> json) => _$APIResponseFromJson(json);
  Map<String, dynamic> toJson() => _$APIResponseToJson(this);
}

class APIStatus {
  static const Okay = "200";
  static const WrongPassword = "AD001";
  static const WrongUser = "AR010";
  static const WronToken = "AU002";
  static const IncorrectAuthCode  = "401";
}

// static const InvalidParameter   = 400;
// static const IncorrectAuthCode  = 401;
// static const IncorrectAuthCode  = 401;
// static const Duplicated         = 402;
// static const Unauthorized       = 403;
// static const NotFound           = 404;
// static const InactiveAcademy    = 405;
// static const OverlappedSchedule = 406;
// static const IncorrectPassword  = 407;
//
// static const InternalServerError = 500;