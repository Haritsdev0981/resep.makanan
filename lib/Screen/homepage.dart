
import 'package:flutter/material.dart';
import 'package:submission_dicoding/data/data_menu.dart';
import 'package:submission_dicoding/model/makanan.dart';

import 'package:submission_dicoding/page/bookmarkscreen.dart';
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
        decoration: const BoxDecoration(
          color: Colors.white,
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
                      Icons.book_rounded,
                      color: Color(0xffF54749),
                size: 35,
              )
                  : const Icon(
                Icons.book_outlined,
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
