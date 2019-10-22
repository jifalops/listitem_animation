import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'details_screen.dart';
import 'hero_text.dart';

class ListScreen extends StatelessWidget {
  ListScreen(this.images);
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Scaffold(
      appBar: AppBar(title: Text('List of the Things')),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) =>
            ListItem(index, images[index % images.length]),
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  ListItem(this.index, this.url);
  final int index;
  final String url;
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 8 : 0,
      child: ListTile(
        leading: Hero(
          tag: 'image-${widget.index}',
          child: Image.network(widget.url, height: 64, width: 64),
        ),
        title: Hero(
          tag: 'title-${widget.index}',
          child: Text('Thing ${widget.index}'),
        ),
        // title: HeroText(
        //   tag: 'title-${widget.index}',
        //   text: 'Thing ${widget.index}',
        // ),
        subtitle: Text('Pick me!'),
        onTap: () async {
          // Elevate card
          setState(() => selected = true);
          await Future.delayed(
              Duration(milliseconds: 100 * timeDilation.round()));

          // Change screen
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailsScreen(widget.index, widget.url),
            ),
          );
          // Returning to this screen from details...

          // Wait for hero animations to complete, then de-elevate the card.
          await Future.delayed(
              Duration(milliseconds: 300 * timeDilation.round()));
          setState(() => selected = false);
        },
      ),
    );
  }
}
