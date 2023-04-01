import 'package:movie_app/models/movieHuman.dart';
import 'package:movie_app/services/api.dart';

class MovieHumanDetail {
  final String? peopleCd;
  final String? peopleNm;
  final String? peopleNmEn;
  final String? sex;
  final String? repRoleNm;
  final List<HomePage> homepages;
  final List<Filmos> filmos;
  const MovieHumanDetail({
    required this.peopleCd,
    required this.peopleNm,
    required this.peopleNmEn,
    required this.sex,
    required this.repRoleNm,
    required this.homepages,
    required this.filmos
  });
  factory MovieHumanDetail.fromJSON(JSON json) {
    return MovieHumanDetail(peopleCd: json['peopleCd'] as String, peopleNm: json['peopleNm'] as String, peopleNmEn: json['peopleNmEn'] as String, sex: json['sex'] as String, repRoleNm: json['repRoleNm'] as String, homepages: (json['homepages'] as List).map((e) {
      return HomePage(url: (e as JSON)['url']);
    }).toList(), filmos: (json['filmos'] as List).map((e) {
      final r = (e as JSON);
      return Filmos(movieCd: r['movieCd'], movieNm: r['movieNm'], moviePartNm: r['moviePartNm']);
    }).toList());
  }
}
class HomePage {
  final String? url;
  const HomePage({required this.url});
}
class Filmos {
  final String? movieCd;
  final String? movieNm;
  final String? moviePartNm;
  const Filmos({required this.movieCd, required this.movieNm, required this.moviePartNm});
}