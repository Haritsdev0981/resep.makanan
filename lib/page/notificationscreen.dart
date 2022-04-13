import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Notifikasi  📮📮",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListNotif(),
    );
  }
}

class ListNotif extends StatelessWidget {
  ListNotif({Key? key}) : super(key: key);

  final List namaUser = [
    "Mira Lathila",
    "Axton Albren",
    "Apriel Maictih",
    "Novalion Kobra",
    "Juliet & Romeo",
    "Junica joss",
    "Mei Mei",
    "Agulia Simba",
    "Siasep Angling",
    "Marcoi Sailur",
    "Oktosai Marin",
    "Desumarin"
  ];

  final List infoUser = [
    "Mulai mengikuti Anda",
    "Memberikan anda like",
    "Mulai mengikuti anda",
    "Mempromot anda pada Ceritanya",
    "Mengikuti cerita anda",
    "Mengikuti cerita anda",
    "Memberikan anda Like",
    "Berkomentar pada postingan anda",
    "Berkomentar pada postingan anda",
    "Mulai mengikuti Anda",
    "Memberikan anda like",
    "Menyebut anda di ceritanya"
  ];
  final List imgUser = [
    "https://divedigital.id/wp-content/uploads/2021/10/11-min-1.jpg",
    "https://i.pinimg.com/736x/e1/56/cc/e156cc6f5e492aad82087dde45b8696c.jpg",
    "https://i.pinimg.com/1200x/51/46/cd/5146cdb5ab2a923a76c681ec6700e909.jpg",
    "https://i.pinimg.com/originals/fd/05/5b/fd055b9185f9db710aa8eca7b7669a03.jpg",
    "https://i.pinimg.com/originals/93/00/a1/9300a14049ec38e3636c785fc600f43b.jpg",
    "https://p4.wallpaperbetter.com/wallpaper/88/701/158/anime-landscape-nature-peace-wallpaper-preview.jpg",
    "https://wallpaperaccess.com/full/6578576.jpg",
    "https://p4.wallpaperbetter.com/wallpaper/32/846/574/anime-landscape-cloud-mountain-sky-hd-wallpaper-preview.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTp_bzLt_Wv9AlN4dzUophsd7WIhrkD7HEzMg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFXRnDuHmGlqrUYIl6t7IPIU2dU-5bDwDVLw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwRuSHrDeI9qxAxIL5-8nwd9mVdGIH9OgWrA&usqp=CAU",
    "https://p4.wallpaperbetter.com/wallpaper/1006/964/55/sakura-blossom-clouds-scenic-rainbow-wallpaper-preview.jpg"
  ];

  final List iconNotif = [
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
    const Icon(Icons.send_sharp, color: Color(0xff3F3D56), size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Container(
              child: Card(
                color: Color(0xffFEEBC9),
                child: ListTile(
                    title: Text(namaUser[index],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    subtitle: Text(infoUser[index],
                        style: const TextStyle(fontSize: 10)),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(imgUser[index]),
                    ),
                    trailing: iconNotif[index]),
              ),
            ),
          );
        },
        itemCount: namaUser.length,
      ),
    );
  }
}
