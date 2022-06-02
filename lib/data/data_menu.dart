import 'package:submission_dicoding/model/makanan.dart';

class MenuMakanan {
  static final _titleMenuImage = [
    "assets/IMG/sate.png",
    "assets/IMG/soto.png",
    "assets/IMG/gudeg.png"
  ];

  static final _titleMenu = ["Sate Kambing", "Soto Betawi", "Gudeg Bu Aan"];

  static final _descMenu = [
    "kecap manis, daging kambing, bawang goreng",
    "Daging sapi, tomat, kerupuk, daung bawang",
    "Nangka manis, krecek, aneka bacem"
  ];

  static final _descIsiMenu = [
    "Sate kambing adalah sejenis makanan sate terbuat dari daging kambing. Daging kambing tersebut disate dan dibumbui dengan rempah-rempah dan bumbu dapur, kemudian dibakar. Penyajiannya disajikan bersama lalapan kubis, tomat, dan bawang merah yang diiris tipis kemudian diberi kecap dan ditambahkan taburan merica.",
    "Soto Betawi merupakan soto yang khas dari daerah DKI Jakarta. Seperti halnya Soto Madura dan Soto Sulung, soto Betawi juga menggunakan jeroan. Selain jeroan, sering kali organ-organ lain juga disertakan, seperti mata, terpedo, dan juga hati. Daging sapi juga menjadi bahan campuran dalam soto Betawi.",
    "Gudeg ialah hidangan khas Provinsi Yogyakarta dan Jawa Tengah yang terbuat dari nangka muda yang dimasak dengan santan. Perlu waktu berjam-jam untuk membuat hidangan ini. Warna coklat biasanya dihasilkan oleh daun jati yang dimasak bersamaan."
  ];

  static final _benefitMenu = [
    "1. Mencegah kanker\n 2. Anti inflamasi\n 3. Membakar emak\n 4. Mencegah anemia\n 5. Meningkatkan kesehatan mental\n 6. Mencegah stroke dan gangguan ginjal\n 7. Menjaga kesehatan tulang",
    "1. Menguatkan tulang dan gigi\n 2. Meningkatkan massa otot\n 3. Menyehatkan kulit, rambut, dan kuku\n 4. Menjaga berat badan\n 5. Mengurangi resiko diabetes\n 6. Menambah asupan vitamin dan mineral tubuh\n 7. Meningkatkan imunitas",
    "Berdasarkan data Kemenkes RI (TKPI), setiap 100 gram Gudeg sayur mengandung 12,8 mg besi dan 0,15 mg tiamina. Ini menunjukkan bahwa kandungan besi dan tiamina termasuk tinggi dan cukup tinggi. Menunjang sistem kekebalan tubuh ➠ Manfaat dari tingginya kandungan besi dan tiamina."
  ];

  static final _createMenu = [
    "• Daging kambing, potong dadu 2 cm - 500 gram\n• Tusuk sate, rendam dalam air lalu tiriskan\n• Kubis, iris halus - 50 gram\n• Tomat merah, potong - 2 buah\n• Cabai rawit, iris - 10 buah\n• Bawang merah, iris - 10 butir\n• Kecap manis - 5 sdm\n• Jeruk nipis, belah jadi 4 - 1 buah\n\nLangkah\n• Tusuk daging dengan tusukan sate. Isi setiap tusukan dengan 4 potong daging. Sisihkan.\n• Dalam wadah, campur semua bahan olesan lalu oleskan ke daging sate.\n• Bakar sate di atas bara api sambil sesekali dioles bumbu oles. Bakar hingga berwarna kecoklatan, matang, dan harum. Angkat.\n• Tata semua bahan pelengkap (Acar timun) dan sate di atas piring saji. Tuang kecap manis di atas sate. Siap disajikan.",
    "500 gram daging sanding lamur 2,5 liter air 200 gram babat, rebus, potong 2x2 200 gram paru, rebus, potong 2x2 2 ruas jari kayu manis 3 butir cengkih 4 batang serai, memarkan 2 ruas jari lengkuas 10 lembar daun jeruk, buang tulangnya 3 lembar daun salam 1 sdt pala bubuk 4 sdt garam ½ sdt merica bubuk 2 sdt gula pasir 500 ml santan 2 sdm minyak goreng\n\nBumbu halus:\n15 butir bawang merah 10 siung bawang putih 2 ruas jari jahe 2 ½ sdt ketumbar bubuk\n\nCara membuat soto betawi daging kuah santan\n1. Rebus air dan daging sampai matang dan empuk. Potong 2x2 cm. Ambil kaldunya 2 liter dan rebus lagi.\n2. Masukkan daging, babat, dan paru. Didihkan.\n3. Panaskan minyak. Tumis bumbu halus, kayu manis, cengkih, serai, lengkuas, daun jeruk, dan daun salam sampai harum. Tuang ke dalam rebusan daging. Didihkan lagi.\n4. Masukkan santan, pala bubuk, garam, merica, dan gula. Masak sampai matang.\n5. Sajikan soto Betawi bersama semua bahan pelengkap.",
    "1 kg nangka muda\n5 butir telur ayam rebus, kupas\n2 lembar daun salam\n3 lembar daun jeruk\n3 cm lengkuas, memarkan\n120 g gula Jawa yang cokelat tua\n1.5 liter santan sedang\n500 ml santan kental\n\nBumbu:\n8 butir bawang merah\n5 siung bawang putih\n5 butir kemiri\n1 sdm ketumbar\n1 potong terasi\n1/4 sdt jintan\n2 sdt garam\n\nCara membuat Gudeg\n1. Potong nangka muda berbentuk dadu besar. Rebus nangka muda dalam air atau air kelapa tua secukupnya hingga lunak. Angkat dan tiriskan nangka muda.\n2. Bumbu Halus: Haluskan semua bahan bumbu dengan blender atau ulekan hingga halus benar.\n3. Masukkan nangka muda dan telur ke dalam panci. Tuangi santan, masukkan bumbu halus, daun salam, daun jeruk, lengkuas dan gula merah.\n4. Masak dengan api sedang hingga bumbu meresap dan kuahnya susut.\n5. Tuangkan santan kental. Masak dengan api hingga kuah benar-benar susut. Matikan api.\n6. Sajikan gudeg dengan pelengkapnya."
  ];

  static List<Makanan> listData = (() {
    return Iterable.generate(_titleMenu.length).map((index) {
      return Makanan(
          title: _titleMenu[index],
          description: _descMenu[index],
          imageMenu: _titleMenuImage[index],
          descMenu: _descIsiMenu[index],
          benefitMenu: _benefitMenu[index],
          createMenu: _createMenu[index]
      );
    }).toList();
  })();

}
