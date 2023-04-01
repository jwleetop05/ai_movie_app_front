import '../services/api.dart';

class MovieCompanyDetail {
  final String? companyCd;
  final String? companyNm;
  final String? companyNmEn;
  final String? ceoNm;
  final List<Parts> parts;
  final List<Filmos> filmos;

  const MovieCompanyDetail(
      {required this.companyCd,
      required this.companyNm,
      required this.companyNmEn,
      required this.ceoNm,
      required this.parts,
      required this.filmos});
  factory MovieCompanyDetail.fromJSON(JSON json) {
    return MovieCompanyDetail(
        companyCd: json['companyCd'] as String,
        companyNm: json['companyNm'] as String,
        companyNmEn: json['companyNmEn'] as String,
        ceoNm: json['ceoNm'] as String,
        parts: (json['parts'] as List).map((e) {
          final r = e as JSON;
          return Parts(companyPartNm: r['companyPartNm']);
        }).toList(),
        filmos: (json['filmos'] as List).map((e) {
          final r = e as JSON;
          return Filmos(
              movieCd: r['movieCd'],
              movieNm: r['movieNm'],
              companyPartNm: r['companyPartNm']);
        }).toList());
  }
}

class Parts {
  final String? companyPartNm;
  const Parts({required this.companyPartNm});
}

class Filmos {
  final String? movieCd;
  final String? movieNm;
  final String? companyPartNm;
  const Filmos(
      {required this.movieCd,
      required this.movieNm,
      required this.companyPartNm});
}
