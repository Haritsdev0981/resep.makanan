//menghapus import cupertino di sini
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
             Image(
              image: AssetImage('assets/IMG/bg_splash.png'),
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}

// Widget buildDragStart() => Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.all(Radius.circular(30)),
//     color: Color(0xFFF54749),
//   ),
//   height: 70,
//   width: 220,
// );
