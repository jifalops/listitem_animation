import 'package:flutter/material.dart';
import 'hero_text.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen(this.index, this.url);
  final int index;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 64),
          child: Center(
            child: Hero(
              tag: 'title-$index',
              child: Text(
                'Thing $index details',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            // child: HeroText(
            //   tag: 'title-$index',
            //   text: 'Thing $index details',
            //   style: Theme.of(context).textTheme.display1,
            // ),
          ),
        ),
        Hero(tag: 'image-$index', child: Image.network(url))
      ],
    ));
  }
}
