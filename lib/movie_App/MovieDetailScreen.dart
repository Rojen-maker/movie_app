import 'package:flutter/material.dart';
import 'package:getandpost_http/models/Movies.dart';

class MovieDetailScreen extends StatefulWidget {
  Movies movie;
  MovieDetailScreen({required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title!),
      ),

     body:Image.network(widget.movie.largeCoverImage!),

    );
  }
}
