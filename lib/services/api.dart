import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movieCompany.dart';
import 'package:movie_app/models/movieDataDetail.dart';
import 'package:movie_app/models/movieCompanyDetail.dart';
import 'package:movie_app/models/movieData.dart';
import 'package:movie_app/models/movieHuman.dart';
import 'package:movie_app/models/movieHumanDetail.dart';
import 'package:movie_app/models/getMoviePoster.dart';
import 'package:movie_app/models/newMovieList.dart';
import 'dart:developer';
typedef JSON = Map<String, dynamic>;

class Api{
  String apiKey = "3d78e7d0f0796a16e0f518842e9bcbb8";
  Future<http.Response> getResponse(String url) async {
    try {
      return await http.get(Uri.parse(url));
    } catch (e) {
      return http.Response('', 404);
    }
  }
  Future<List<MovieData>> fetchMovieData() async {
    final response = await getResponse(
        'http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?'
            'key=$apiKey'
            '&curPage='
            '&itemPerPage=100'
            '&openStartDt=2023'
            '&openEndDt'
            '&movieNm'
            '&directorNm'
            '&prdtStartYear'
            '&prdtEndYear'
            '&repNationCd'
            '&movieTypeCd');
    if(response.statusCode == 200) {
      final list = jsonDecode(response.body)['movieListResult']['movieList'] as List;

      return list.map((e) => MovieData.fromJSON(e as JSON)).toList();
    } else {
      throw Exception('MovieData Api 못불러옴');
    }
  }
  Future<List<MovieCompany>> fetchMovieCompanyData(String companyNm) async {
    final response = await getResponse('http://www.kobis.or.kr/kobisopenapi/webservice/rest/company/searchCompanyList.json?'
        'key=$apiKey'
        '&curPage'
        '&itemPerPage'
        '&companyNm=$companyNm'
        '&ceoNm&companyPartCd');
    if(response.statusCode == 200) {
      final list = jsonDecode(response.body)['companyListResult']['companyList'] as List;

      return list.map((e) => MovieCompany.fromJSON(e as JSON)).toList();
    } else {
      throw Exception('MovieData Api 못불러옴');
    }
  }
  Future<MovieDataDetail> fetchMovieDataDetail(String movieCd) async {
    final response = await getResponse(
        'http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?'
            'key=$apiKey&'
            'movieCd=$movieCd');
    if(response.statusCode == 200) {
      return MovieDataDetail.fromJSON(jsonDecode(response.body)['movieInfoResult']['movieInfo']);
    } else {
      throw Exception('MovieData Api 못불러옴');
    }
  }
  Future<MovieCompanyDetail> fetchMovieCompanyDataDetail(String companyCd) async {
    final response = await getResponse('http://www.kobis.or.kr/kobisopenapi/webservice/rest/company/searchCompanyInfo.json?'
        'key=$apiKey'
        '&companyCd=companyCd');
    if(response.statusCode == 200) {
      return MovieCompanyDetail.fromJSON(jsonDecode(response.body)['companyInfoResult']['companyInfo']);
    } else {
      throw Exception('MovieData Api 못불러옴');
    }
  }
  Future<List<MovieHuman>> fetchMovieHumanData() async {
    final response = await getResponse('http://www.kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleList.json?'
        'key=$apiKey'
        '&peopleNm='
        '&filmoNames='
        '&itemPerPage=100'
        '&curPage=');
    if(response.statusCode == 200) {
      final list = jsonDecode(response.body)['peopleListResult']['peopleList'] as List;
      return list.map((e) => MovieHuman.fromJSON(e as JSON)).toList();
    } else {
      throw Exception('MovieData Api 못불러옴');
    }
  }
  Future<MovieHumanDetail> fetchMovieHumanDataDetail() async {
    final response = await getResponse(
        'http://kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleInfo.json?'
            'key=$apiKey'
            '&peopleCd=20164556');
    if(response.statusCode == 200) {
      return MovieHumanDetail.fromJSON(jsonDecode(response.body)['peopleInfoResult']['peopleInfo']);
    } else {
      throw Exception('MovieData Api 못불러옴');
    }
  }
  Future<List<GetMoviePoster>> fetchGetMoviePoster(String movieName) async {
    final response = await getResponse('http://10.246.157.164:5050/search_movie_poster?movie_name=$movieName');
    if(response.statusCode == 200) {
      final list = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      return list.map((e) => GetMoviePoster.fromJSON(e as JSON)).toList();
    } else {
      throw Exception('포스터 못부름');
    }
  }
  Future<List<NewMovieList>> fetchNewMovieList() async {
    final response = await getResponse('http://10.246.157.164:5050/new_movies');
    if(response.statusCode == 200) {
      final list = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      log("아아: $list");
      return list.map((e) => NewMovieList.fromJSON(e as JSON)).toList();
    } else {
      throw Exception(response.statusCode);
    }
  }
}