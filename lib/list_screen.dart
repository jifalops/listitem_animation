import 'package:flutter/material.dart';
import 'details_screen.dart';
import 'route_animations.dart';

const images = [
  'https://images.unsplash.com/photo-1540573133985-87b6da6d54a9?ixlib=rb-1.2.1&w=1000&q=80',
  'https://static.independent.co.uk/s3fs-public/thumbnails/image/2014/02/18/20/monkey.jpg?w968h681',
  'https://cdn.vox-cdn.com/thumbor/G_Ts5lMSVPW3grBjSZ924gvyg-s=/0x0:666x444/1200x800/filters:focal(266x140:372x246)/cdn.vox-cdn.com/uploads/chorus_image/image/59491841/Macaca_nigra_self-portrait__rotated_and_cropped_.0.jpg',
  'https://ichef.bbci.co.uk/news/660/cpsprodpb/E9DF/production/_96317895_gettyimages-164067218.jpg',
  'https://guinnessworldrecords.com/Images/Proboscis-monkey_tcm25-416180.jpg',
  'https://thumbs-prod.si-cdn.com/o6o5GUuWyPPvZsStbI2iElKRSm0=/800x600/filters:no_upscale()/https://public-media.si-cdn.com/filer/36/e1/36e12c18-426f-4639-a3f0-39599edbed4d/42-56243662.jpg',
  'http://www.jamaicaobserver.com/apps/pbcsi.dll/storyimage/JO/20190707/ARTICLE/307079964/AR/0/AR-307079964.jpg',
  'https://img.etimg.com/thumb/height-450,width-800,imgsize-44760,msid-50562617/.jpg',
  'https://static.independent.co.uk/s3fs-public/thumbnails/image/2019/07/15/14/istock-177110464.jpg'
];

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of the Things')),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) =>
              ListItem(index, images[index % images.length])),
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
  bool largeText = false;

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
          child: largeText
              ? Text(
                  'Thing ${widget.index}',
                  style: Theme.of(context).textTheme.display1,
                )
              : Text('Thing ${widget.index}'),
        ),
        subtitle: Text('Pick me!'),
        onTap: () async {
          // Elevate card
          setState(() => selected = true);
          await Future.delayed(Duration(milliseconds: 100));

          // Change screen
          await Navigator.of(context).push(
            FadePageRoute(
              builder: (context) => DetailsScreen(widget.index, widget.url),
            ),
          );

          // Returning to this screen...
          // This works around the text being too large for its container when
          // animating back from the DetailsScreen.
          setState(() => largeText = true);

          // Wait for hero animations to complete, then de-elevate the card.
          await Future.delayed(Duration(milliseconds: 250));
          setState(() {
            selected = false;
            largeText = false;
          });
        },
      ),
    );
  }
}
