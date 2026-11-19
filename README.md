# Aplikasi Resep Makanan

Ujian Project Flutter (DPPB) — tema **Daftar Resep Masakan**.

Aplikasi menampilkan daftar resep masakan, detail resep, pencarian, filter
kategori, favorit, form tambah resep, dan layar kategori. Semua data adalah
**dummy di memori** (tanpa database/API), sesuai ketentuan soal.

---

## Cara Menjalankan

```bash
flutter pub get
flutter run                # ke emulator/HP yang terhubung
flutter test               # menjalankan seluruh widget test
flutter analyze            # cek error dan lint
```

Persyaratan: Flutter SDK 3.x (Dart >= 3.0).

Build APK:

```bash
flutter build apk --debug
# hasil: build/app/outputs/flutter-apk/app-debug.apk
```

---

## Diagram Alur Navigasi

```
                        ┌──────────────────────┐
                        │  SplashScreen        │  route: /splash
                        │  (Stateless)         │
                        └──────────┬───────────┘
                                   │ pushReplacementNamed
                                   │ (tidak bisa kembali)
                                   ▼
                        ┌──────────────────────┐
                        │  HomeScreen          │  route: /home
                        │  (Stateful)          │◄────────────────┐
                        └───┬──────┬───────┬───┘                 │
                            │      │       │                     │
        pushNamed /detail   │      │       │  pushNamed /form    │
        args: Resep         │      │       │  (FAB + Resep)      │
                            │      │       │                     │
                            │      │       │  ◄── pop(Resep) ────┤ (resep
                            │      │       │        objek baru)   │  baru
                            │      │       │                     │  masuk
                            │      │       │                     │  list)
                            │      │       └──────────┐          │
                            ▼      │                  ▼          │
        ┌───────────────────────┐  │      ┌──────────────────┐   │
        │  DetailScreen         │  │      │  FormScreen      │   │
        │  (Stateful)           │  │      │  (Stateful)      │   │
        │  route: /detail       │  │      │  route: /form    │   │
        └──────────┬────────────┘  │      └──────────────────┘   │
                   │               │                             │
   pop(true) ──────┤ hapus         │ pushNamed /kategori         │
   (hasil hapus)   │               │ args: Map<String,List<Resep>>│
                   ▼               ▼                             │
              ┌──────────────────────────────────┐               │
              │  KategoriScreen  route:/kategori │               │
              │  (Stateful)                      │               │
              │  kirim Map  → terima List        │               │
              └──────────────┬───────────────────┘               │
                             │ pop(List<Resep>)                  │
                             └───────────────────────────────────┘
```

### Data yang dikirim / dikembalikan

| Dari | Ke | Cara | Data |
|---|---|---|---|
| Splash | Home | `pushReplacementNamed` | – |
| Home | Detail | `pushNamed` + `arguments` | `Resep` (objek) |
| Home | Form | `pushNamed` | – |
| Form | Home | `Navigator.pop(context, resep)` | `Resep` baru |
| Home | Kategori | `pushNamed` + `arguments` | `Map<String, List<Resep>>` |
| Kategori | Home | `Navigator.pop(context, list)` | `List<Resep>` hasil perubahan |
| Detail | Home / Kategori | `Navigator.pop(context, true)` | `bool` penanda hapus |

`pushReplacementNamed` dipakai di **dua** alur: Splash → Home, dan Form →
Detail (setelah data disimpan, form tidak boleh dibuka lagi lewat tombol back).

---

## Struktur Folder

```
lib/
├── main.dart                  # MaterialApp + daftar named route
├── models/
│   └── resep.dart             # model Resep (List<String> bahan & langkah)
├── data/
│   └── data_resep.dart        # data dummy + Map per kategori
├── screens/
│   ├── splash_screen.dart     # Stateless
│   ├── home_screen.dart       # Stateful (pencarian, filter, favorit)
│   ├── detail_screen.dart     # Stateful (favorit, AlertDialog hapus)
│   ├── form_screen.dart       # Stateful (Form + validasi)
│   └── kategori_screen.dart   # Stateful (Map kategori)
├── widgets/
│   ├── kartu_resep.dart       # Stateless, dipakai Home + Kategori
│   └── tombol_utama.dart      # Stateless, dipakai Home + Form + Detail
└── utils/
    └── konstanta.dart         # warna, tema, nama route
```

