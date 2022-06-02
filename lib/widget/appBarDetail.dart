import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:submission_dicoding/model/makanan.dart';
import 'package:submission_dicoding/page/homescreen.dart';

class AppBarDetail extends StatelessWidget {
  const AppBarDetail({
    Key? key,
    required this.makanan,
  }) : super(key: key);

  final Makanan makanan;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Container(
                    color: Colors.white,
                    child: Icon(
                      Icons.arrow_back,
                      size: 32,
                    ),
                  ),
                ),
              ),
              Text(
                makanan.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.bookmark_outline),
                    onPressed:(){
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
