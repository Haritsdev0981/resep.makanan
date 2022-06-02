import 'package:flutter/material.dart';
import 'package:submission_dicoding/data/data_menu.dart';
import 'package:submission_dicoding/model/makanan.dart';

import 'package:submission_dicoding/page/wallpaperscreen.dart';
import 'package:submission_dicoding/page/homescreen.dart';
import 'package:submission_dicoding/page/notificationscreen.dart';

//menghapus import dari file ini ke notification.dart

//Menambahkan Const pada setiap widget yang tetap

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int pageIndex = 0;

  final pages = [
    const HomeScreen(),
    const NotificationScreen(),
    const BookmarkScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 80,
        margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                      Icons.home_filled,
                      color: Color(0xffF54749),
                      size: 35,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.black12,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.notifications_rounded,
                      color: Color(0xffF54749),
                      size: 35,
                    )
                  : const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.black12,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.picture_in_picture_alt_rounded,
                      color: Color(0xffF54749),
                      size: 35,
                    )
                  : const Icon(
                      Icons.picture_in_picture_alt_outlined,
                      color: Colors.black12,
                      size: 35,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
