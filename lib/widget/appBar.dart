// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

PreferredSize setAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(100.0),
    child: Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Halo Dico,",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Selamat Pagi 👋",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(image: AssetImage("assets/IMG/cwk.png"))),
                width: 60,
                margin: EdgeInsets.all(5),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
