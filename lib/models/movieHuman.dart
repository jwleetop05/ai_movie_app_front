import 'package:movie_app/services/api.dart';

class MovieHuman {
  final String? peopleCd;
  final String? peopleNm;
  final String? peopleNmEn;
  final String? repRoleNm;
  final String? filmoNames;

  const MovieHuman({
    required this.peopleCd,
    required this.peopleNm,
    required this.peopleNmEn,
    required this.repRoleNm,
    required this.filmoNames,
  });
  factory MovieHuman.fromJSON(JSON json) {
    return MovieHuman(
        peopleCd: json['peopleCd'] as String,
        peopleNm: json['peopleNm'] as String,
        peopleNmEn: json['peopleNmEn'] as String,
        repRoleNm: json['repRoleNm'] as String,
        filmoNames: json['filmoNames'] as String);
  }
}
