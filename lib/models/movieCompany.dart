import '../services/api.dart';

class MovieCompany {
  final String? companyCd;
  final String? companyNm;
  final String? companyNmEn;
  final String? companyPartNames;
  final String? ceoNm;
  final String? filmoNames;

  const MovieCompany(
      {required this.companyCd,
      required this.companyNm,
      required this.companyNmEn,
      required this.companyPartNames,
      required this.ceoNm,
      required this.filmoNames});

  factory MovieCompany.fromJSON(JSON json) {
    return MovieCompany(
        companyCd: json['companyCd'] as String,
        companyNm: json['companyNm'] as String,
        companyNmEn: json['companyNmEn'] as String,
        companyPartNames: json['companyPartNames'] as String,
        ceoNm: json['ceoNm'] as String,
        filmoNames: json['filmoNames'] as String);
  }
}
