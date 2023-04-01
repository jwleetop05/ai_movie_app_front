import '../services/api.dart';

class MovieData {
  final String? movieCd;
  final String? movieNm;
  final String? movieNmEn;
  final String? prdtYear;
  final String? openDt;
  final String? typeNm;
  final String? prdtStatNm;
  final String? nationAlt;
  final String? genreAlt;
  final String? repNationNm;
  final String? repGenreNm;
  final List<Directors> directors;
  final List<Companys> companys;
  const MovieData(
      {required this.movieCd,
      required this.movieNm,
      required this.movieNmEn,
      required this.prdtYear,
      required this.openDt,
      required this.typeNm,
      required this.prdtStatNm,
      required this.nationAlt,
      required this.genreAlt,
      required this.repNationNm,
      required this.repGenreNm,
      required this.directors,
      required this.companys});
  factory MovieData.fromJSON(JSON json) {
    return MovieData(
      movieCd: json['movieCd'] as String,
      movieNm: json['movieNm'] as String,
      movieNmEn: json['movieNmEn'] as String,
      prdtYear: json['prdtYear'] as String,
      openDt: json['openDt'] as String,
      typeNm: json['typeNm'] as String,
      prdtStatNm: json['prdtStatNm'] as String,
      nationAlt: json['nationAlt'] as String,
      genreAlt: json['genreAlt'] as String,
      repNationNm: json['repNationNm'] as String,
      repGenreNm: json['repGenreNm'] as String,
      directors: (json['directors'] as List).map((e) {
        return Directors(peopleNm: (e as JSON)['peopleNm']);
      }).toList(),
      companys: (json['companys'] as List).map((e) {
        final r = e as JSON;
        return Companys(
          companyCd: r['companyCd'],
          companyNm: r['companyNm'],
        );
      }).toList(),
    );
  }
}

class Companys {
  final String? companyCd;
  final String? companyNm;
  const Companys({required this.companyCd, required this.companyNm});
}

class Directors {
  final String? peopleNm;
  const Directors({required this.peopleNm});
}
