class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJson(List<dynamic> jsonList) {
    if (items == null) return;

    for (var item in jsonList) {
      final pelicula = Pelicula.fromJsonMap(item);

      items.add(pelicula);
    }
  }
}

class Pelicula {
  String uniqueId;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> item) {
    popularity = item['popularity'];
    voteCount = item['vote_count'];
    video = item['video'];
    posterPath = item['poster_path'];
    id = item['id'];
    adult = item['adult'];
    backdropPath = item['backdrop_path'];
    originalLanguage = item['original_language'];
    originalTitle = item['original_title'];
    genreIds = item['genre_ids'].cast<int>();
    title = item['title'];
    voteAverage = item['vote_average'] / 1;
    overview = item['overview'];
    releaseDate = item['release_date'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://seeba.se/wp-content/themes/consultix/images/no-image-found-360x260.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackdropImg() {
    if (backdropPath == null) {
      return 'https://seeba.se/wp-content/themes/consultix/images/no-image-found-360x260.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
