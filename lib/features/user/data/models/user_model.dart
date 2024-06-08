import '../../../../core/databases/api/end_points.dart';
import '../../domain/entities/user_entitiy.dart';
import 'sub_models/address_model.dart';
import 'sub_models/company_model.dart';

class UserModel extends UserEntity {
  final int id;
  final String username;
  final String website;
  final CompanyModel company;

  UserModel({
    required this.id,
    required super.name,
    required super.phone,
    required super.email,
    required super.address,
    required this.username,
    required this.website,
    required this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[ApiKey.id],
      name: json[ApiKey.name],
      phone: json[ApiKey.phone],
      email: json[ApiKey.email],
      username: json[ApiKey.username],
      website: json[ApiKey.website],
      address: AddressModel.fromJson(json[ApiKey.address]),
      company: CompanyModel.fromJson(json[ApiKey.company]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.name: name,
      ApiKey.email: email,
      ApiKey.phone: phone,
      ApiKey.username: username,
      ApiKey.website: website,
      ApiKey.company: company,
      ApiKey.address: address,
    };
  }
}
