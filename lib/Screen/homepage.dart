import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_dicoding/Screen/notificationpage.dart';
import 'package:submission_dicoding/widget/appBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int pageIndex = 0;

  final pages = [
    const Page1(),
    const Page2(),
    const Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(),
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

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 335,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextField(
              style: TextStyle(color: Colors.white, fontSize: 25),
              decoration: InputDecoration(
                  hintText: 'Cari Makanan',
                  hintStyle: TextStyle(color: Colors.black26, fontSize: 18),
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 2",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 3",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
