import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = PeliculasProvider();

  String opcionSeleccionado = '';

  final peliculas = [
    'Ad astra',
    'Bad Boys for life',
    'Sonic: La pelicula',
    'Star Wars',
    'Bloodshot',
    'Aves de Presa (y la titita)',
    'El hoyo',
    'Jumanji: Siguiente pelicula',
    'El hombre invisible'
  ];

  final peliculaRecomendas = [
    'Sonic',
    'Bad Boys',
    'Fuga de pretoria',
    'Emma',
    'Mujercitas'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar

    return Center(
      child: Container(
        child: Text(opcionSeleccionado),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son la sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProvider.buscarPeliculas(query),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return crearLista(snapshot.data);
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget crearLista(List<Pelicula> peliculas) {
    return ListView.builder(
      itemCount: peliculas.length,
      itemBuilder: (BuildContext context, int index) {
        peliculas[index].uniqueId = '${peliculas[index].id}-busqueda';
        return ListTile(
          title: Text(peliculas[index].title),
          subtitle: Text(peliculas[index].originalTitle),
          leading: Hero(
            tag: peliculas[index].uniqueId,
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(peliculas[index].getPosterImg()),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            // close(context, null);
            Navigator.pushNamed(context, 'detalle',
                arguments: peliculas[index]);
          },
        );
      },
    );
  }
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son la sugerencias que aparecen cuando la persona escribe

  //   final sugerencia = query.isEmpty
  //       ? peliculaRecomendas
  //       : peliculas
  //           .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();

  //   return ListView.builder(
  //     itemCount: sugerencia.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(sugerencia[i]),
  //         onTap: () {
  //           opcionSeleccionado = sugerencia[i];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }
}
