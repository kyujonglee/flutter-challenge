class MovieModel {
  final String title, overview, posterPath, backdropPath;
  final int id;
  final bool adult;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;
  final double popularity;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        backdropPath = json['backdrop_path'],
        id = json['id'],
        adult = json['adult'],
        genreIds = List<int>.from(json['genre_ids']),
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        popularity = json['popularity'].toDouble(),
        releaseDate = json['release_date'],
        voteAverage = json['vote_average'].toDouble(),
        voteCount = json['vote_count'];
}
