import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child:  Text(
            "${args['movieName']}",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
