import 'package:flutter/material.dart';
import 'package:todays_movies/constants/gaps.dart';
import 'package:todays_movies/constants/movie_info._service.dart';
import 'package:todays_movies/constants/sizes.dart';
import 'package:todays_movies/models/movie_detail_model.dart';
import 'package:todays_movies/models/movie_model.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieInfo});

  final MovieModel movieInfo;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<MovieDetailModel?> _movieDetail;

  // Rate에 따라 아이콘 리턴
  IconData getVoteStar(double rate) {
    if (rate <= 1.0) {
      return Icons.star_outline;
    } else if (rate > 1.0 && rate < 2.0) {
      return Icons.star_half;
    }

    return Icons.star;
  }

  @override
  void initState() {
    super.initState();

    _movieDetail = MovieInfoService.getMovieDetailModel(widget.movieInfo.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 배경에 포스터 출력
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: NetworkImage(
            MovieInfoService.getImageUrl(widget.movieInfo.posterPath),
          ),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            title: Text(
              "Back to list",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size24, vertical: Sizes.size14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v96,
                // 영화 타이틀
                Text(
                  widget.movieInfo.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v4,
                // 평점 스타
                Row(
                  children: [
                    // VoteAverage 값이 최대 10점
                    // 2점을 별 하나로 본다.
                    for (var i = 1; i <= 5; i++)
                      Icon(
                        getVoteStar(widget.movieInfo.voteAverage - (i * 2.0)),
                        color: Colors.yellow,
                        size: 30,
                      ),
                  ],
                ),
                Gaps.v24,
                // 상영시간 및 장르
                FutureBuilder(
                  future: _movieDetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Text(
                        textAlign: TextAlign.start,
                        "${snapshot.data!.runtime ~/ 60}h ${snapshot.data!.runtime % 60}min | ${snapshot.data!.genre}",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w900,
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                Gaps.v32,
                // Storyline
                Text(
                  "Storyline",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // overview
                Expanded(
                  child: Text(
                    widget.movieInfo.overview,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 40,
                    softWrap: true,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.size8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
                  child: Text(
                    "Buy ticket",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
