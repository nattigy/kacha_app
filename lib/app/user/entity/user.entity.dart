import '../enum/user.enums.dart';

class UserEntity {
  final String? id;
  final String fullName;
  final String phoneNumber;
  final String? countryCode;
  final String? countryISOCode;
  final String? email;
  final UserGenderEnum? gender;
  final UserStatusEnum? status;
  final UserRoleEnum? role;
  final DateTime? createdAt;
  final String? tutorId;
  final String? tutorProspectId;
  final bool? emailVerified;
  final bool? phoneVerified;

  const UserEntity({
    required this.fullName,
    this.id,
    required this.phoneNumber,
    this.countryISOCode,
    this.countryCode,
    this.email,
    this.gender,
    this.status,
    this.role,
    this.createdAt,
    this.tutorId,
    this.tutorProspectId,
    this.emailVerified,
    this.phoneVerified,
  });

  static const empty = UserEntity(fullName: "", phoneNumber: "");

  factory UserEntity.fromJson(Map<String, dynamic> data) {
    return UserEntity(
      id: data['id'],
      fullName: data['fullName'],
      phoneNumber: data['phoneNumber'],
      countryCode: data['countryCode'],
      countryISOCode: data['countryISOCode'],
      email: data['email'] ?? "",
      gender: data['gender'] != null
          ? UserGenderEnum.values.firstWhere((e) => e.name == data['gender'])
          : UserGenderEnum.UNKNOWN,
      role: UserRoleEnum.values.firstWhere((e) => e.name == data['role']),
      status: UserStatusEnum.values.firstWhere((e) => e.name == data['status']),
      createdAt: DateTime.parse(data['createdAt']),
      tutorId: data['tutorId'],
      tutorProspectId: data['tutorProspectId'],
      emailVerified: data['emailVerified'],
      phoneVerified: data['phoneVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'gender': gender.toString().split('.').last,
      'role': role.toString().split('.').last,
      'status': status.toString().split('.').last,
      "createdAt": createdAt?.toIso8601String(),
      "tutorId": tutorId,
      "tutorProspectId": tutorProspectId,
      "emailVerified": emailVerified,
      "phoneVerified": phoneVerified,
    };
  }
}
