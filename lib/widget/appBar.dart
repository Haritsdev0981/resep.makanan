// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//Menambahkan Const pada setiap widget yang tetap

PreferredSize setAppBar() {
  return PreferredSize(
    preferredSize:const Size.fromHeight(100.0),
    child: Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
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
                    image:const DecorationImage(image: AssetImage("assets/IMG/cwk.png"))),
                width: 60,
                margin:const EdgeInsets.all(5),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
