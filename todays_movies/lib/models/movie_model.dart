class MovieModel {
  final bool adult;
  final String backdropPath;
  final List<dynamic> genre;
  final dynamic id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final dynamic popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final dynamic voteAverage;
  final dynamic voteCount;

  MovieModel.fromJson(Map<String, dynamic> json)
      : adult = json["adult"],
        backdropPath = json["backdrop_path"],
        genre = json["genre_ids"],
        id = json["id"],
        originalLanguage = json["original_language"],
        originalTitle = json["original_title"],
        overview = json["overview"],
        popularity = json["popularity"],
        posterPath = json["poster_path"],
        releaseDate = json["release_date"],
        title = json["title"],
        video = json["video"],
        voteAverage = json["vote_average"],
        voteCount = json["vote_count"];
}
