import 'package:flutter/material.dart';
import 'package:submission_dicoding/widget/appBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(),
      body: Container(
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

                child:GestureDetector(
                  child: const TextField(
                    textInputAction: TextInputAction.search,
                    style: TextStyle(color: Colors.black54, fontSize: 25),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54), borderRadius: BorderRadius.all(Radius.circular(15))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffF54749)), borderRadius: BorderRadius.all(Radius.circular(15))),
                        hintText: 'Cari Makanan',
                        hintStyle: TextStyle(color: Colors.black26, fontSize: 18),
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}