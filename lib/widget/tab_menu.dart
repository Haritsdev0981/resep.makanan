import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarContent extends StatefulWidget {
  const TabBarContent({Key? key}) : super(key: key);

  @override
  State<TabBarContent> createState() => _TabBarContentState();
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
          height: 260,
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 20, top: 10),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            child: Container(
                              height: 190,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Sate Kambing",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Kecap manis, Daging ..",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Image(
                            image: AssetImage("assets/IMG/sate.png"),
                            height: 100,
                          ),
                        ],
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
