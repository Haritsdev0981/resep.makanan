import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:submission_dicoding/Screen/detail/detailpageBar.dart';
import 'package:submission_dicoding/data/data_menu.dart';
import 'package:submission_dicoding/model/makanan.dart';
import 'package:submission_dicoding/widget/appBar.dart';
import 'package:submission_dicoding/widget/tab_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TabController _tabController =
    // TabController(length: 4, vsync: this, initialIndex: 0);

    return Scaffold(
      appBar: setAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //search box
              Container(
                //membuat Widht menjadi responsive pada device
                width: MediaQuery
                    .of(context)
                    .size
                    .height,
                height: 50,

                child: const TextField(
                  textInputAction: TextInputAction.search,
                  style: TextStyle(color: Colors.black54, fontSize: 25),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF54749)),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintText: 'Cari Makanan',
                      hintStyle: TextStyle(color: Colors.black26, fontSize: 18),
                      prefixIcon: Icon(Icons.search)),
                ),
              ),

              //event
              Container(
                margin: EdgeInsets.only(
                    top: 20, bottom: 20, left: 10, right: 10),
                width: MediaQuery
                    .of(context)
                    .size
                    .height,
                height: 160,
                decoration: BoxDecoration(
                    color: Color(0xffFEEBC9),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Resep Andalan\nIbu rumah tangga",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 14),
                          width: 120,
                          height: 34,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xffF54749),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(14))),
                          child: Text(
                            "Lihat Lainnya",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    Image(
                      alignment: Alignment.bottomRight,
                      image: AssetImage("assets/IMG/banner.png"),
                      height: 130,
                    )
                  ],
                ),
              ),

              // nav Menu food

              TabBarContent(itemList: MenuMakanan(),)

            ],
          ),
        ),
      ),
    );
  }
}
