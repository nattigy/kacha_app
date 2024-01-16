
import '../../user/enum/user.enums.dart';

class EditUserInput {
  final String fullName;
  final UserGenderEnum gender;

  EditUserInput({required this.fullName, required this.gender});

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName.trim(),
      "gender": gender.name,
    };
  }
}
