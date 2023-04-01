import 'package:movie_app/services/api.dart';

class GetMoviePoster {
  final String? imageLink;
  final String? movieName;
  final String? movieAge;
  final String? openDate;

  const GetMoviePoster(
      {required this.imageLink,
      required this.movieName,
      required this.movieAge,
      required this.openDate});

  factory GetMoviePoster.fromJSON(JSON json) {
    return GetMoviePoster(
        imageLink: json['img'] as String,
        movieName: json['movie_name'] as String,
        movieAge: json['movie_age'] as String,
        openDate: json['open-date'] as String);
  }
}
