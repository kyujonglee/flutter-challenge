class MovieDetailModel {
  final bool adult;
  final String backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        belongsToCollection = json['belongs_to_collection'] != null
            ? BelongsToCollection.fromJson(json['belongs_to_collection'])
            : null,
        budget = json['budget'],
        genres = (json['genres'] as List)
            .map((genre) => Genre.fromJson(genre))
            .toList(),
        homepage = json['homepage'],
        id = json['id'],
        imdbId = json['imdb_id'],
        originCountry = List<String>.from(json['origin_country']),
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'].toDouble(),
        posterPath = json['poster_path'],
        productionCompanies = (json['production_companies'] as List)
            .map((company) => ProductionCompany.fromJson(company))
            .toList(),
        productionCountries = (json['production_countries'] as List)
            .map((country) => ProductionCountry.fromJson(country))
            .toList(),
        releaseDate = json['release_date'],
        revenue = json['revenue'],
        runtime = json['runtime'],
        spokenLanguages = (json['spoken_languages'] as List)
            .map((language) => SpokenLanguage.fromJson(language))
            .toList(),
        status = json['status'],
        tagline = json['tagline'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'].toDouble(),
        voteCount = json['vote_count'];
}

class BelongsToCollection {
  final int id;
  final String name;
  final String posterPath;
  final String backdropPath;

  BelongsToCollection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        posterPath = json['poster_path'],
        backdropPath = json['backdrop_path'];
}

class Genre {
  final int id;
  final String name;

  Genre.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompany.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        logoPath = json['logo_path'],
        name = json['name'],
        originCountry = json['origin_country'];
}

class ProductionCountry {
  final String iso31661;
  final String name;

  ProductionCountry.fromJson(Map<String, dynamic> json)
      : iso31661 = json['iso_3166_1'],
        name = json['name'];
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage.fromJson(Map<String, dynamic> json)
      : englishName = json['english_name'],
        iso6391 = json['iso_639_1'],
        name = json['name'];
}
