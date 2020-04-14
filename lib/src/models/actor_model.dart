class Actores {
  List<Actor> actores = new List();

  Actores();

  Actores.fromJson(List<dynamic> jsonList) {
    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> item) {
    castId = item["cast_id"];
    character = item["character"];
    creditId = item["credit_id"];
    gender = item["gender"];
    id = item["id "];
    name = item["name"];
    order = item["order"];
    profilePath = item["profile_path"];
  }
  getProfileImg() {
    if (profilePath == null) {
      return 'https://seeba.se/wp-content/themes/consultix/images/no-image-found-360x260.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
