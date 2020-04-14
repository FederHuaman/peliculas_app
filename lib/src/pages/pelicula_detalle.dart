import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  final peliculaProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              _posterTitulo(context, pelicula),
              _descripcion(context, pelicula),
              _actores(pelicula),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      centerTitle: true,
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          overflow: TextOverflow.clip,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(pelicula.getBackdropImg()),
          fit: BoxFit.fill,
          fadeInDuration: Duration(milliseconds: 150),
        ),
      ),
    );
  }

  _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.title),
                Text(pelicula.originalTitle,
                    style: Theme.of(context).textTheme.subhead),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star_border,
                      color: Colors.red,
                    ),
                    Text(pelicula.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subhead)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _descripcion(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _actores(Pelicula pelicula) {
    return FutureBuilder(
      future: peliculaProvider.getActores(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActorListView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearActorListView(List<Actor> peliculas) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
          itemCount: peliculas.length,
          pageSnapping: false,
          controller: PageController(initialPage: 1, viewportFraction: 0.3),
          itemBuilder: (context, i) {
            return _crearTarjetaActor(peliculas[i]);
          }),
    );
  }

  Widget _crearTarjetaActor(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getProfileImg()),
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
