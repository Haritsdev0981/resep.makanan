import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //membungkus Container Dengan Padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              //membuat Widht menjadi responsive pada device
              width: MediaQuery.of(context).size.height,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: const TextField(
                style: TextStyle(color: Colors.white, fontSize: 25),
                decoration: InputDecoration(
                    hintText: 'Cari Makanan',
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 18),
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
