import 'package:json_annotation/json_annotation.dart';

// إضافة الجزء الخاص بـ responses.g.dart
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;

  BaseResponse();
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'numOfNotifications')
  int? numOfNotification;

  CustomerResponse(
    this.id,
    this.name,
    this.numOfNotification,
  );

  //from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'link')
  String? link;

  ContactsResponse(
    this.email,
    this.link,
    this.phone,
  );

  // json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthentictionResponse extends BaseResponse {
  @JsonKey(name: 'customer')
  CustomerResponse? customer;
  @JsonKey(name: 'contacts')
  ContactsResponse? contacts;

  AuthentictionResponse(
    this.contacts,
    this.customer,
  );

  // from json
  factory AuthentictionResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthentictionResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AuthentictionResponseToJson(this);
}
