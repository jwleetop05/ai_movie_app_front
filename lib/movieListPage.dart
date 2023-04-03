import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/getMoviePoster.dart';
import 'package:movie_app/services/api.dart';

import 'models/movieData.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  Future<List<GetMoviePoster>>? searchMovieList;
  Future<List<MovieData>>? movieData;
  final Api api = Api();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      final args = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      searchMovieList = api.fetchGetMoviePoster(args['movieName']);
      movieData = api.fetchMovieData(args['movieName']);
    });
  }

  Future<void> getPosterRefresh() async {
    setState(() {
      Future.delayed(Duration.zero, () {
        final args = (ModalRoute.of(context)?.settings.arguments ??
            <String, dynamic>{}) as Map;
        searchMovieList = api.fetchGetMoviePoster(args['movieName']);
        movieData = api.fetchMovieData(args['movieName']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => getPosterRefresh(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  child: Text(
                    "${args['movieName']}에 대한 검색결과입니다.",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                FutureBuilder<List<dynamic>?>(
                  future: Future.wait([
                    searchMovieList ?? [] as Future<dynamic>,
                    movieData ?? [] as Future<dynamic>
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container();
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data == null) {
                      return const Text("검색내용에 알맞는 영화를 찾지못했습니다");
                    } else {
                      final moviePosters =
                          snapshot.data?[0] as List<GetMoviePoster>;
                      final movieDatas = snapshot.data?[1] as List<MovieData>;
                      return SizedBox(
                          height: size.height - 50,
                          child: GridView.builder(
                            itemCount: moviePosters.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              // (size.width~/ 350).toInt()
                              crossAxisCount: size.width ~/ 150,
                              childAspectRatio:
                                  1 / 1.8, //item 의 가로 1, 세로 2 의 비율
                              mainAxisSpacing: 5, //수평 Padding
                              crossAxisSpacing: 10, //수직 Padding
                            ),
                            itemBuilder: (context, index) {
                              final selectData = movieDatas
                                  .where((movieData) =>
                                      movieData.movieNm ==
                                      moviePosters[index].movieName)
                                  .map((e) => e.movieCd);
                              return InkWell(
                                onTap: () {
                                  if (!selectData.isNotEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("해당 영화의 정보를 조회할 수 없습니다."),
                                      duration: Duration(seconds: 1),
                                    ));
                                  } else {
                                    Navigator.pushNamed(context, '/movieDetailData', arguments: {"movieCode" : selectData, "moviePoster" : moviePosters[index].imageLink});
                                  }
                                },
                                child: Column(
                                  children: [
                                    Image.network(
                                        moviePosters[index].imageLink ?? ""),
                                    Text(moviePosters[index].movieName ?? "",
                                        overflow: TextOverflow.ellipsis),
                                    Text(
                                        "${moviePosters[index].movieAge}세 이용가" ??
                                            ""),
                                  ],
                                ),
                              );
                            },
                          ));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
