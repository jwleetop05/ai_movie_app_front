import 'package:flutter/material.dart';
import 'package:movie_app/models/movieCompany.dart';
import 'package:movie_app/models/movieCompanyDetail.dart';
import 'package:movie_app/models/movieHuman.dart';
import 'package:movie_app/models/movieHumanDetail.dart';
import 'package:movie_app/models/newMovieList.dart';
import 'package:movie_app/services/api.dart';

import 'models/movieData.dart';
import 'models/movieDataDetail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<MovieData>>? movieData;
  late Future<List<MovieCompany>>? movieCompany;
  late Future<List<MovieHuman>>? movieHuman;
  late Future<List<NewMovieList>>? newMovieList;
  late Future<MovieHumanDetail>? movieHumanDetail;
  late Future<MovieCompanyDetail>? movieCompanyDetail;
  // late Future<MovieDataDetail>? movieDataDetail;
  final Api api = Api();

  @override
  void initState() {
    super.initState();
    // movieData = api.fetchMovieData();
    // movieHuman = api.fetchMovieHumanData();
    newMovieList = api.fetchNewMovieList();
    movieHumanDetail = api.fetchMovieHumanDataDetail();
    // movieCompanyDetail = api.fetchMovieCompanyDataDetail();
    // movieCompany = api.fetchMovieCompanyData();
    // movieDataDetail = api.fetchMovieDataDetail();
  }

  final PageController pageController = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                newMovieList = api.fetchNewMovieList();
                // movieData = api.fetchMovieData();
                // movieDataDetail = api.fetchMovieDataDetail();
              },
              child: const Text("REFRESH"),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                    labelText: "영화검색",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            FutureBuilder<List<NewMovieList>>(
              future: newMovieList,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const CircularProgressIndicator();
                } else {
                  return Container(
                    height: 270,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.map((e) {
                        return Row(
                          children: [
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 12.0,
                                      spreadRadius: -20.0,
                                      offset: Offset(0.0, -40),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      height: 200,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          e.imageLink ?? "",
                                          width: 150,
                                          height: 200,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 150,
                                      child: Text(
                                        e.movieName ?? "",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            )
            // FutureBuilder(
            //   future: movieHumanDetail,
            //   builder: (context, snapshot) {
            //   if(snapshot.data == null) {
            //     return CircularProgressIndicator();
            //   } else {
            //     return Column(
            //       children: [
            //         Text(snapshot.data!.peopleNm ?? ''),
            //         Text(snapshot.data!.peopleCd ?? ''),
            //         Text(snapshot.data!.sex ?? ''),
            //       ],
            //     );
            //   }
            // },)
            // FutureBuilder(
            //   future: movieHuman,
            //   builder: (context, snapshot) {
            //     if(snapshot.data == null) {
            //       return CircularProgressIndicator();
            //     } else {
            //       return Column(
            //         children: snapshot.data!.map((e) {
            //           return Row(
            //             children: [
            //               Text(e.peopleNm ?? ''),
            //               Text(e.peopleCd ?? '')
            //             ],
            //           );
            //         }).toList()
            //       );
            //     }
            // },)
            // FutureBuilder(
            //   future: movieCompanyDetail,
            //   builder: (context, snapshot) {
            //     if(snapshot.data == null) {
            //       return CircularProgressIndicator();
            //     } else {
            //       return Column(
            //         children:
            //           snapshot.data!.filmos.where((w) => w.companyPartNm == '배급사').map((e) {
            //             return Row(
            //               children: [
            //                 Text(e.movieCd ?? ''),
            //                 Text(e.movieNm ?? ''),
            //               ],
            //             );
            //           }).toList()
            //       );
            //     }
            // },)
            // FutureBuilder<List<MovieCompany>>(
            //   future: movieCompany,
            //   builder: (context, snapshot) {
            //     if(snapshot.data == null) {
            //       return CircularProgressIndicator();
            //     } else {
            //       return Column(
            //         children: snapshot.data!.map((e) {
            //           return Column(
            //             children: [
            //               Text(e.ceoNm ?? ''),
            //               Text(e.filmoNames ?? '')
            //             ],
            //           );
            //         }).toList(),
            //       );
            //     }
            // },)
            // FutureBuilder<MovieDataDetail>(
            //   future: movieDataDetail,
            //   builder: (context, snapshot) {
            //     if(snapshot.hasError) {
            //       print( 'Sibal Error !!!! ${snapshot.error}');
            //       return CircularProgressIndicator();
            //     } else if(snapshot.data == null) {
            //       return CircularProgressIndicator();
            //     } else {
            //       return Column(
            //         children:
            //         snapshot.data!.directors.map((e) =>
            //             Column(
            //               children: [
            //                 Text(e.peopleNm ?? '아'),
            //                 Text(e.peopleNmEn ?? '아')
            //               ],
            //             )
            //         ).toList(),
            //       );
            //     }
            // },)

            // FutureBuilder<List<MovieData>>(
            //   future: movieData,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       print('Sibal Error !!!! ${snapshot.error}');
            //     }
            //     return Column(
            //       children: snapshot.data
            //               ?.where((e) => e.repGenreNm != "성인물(에로)")
            //               .map((e) => Text(e.movieNm ?? 'aaa'))
            //               .toList() ??
            //           [],
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
