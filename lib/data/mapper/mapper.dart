import 'package:first_project_advanced/app/constants.dart';
import 'package:first_project_advanced/app/extensions.dart';
import 'package:first_project_advanced/data/response/responses.dart';
import 'package:first_project_advanced/domain/models/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id.orEmpty() ?? Constants.empty,
      this?.name.orEmpty() ?? Constants.empty,
      this?.numOfNotification.orZero() ?? Constants.zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthentictionResponseMapper on AuthentictionResponse? {
  Authentiction toDomain() {
    return Authentiction(
      this?.contacts.toDomain(), // هنا تأكد أنك تمرر Contacts؟
      this?.customer.toDomain(), // هنا تأكد أنك تمرر Customer؟
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}
