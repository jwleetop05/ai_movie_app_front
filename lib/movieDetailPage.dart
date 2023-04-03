import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movieDataDetail.dart';
import 'package:movie_app/services/api.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  Future<MovieDataDetail>? searchMovieList;
  final Api api = Api();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      final args = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      searchMovieList = api.fetchMovieDataDetail(args['movieCode'] as String);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width:size.width,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.67,
                  child: Image.network(
                    args['moviePoster'] ?? "",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: size.height * 0.65,
                  child: SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