---

## Daftar Tempat Kriteria Wajib Dipenuhi

| Kriteria | Lokasi Bukti |
|---|---|
| **2 StatelessWidget** | `widgets/kartu_resep.dart` (`KartuResep`), `widgets/tombol_utama.dart` (`TombolUtama`), `screens/splash_screen.dart` (`SplashScreen`) |
| **2 StatefulWidget** | `screens/home_screen.dart` (`HomeScreen`), `screens/form_screen.dart` (`FormScreen`), `screens/detail_screen.dart` (`DetailScreen`), `screens/kategori_screen.dart` (`KategoriScreen`) |
| **Form input + TextEditingController** | `screens/form_screen.dart` — 5 controller: nama, deskripsi, durasi, bahan, langkah; datanya dipakai membentuk objek `Resep` |
| **Perubahan tampilan dengan setState** | `home_screen.dart` (`_ubahFavorit`, `_bukaDetail`, `_bukaKategori`, `_bukaFilter`), `detail_screen.dart` (`_sudahDibuka`), `kategori_screen.dart` (hapus dari Map) |
| **2 custom widget dipakai ulang** | `KartuResep` dipakai di `home_screen.dart` **dan** `kategori_screen.dart`; `TombolUtama` dipakai di `home_screen.dart`, `form_screen.dart`, `detail_screen.dart` |
| **Row / Column / Stack / Expanded** | `widgets/kartu_resep.dart` (Stack + Expanded untuk gambar), `home_screen.dart` (Row/Column/Expanded), `detail_screen.dart` (Row/Expanded pada bahan & langkah) |
| **ListView / GridView builder** | `home_screen.dart` (`SliverGrid`/`ListView`), `kategori_screen.dart` (`ListView.builder` + `GridView.builder`) |
| **Layout adaptif (LayoutBuilder/MediaQuery)** | `home_screen.dart` — kolom 1 (<600 px), 2 (>=600 px), 3 (>=900 px); `kategori_screen.dart` idem; `detail_screen.dart` padding adaptif |
| **>= 4 screen** | Splash, Home, Detail, Form, Kategori (5 screen) |
| **Named route di MaterialApp** | `main.dart` — `routes:` berisi `Rute.splash`, `Rute.home`, `Rute.detail`, `Rute.form`, `Rute.kategori` |
| **Kirim data lewat arguments** | `home_screen.dart` → `Rute.detail` (objek `Resep`), `Rute.kategori` (objek `Map`) |
| **Terima data lewat konstruktor/arguments** | `main.dart` (`ModalRoute.of(context)!.settings.arguments`), `DetailScreen({required resep})`, `KategoriScreen({required data})` |
| **Terima data kembali (pop)** | `home_screen.dart` (`_tambahResep`, `_bukaDetail`, `_bukaKategori`), `kategori_screen.dart` (`_kembali`) |
| **pushReplacementNamed** | `splash_screen.dart` (Splash → Home), `form_screen.dart` (Form → Detail) |
| **SnackBar + aksi** | `home_screen.dart` (`_ubahFavorit`, `_bukaDetail`), `detail_screen.dart` (`_ubahFavorit`), `kategori_screen.dart` — semuanya punya `SnackBarAction(label: 'BATAL')` |
| **AlertDialog** | `detail_screen.dart` — `_konfirmasiHapus()` (judul "Hapus resep?", tombol BATAL/HAPUS) |
| **BottomSheet** | `home_screen.dart` — `_bukaFilter()` memakai `showModalBottomSheet` untuk memilih kategori |
| **Validasi input** | `form_screen.dart` — validator nama (min 3 karakter), deskripsi, durasi (angka 1–600), bahan, langkah |
| **Ekspresi (perbandingan, kondisional, interpolasi)** | `home_screen.dart` — `_jumlahFavorit`, `resep.favorit ? Icons.favorite : Icons.favorite_border`, `'${resep.nama} dihapus'`; `kartu_resep.dart` — `ringkas ? 110 : 130`; `detail_screen.dart` — `_sudahDibuka ? ... : ...` |
| **Struktur data linear (List)** | `data/data_resep.dart` → `DataResep.semua()` mengembalikan `List<Resep>`; ditampilkan `ListView`/`GridView` dan bisa ditambah/dihapus |
| **Struktur data non-linear (Map + bersarang)** | `data/data_resep.dart` → `perKategori()` mengembalikan `Map<String, List<Resep>>`; `models/resep.dart` → setiap `Resep` punya `List<String> bahan` dan `List<String> langkah` |

