import '../services/api.dart';

class NewMovieList {
  final String? imageLink;
  final String? movieName;
  const NewMovieList({required this.imageLink, required this.movieName});
  factory NewMovieList.fromJSON(JSON json) {
    return NewMovieList(
        imageLink: json['img'] as String, movieName: json['title'] as String);
  }
}
