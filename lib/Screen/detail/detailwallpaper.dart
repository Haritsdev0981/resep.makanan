import 'package:flutter/material.dart';

class DetailWallpaper extends StatelessWidget {
  const DetailWallpaper({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Hero(tag: url, child: Image.network(url)),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