### Bukti 4 Jenis Alert

| Jenis | Lokasi | Konteks |
|---|---|---|
| SnackBar (dengan aksi BATAL) | `home_screen.dart`, `detail_screen.dart`, `kategori_screen.dart` | Konfirmasi favorit, undo hapus resep |
| AlertDialog | `detail_screen.dart` | Konfirmasi aksi penting: hapus resep |
| BottomSheet | `home_screen.dart` | Memilih kategori filter |
| Validasi form | `form_screen.dart` | Pesan error per field + SnackBar ringkasan |

---

## Struktur Data: Linear vs Non-linear

**Linear — `List<Resep>`** (`DataResep.semua()`)

```dart
static List<Resep> semua() => [
  Resep(id: 'r1', nama: 'Sate Kambing', ...),
  Resep(id: 'r2', nama: 'Soto Betawi', ...),
];
```

Diakses berurutan dengan indeks (`daftar[i]`), ditampilkan dengan
`ListView.builder`, dan bisa ditambah (`insert`) atau dihapus (`remove`).

**Non-linear — `Map<String, List<Resep>>`** (`DataResep.perKategori()`)

```dart
static Map<String, List<Resep>> perKategori(List<Resep> daftar) {
  final hasil = <String, List<Resep>>{};
  for (final resep in daftar) {
    hasil.putIfAbsent(resep.kategori, () => <Resep>[]).add(resep);
  }
  return hasil;
}
```

Diakses lewat **key** kategori (`data['Seafood']`), bukan indeks angka.
Untuk mengambil semua item pada satu kategori: `data['Tradisional']` →
`List<Resep>` berisi 3 resep.

**Bersarang — objek berisi List** (`models/resep.dart`)

```dart
class Resep {
  final List<String> bahan;   // List di dalam objek
  final List<String> langkah;
  int get jumlahBahan => bahan.length;
}
```

---

## Catatan Teknis

- **Tanpa overflow**: seluruh layar diuji pada 320/390/430 px, tablet 800 px,
  dan landscape 844×390, termasuk skala teks 1.5× dan 2.0× (`test/overflow_test.dart`).
  Kartu resep memakai `Expanded` untuk area gambar sehingga teks tidak pernah
  terdorong keluar; layar detail & form memakai `CustomScrollView`/`SingleChildScrollView`.
- **Tanpa bottom navigation**: navigasi memakai tombol/aksi di dalam layar
  (kartu, FAB, ikon AppBar), sesuai permintaan.
- **Data dummy di memori**: perubahan (tambah/hapus/favorit) hanya bertahan
  selama aplikasi berjalan; tidak ada persistensi.
- **Test**: 34 widget test (`test/overflow_test.dart`, `test/alur_test.dart`)
  mencakup overflow multi-ukuran, pencarian, favorit, validasi form, hapus +
  undo, filter BottomSheet, dan penambahan resep.
