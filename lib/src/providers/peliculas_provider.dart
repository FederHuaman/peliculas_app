import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/models/actor_model.dart';

class PeliculasProvider {
  String _apiKey = 'fe60a9e2ab1b7bab6ea904efcafccc03';
  String _language = 'es-ES';
  String _url = 'api.themoviedb.org';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>();

  // Ingreso al stream
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void closeStreams() => _popularesStreamController?.close();

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final pelicula = Peliculas.fromJson(decodedData['results']);

    return pelicula.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> buscarPeliculas(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;

    print('Cargando Peliculas...');

    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString(),
    });
    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getActores(String peliculaId) async {
    final url = Uri.https(_url, '3/movie/$peliculaId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final actor = Actores.fromJson(decodedData['cast']);

    return actor.actores;
  }
}
