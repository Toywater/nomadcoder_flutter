import 'dart:convert';

import 'package:todays_movies/models/movie_detail_model.dart';
import 'package:todays_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieInfoService {
  static final String _popularMovieUrl = "https://movies-api.nomadcoders.workers.dev/popular";
  static final String _nowInCimenaUrl = "https://movies-api.nomadcoders.workers.dev/now-playing";
  static final String _commingSoonUrl = "https://movies-api.nomadcoders.workers.dev/coming-soon";
  static final String _movieDetailUrl = "https://movies-api.nomadcoders.workers.dev/movie?id=";
  static final String _imageBaseUrl = "https://image.tmdb.org/t/p/w500";

  static Future<List<MovieModel>> getPopularMovies() async {
    return await getMovieModels(_popularMovieUrl);
  }

  static Future<List<MovieModel>> getNowInCinema() async {
    return await getMovieModels(_nowInCimenaUrl);
  }

  static Future<List<MovieModel>> getCommingSoon() async {
    return await getMovieModels(_commingSoonUrl);
  }

  static Future<List<MovieModel>> getMovieModels(String movieUrl) async {
    List<MovieModel> retVals = [];
    var url = Uri.parse(movieUrl);

    try {
      var httpResp = await http.get(url);
      if (httpResp.statusCode == 200) {
        var jsonDec = jsonDecode(httpResp.body);

        for (var jsonItem in jsonDec["results"]) {
          retVals.add(MovieModel.fromJson(jsonItem));
        }

        return retVals;
      }
    } catch (e) {
      print(e.toString());
    }

    throw Error();
  }

  static String getImageUrl(String imageId) {
    return _imageBaseUrl + imageId;
  }

  // 영화 세부 정보 리턴
  static Future<MovieDetailModel?> getMovieDetailModel(int movieId) async {
    MovieDetailModel? retVal;
    var url = Uri.parse(_movieDetailUrl + movieId.toString());

    try {
      var httpResp = await http.get(url);
      if (httpResp.statusCode == 200) {
        var jsonDec = jsonDecode(httpResp.body);

        retVal = MovieDetailModel.fromJson(jsonDec);
      }

      return retVal;
    } catch (e) {
      print(e.toString());
    }

    throw Error();
  }
}
