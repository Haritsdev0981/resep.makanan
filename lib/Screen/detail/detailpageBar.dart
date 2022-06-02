import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:submission_dicoding/model/makanan.dart';
import 'package:submission_dicoding/widget/appBarDetail.dart';
import 'package:submission_dicoding/widget/detailCard/card.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.makanan}) : super(key: key);

  final Makanan makanan;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffFFEECA),
            // gradient: LinearGradient(
            // colors: <Color>[Colors.blue, Colors.pink],
            // ),
          ),
          child: AppBarDetail(
            makanan: widget.makanan,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xffFFEECA),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  width: 375,
                  height: 550,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: ExpandableTheme(
                    data: ExpandableThemeData(
                      useInkWell: true,
                    ),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(left: 20, right: 20, top: 120),
                      children: [
                        Text(
                          "Resep & Makanan",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Card1(
                          makanan: widget.makanan,
                        ),
                        Card2(
                          makanan: widget.makanan,
                        ),
                        Card3(
                          makanan: widget.makanan,
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                  top: 80,
                  right: 0,
                  left: 0,
                  child: Image.asset(
                    widget.makanan.imageMenu,
                    height: 220,
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
