
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';


class User {
  final String account_id;
  final String password;

  User(this.account_id, this.password);

  factory User.fromDTO(UserDTO dto){
    return User(
        dto.account_id,
        dto.password,
    );
  }

  UserDTO toDTO() {
    return UserDTO(
      this.account_id,
      this.password,
    );
  }
}

@JsonSerializable()
class UserDTO {
  final String account_id;
  final String password;

  UserDTO(this.account_id, this.password);

  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
