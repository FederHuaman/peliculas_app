import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  //const CardSwiper({Key key}) : super(key: key);

  final List<Pelicula> items;

  CardSwiper({@required this.items});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          items[index].uniqueId = '${items[index].id}-tarjeta';

          return GestureDetector(
            child: Hero(
              tag: items[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(items[index].getPosterImg()),
                    fit: BoxFit.fill),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'detalle', arguments: items[index]);
            },
          );
        },
        itemCount: items.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
