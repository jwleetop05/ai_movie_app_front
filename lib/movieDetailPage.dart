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
  late Future<MovieDataDetail>? searchMovieList;
  final Api api = Api();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      final args = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      searchMovieList = api.fetchMovieDataDetail(args['movieCode']);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<MovieDataDetail>(
          future: searchMovieList,
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Center(
                child: Text("데이터 불러오는중"),
              );
            } else if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SizedBox(
                height: size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: SizedBox(
                        width: size.width,
                        height: size.height * 0.6,
                        child: Image.network(
                          args['moviePoster'] ?? "",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(top: size.height / 3, left: size.width / 5,child: Text(snapshot.data?.movieNm ?? "", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),)),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        width: size.width,
                        height: size.height * 0.55,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            children: [
                                Text("감독 : ${snapshot.data?.directors.map((e) => e.peopleNm).reduce((o, n) => "$o, $n")}"),
                                const Text("배우 : "),
                                snapshot.data!.actors.isNotEmpty ? Text("${snapshot.data?.actors.map((e) => e.peopleNm).reduce((o, n) => "$o\n$n")}") : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
