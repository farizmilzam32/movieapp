// To parse this JSON data, do
//
//     final trendingMovies = trendingMoviesFromJson(jsonString);

import 'dart:convert';

TrendingMovies trendingMoviesFromJson(String str) =>
    TrendingMovies.fromJson(json.decode(str));

String trendingMoviesToJson(TrendingMovies data) => json.encode(data.toJson());

class TrendingMovies {
  TrendingMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory TrendingMovies.fromJson(Map<String, dynamic> json) => TrendingMovies(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  Result({
     this.originalLanguage,
     this.posterPath,
     this.firstAirDate,
     this.id,
     this.overview,
     this.voteCount,
     this.voteAverage,
    this.genreIds,
     this.name,
     this.backdropPath,
     this.originalName,
     this.originCountry,
     this.popularity,
     this.mediaType,
     this.originalTitle,
     this.releaseDate,
     this.title,
     this.adult,
     this.video,
  });

  String? originalLanguage;
  String? posterPath;
  DateTime? firstAirDate;
  int? id;
  String? overview;
  int? voteCount;
  double? voteAverage;
  List<int>? genreIds;
  String? name;
  String? backdropPath;
  String? originalName;
  List<String>? originCountry;
  double? popularity;
  MediaType? mediaType;
  String? originalTitle;
  DateTime? releaseDate;
  String? title;
  bool? adult;
  bool? video;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        originalLanguage: json["original_language"],
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        id: json["id"],
        overview: json["overview"],
        voteCount: json["vote_count"],
        voteAverage: json["vote_average"].toDouble(),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        name: json["name"] ?? null,
        backdropPath: json["backdrop_path"],
        originalName:
            json["original_name"] == null ? null : json["original_name"],
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        popularity: json["popularity"].toDouble(),
        mediaType: mediaTypeValues.map![json["media_type"]],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        title: json["title"] == null ? null : json["title"],
        adult: json["adult"] == null ? null : json["adult"],
        video: json["video"] == null ? null : json["video"],
      );

  Map<String, dynamic> toJson() => {
        "original_language": originalLanguage,
        "poster_path": posterPath,
        "first_air_date": firstAirDate == null
            ? null
            : "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "id": id,
        "overview": overview,
        "vote_count": voteCount,
        "vote_average": voteAverage,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "name": name == null ? null : name,
        "backdrop_path": backdropPath,
        "original_name": originalName == null ? null : originalName,
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "popularity": popularity,
        "media_type": mediaTypeValues.reverse[mediaType],
        "original_title": originalTitle == null ? null : originalTitle,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title == null ? null : title,
        "adult": adult == null ? null : adult,
        "video": video == null ? null : video,
      };
}

enum MediaType { TV, MOVIE }

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
