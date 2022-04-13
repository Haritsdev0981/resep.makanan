
import 'package:submission_dicoding/model/makanan.dart';

class MenuMakanan {
  static final _titleMenuImage = [
    "assets/IMG/sate.png",
    "assets/IMG/soto.png"
  ];

  static final _titleMenu = [
    "Sate Kambing",
    "Soto Betawi"
  ];

  static final _descrisiMenu = [
    "kecap manis, daging kambing, bawang goreng",
    "Daging sapi, tomat, kerupuk, daung bawang"
  ];

  static List<Makanan> listData = ((){
    return Iterable.generate(_titleMenu.length).map((index) {
      return Makanan(title: _titleMenu[index], description: _descrisiMenu[index], imageMenu: _titleMenuImage[index]);
    }).toList();
  })();
}