import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getandpost_http/globals/AppColors.dart';
import 'package:getandpost_http/models/Movies.dart';
import 'package:getandpost_http/movie_App/MovieDetailScreen.dart';
import 'package:getandpost_http/network/api_services.dart';
import 'package:getandpost_http/network/api_url.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  int selectedIndex = 0;
  Movie? popularMovies;
  Movie? trendingMovies;
  List<String> genre = [
    'All',
    'Thriller',
    'Romance',
    'Comedy',
    'Action',
  ];

  @override
  void initState() {
    getPopularMovies();
    getTrendingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        title: const Center(
            child: Text("Film City", style: TextStyle(color: Colors.orange))),
        centerTitle: true,
        actions: [
          IconButton(
            icon:
                const Icon(Icons.account_circle_outlined, color: Colors.orange),
            onPressed: () {},
          )
        ],
        leading: Icon(Icons.local_movies_outlined, color: Colors.orange),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.orange, size: 10),
        selectedItemColor: Colors.orange,
        backgroundColor: Color(0xFF2F2F2F),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.download), label: 'Download'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_fill), label: 'Coming Soon'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: SingleChildScrollView(
          child: Column(
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              TextField(
                style: TextStyle(color: Colors.orange),
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  hintText: "Search for Movies",
                  hintStyle: TextStyle(color: Colors.orange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.orange),
                  suffixIcon: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2F2F2F),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Icon(
                      Icons.menu,
                      color: Colors.orange,
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xFF2F2F2F),
                ),
              ),
              Container(
                height: 40.0,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genre.length,
                  itemBuilder: (context, index) =>
                      genreChip(title: genre[index], index: index),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Popular on Film City",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                width: double.infinity,
                height: 220.0,
                child: popularMovies == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularMovies!.data!.movies!.length,
                        itemBuilder: (context, index) => movieCard(
                            movie: popularMovies!.data!.movies![index]),
                      ),
              ),
              const SizedBox(height: 25.0),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Trending Now",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                width: double.infinity,
                height: 220.0,
                child: trendingMovies == null
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: trendingMovies!.data!.movies!.length,
                        itemBuilder: (context, index) => movieCard(
                            movie: trendingMovies!.data!.movies![index]),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget movieCard({required Movies movie}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 100,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movie: movie),
            ));
          },
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  movie.largeCoverImage!,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                movie.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5.0),
              Text(
                '${movie.language}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  genreChip({required String title, required int index}) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: index == 0 ? 10 : 0),
      child: ActionChip(
        onPressed: () {
          setState(() {
            selectedIndex = index;
          });
        },
        label: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: selectedIndex == index ? Colors.red : Colors.orange,
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      ),
    );
  }

  getPopularMovies() async {
    var r = await ApiServices().get(ApiUrl.baseUrl);
    Movie response = Movie.fromJson(r);
    setState(() {
      popularMovies = response;
    });
  }

  getTrendingMovies() async {
    var r =
        await ApiServices().get(ApiUrl.baseUrl + ApiUrl.sortBy('like_count'));
    Movie response = Movie.fromJson(r);
    setState(() {
      trendingMovies = response;
    });
  }
}
