import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/styles/app_colors.dart';

class MosqueTile extends StatelessWidget {
  String imageUrl;
  String mosqueName;
  String distance;
  MosqueTile({this.imageUrl, this.mosqueName, this.distance});
  planetCard() => new Container(
        height: 124.0,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                mosqueName,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        margin: new EdgeInsets.only(left: 46.0),
        decoration: new BoxDecoration(
          color: primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            ),
          ],
        ),
      );

  Widget planetThumbnail() {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageUrl: imageUrl,
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard(),
            planetThumbnail(),
          ],
        ));
  }
}
