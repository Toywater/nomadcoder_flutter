import 'package:flutter/material.dart';
import 'package:todays_movies/constants/gaps.dart';
import 'package:todays_movies/constants/movie_info._service.dart';
import 'package:todays_movies/constants/sizes.dart';
import 'package:todays_movies/models/movie_model.dart';
import 'package:todays_movies/widgets/movie_thumb_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final Future<List<MovieModel>> _popularMovies = MovieInfoService.getPopularMovies();
  final Future<List<MovieModel>> _nowInCinemas = MovieInfoService.getNowInCinema();
  final Future<List<MovieModel>> _commingSoon = MovieInfoService.getCommingSoon();
  // #endregion [Member variables]

  // #region [Member methods]
  // #endregion [Member methods]

  // #region [Override methods]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Today's movies",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size24, vertical: Sizes.size14),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Popular movies
              Text(
                "Popular Moviews",
                style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.bold),
              ),
              Gaps.v16,
              MovieThumbWidget(
                movieModels: _popularMovies,
                imageWidth: 260,
                imageHeight: 180,
              ),
              Gaps.v28,
              // Now in cinemas
              Text(
                "Now in Cinemas",
                style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.bold),
              ),
              Gaps.v16,
              MovieThumbWidget(
                movieModels: _nowInCinemas,
                imageWidth: 150,
                imageHeight: 150,
                isTitleVisible: true,
              ),
              Gaps.v28,
              // Coming soon
              Text(
                "Coming soon",
                style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.bold),
              ),
              Gaps.v16,
              MovieThumbWidget(
                movieModels: _commingSoon,
                imageWidth: 150,
                imageHeight: 150,
                isTitleVisible: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // #endregion [Override methods]
}
