import '../services/api.dart';

class MovieDataDetail {
  final String? movieCd;
  final String? movieNm;
  final String? movieNmEn;
  final String? movieNmOg;
  final String? prdtYear;
  final String? showTm;
  final String? openDt;
  final String? prdtStatNm;
  final String? typeNm;
  final List<Nation> nations;
  final List<Genre> genres;
  final List<DetailDirectors> directors;
  final List<Actors> actors;
  final List<ShowType> showTypes;
  final List<Audit> audits;
  final List<Company> companys;
  final List<Staffs> staffs;

  const MovieDataDetail(
      {required this.movieCd,
      required this.movieNm,
      required this.movieNmEn,
      required this.movieNmOg,
      required this.prdtYear,
      required this.showTm,
      required this.openDt,
      required this.prdtStatNm,
      required this.typeNm,
      required this.nations,
      required this.genres,
      required this.directors,
      required this.actors,
      required this.showTypes,
      required this.audits,
      required this.companys,
      required this.staffs});
  factory MovieDataDetail.fromJSON(JSON json) {
    return MovieDataDetail(
        movieCd: json['movieCd'] as String,
        movieNm: json['movieNm'] as String,
        movieNmEn: json['movieNmEn'] as String,
        movieNmOg: json['movieNmOg'] as String,
        prdtYear: json['prdtYear'] as String,
        showTm: json['showTm'] as String,
        openDt: json['openDt'] as String,
        prdtStatNm: json['prdtStatNm'] as String,
        typeNm: json['typeNm'] as String,
        nations: (json['nations'] as List).map((e) {
          final r = e as JSON;
          return Nation(nationNm: r['nationNm']);
        }).toList(),
        genres: (json['genres'] as List).map((e) {
          final r = e as JSON;
          return Genre(genreNm: r['genreNm']);
        }).toList(),
        directors: (json['directors'] as List).map((e) {
          final r = e as JSON;
          return DetailDirectors(
              peopleNm: r['peopleNm'],
              peopleNmEn: r['peopleNmEn']);
        }).toList(),
        actors: (json['actors'] as List).map((e) {
          final r = e as JSON;
          return Actors(
              peopleNm: r['peopleNm'],
              peopleNmEn: r['peopleNmEn'],
              cast: r['cast'],
              castEn: r['castEn']);
        }).toList(),
        showTypes: (json['showTypes'] as List).map((e) {
          final r = e as JSON;
          return ShowType(
              showTypeGroupNm: r['showTypeGroupNm'],
              showTypeNm: r['showTypeNm']);
        }).toList(),
        audits: (json['audits'] as List).map((e) {
          final r = e as JSON;
          return Audit(auditNo: r['auditNo'], watchGradeNm: r['watchGradeNm']);
        }).toList(),
        companys: (json['companys'] as List).map((e) {
          final r = e as JSON;
          return Company(
              companyCd: r['companyCd'],
              companyNm: r['companyNm'],
              companyNmEn: r['companyNmEn'],
              companyPartNm: r['companyPartNm']);
        }).toList(),
        staffs: (json['staffs'] as List).map((e) {
          final r = e as JSON;
          return Staffs(
              peopleNm: r['peopleNm'],
              peopleNmEn: r['peopleNmEn'],
              staffRoleNm: r['staffRoleNm']);
        }).toList());
  }
}

class Nation {
  final String? nationNm;
  const Nation({required this.nationNm});
}

class Genre {
  final String? genreNm;
  const Genre({required this.genreNm});
}

class DetailDirectors {
  final String? peopleNm;
  final String? peopleNmEn;
  const DetailDirectors({required this.peopleNm, required this.peopleNmEn});
}

class Actors {
  final String? peopleNm;
  final String? peopleNmEn;
  final String? cast;
  final String? castEn;
  const Actors(
      {required this.peopleNm,
      required this.peopleNmEn,
      required this.cast,
      required this.castEn});
}

class ShowType {
  final String? showTypeGroupNm;
  final String? showTypeNm;
  const ShowType({required this.showTypeGroupNm, required this.showTypeNm});
}

class Audit {
  final String? auditNo;
  final String? watchGradeNm;
  const Audit({required this.auditNo, required this.watchGradeNm});
}

class Company {
  final String? companyCd;
  final String? companyNm;
  final String? companyNmEn;
  final String? companyPartNm;
  const Company(
      {required this.companyCd,
      required this.companyNm,
      required this.companyNmEn,
      required this.companyPartNm});
}

class Staffs {
  final String? peopleNm;
  final String? peopleNmEn;
  final String? staffRoleNm;
  const Staffs(
      {required this.peopleNm,
      required this.peopleNmEn,
      required this.staffRoleNm});
}
