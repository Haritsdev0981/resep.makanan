import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:submission_dicoding/Screen/detail/detailpageBar.dart';
import 'package:submission_dicoding/data/data_menu.dart';

class TabBarContent extends StatefulWidget {
  const TabBarContent({Key? key, required this.itemList}) : super(key: key);

  @override
  State<TabBarContent> createState() => _TabBarContentState();
  final MenuMakanan itemList;
}

class _TabBarContentState extends State<TabBarContent>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 4, vsync: this);

    return Column(
      children: [
        Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              labelColor: Color(0xffF54749),
              isScrollable: true,
              //indicator: CircleTabIndicator(color: Color(0xffF54749), radius: 4),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: "Tradisional",
                ),
                Tab(
                  text: "Cepat Saji",
                ),
                Tab(
                  text: "Seafood",
                ),
                Tab(
                  text: "Minuman",
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 220,
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                  itemCount: MenuMakanan.listData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final makanan = MenuMakanan.listData[index];
                    return Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 5, top: 10, left: 10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(makanan: makanan,) ));
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 30,
                              top: 10,
                              child: Container(
                                height: 161,
                                width: 160,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                    ),
                                    Text(
                                      makanan.title,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 23, right: 23),
                                      child: Text(
                                        makanan.description,
                                        style: TextStyle(fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Container(
                                      margin: EdgeInsets.only(top: 14),
                                      width: 160,
                                      height: 35,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF54749),
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                                      child: Text(
                                        "Baca Resep",
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Image.asset(
                                makanan.imageMenu,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              ListView.builder(itemBuilder: (_, index) {
                return Container(
                  height: 190,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              }),
              ListView.builder(itemBuilder: (_, index) {
                return Container(
                  height: 190,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              }),
              ListView.builder(itemBuilder: (_, index) {
                return Container(
                  height: 190,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              })
            ],
          ),
        )
      ],
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // TODO: implement paint
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset = offset = Offset(
        configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
