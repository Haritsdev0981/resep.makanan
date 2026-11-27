# Rangkuman Review & Audit Assessment 2 DPPB
**Project:** Aplikasi Resep Makanan  
**Mata Kuliah:** Desain dan Pemrograman Perangkat Bergerak (DPPB)  
**Dokumen Acuan:** `Kriteria Assessment 2 DPPB.pdf`  
**Waktu Audit:** 27 November 2026  

---

## 1. Ringkasan Status Kelengkapan

| Kategori Penilaian | Bobot | Status Kelengkapan | Skor Estimasi Rubrik (1-4) |
|---|---|---|---|
| **Widget Dasar (Stateless & Stateful)** | 8% | **Sangat Lengkap (Terpenuhi)** | 4 / 4 (Sangat Baik) |
| **Layout & Adaptive Layout** | 8% | **Sangat Lengkap (Terpenuhi)** | 4 / 4 (Sangat Baik) |
| **Navigasi & Passing Data** | 8% | **Sangat Lengkap (Terpenuhi)** | 4 / 4 (Sangat Baik) |
| **Alert & Pemberitahuan** | 6% | **Sangat Lengkap (Terpenuhi)** | 4 / 4 (Sangat Baik) |
| **Ekspresi, Modularitas & Struktur Data** | 10% | **Sangat Lengkap (Terpenuhi)** | 4 / 4 (Sangat Baik) |
| **Total Tahap 1 (Project - CLO C)** | **40%** | **Sangat Lengkap (100% Kriteria Terpenuhi)** | **40 / 40** |
| **Dokumen Kelompok & README (CLO A)** | 15% | **Perlu Pelengkapan Anggota Kelompok** | 3 / 4 (Baik) *(menunggu data anggota)* |

---

## 2. Evaluasi Kesesuaian Scope Kode dengan Materi DPPB

Berdasarkan silabus dan panduan **Kriteria Assessment 2 DPPB.pdf**:
1. **Fokus Materi Pokok DPPB:**
   - Stateless & Stateful Widget.
   - Form input & Controller.
   - setState.
   - Custom reusable widget.
   - Kombinasi Layout (`Row`, `Column`, `Stack`, `Expanded`, `ListView`, `GridView`).
   - Adaptive Layout (`LayoutBuilder`/`MediaQuery`, pencegahan overflow pada orientasi landscape).
   - Navigasi (Named routes di `MaterialApp`, `pushReplacementNamed`, passing data dua arah: `arguments` & `Navigator.pop(context, data)`).
   - Alert & Pemberitahuan (`SnackBar` dengan action, `AlertDialog`, `BottomSheet`, validasi form).
   - Dart fundamental & OOP: Struktur linear (`List<Model>`), struktur non-linear (`Map<String, List<Model>>` / bersarang), ekspresi kondisional, string interpolation.
   - State & Data: Tersimpan di memori (*in-memory*), **tanpa database lokal (SQLite/Hive) atau REST API/internet**, agar fokus pengujian pada kompetensi dasar UI & struktur data tercapai.
2. **Kesesuaian Scope pada Project:**
   - **Tepat Sasaran:** Seluruh kode murni menggunakan pustaka bawaan Flutter (`flutter/material.dart`) dan Dart SDK, tanpa third-party state management yang rumit (seperti Bloc/Provider) atau database eksternal yang di luar scope penilaian.
   - **Tema Terdaftar:** Mengambil tema resmi dari tabel panduan halaman 5, yaitu **"Daftar resep masakan"** dengan arsitektur data linear `List<Resep>` dan non-linear `Map<String, List<Resep>>`.

---

## 3. Matriks Kriteria Rubrik Penilaian & Bukti Pemenuhan Kode

Berikut rincian audit terhadap seluruh butir pada file panduan:

### A. Widget Dasar (CLO C - Bobot 8%)
- [x] **Minimal 2 StatelessWidget buatan sendiri:**
  - `KartuResep` di [kartu_resep.dart](file:///d:/latihan%20dppb%201/resep.makanan/lib/widgets/kartu_resep.dart)
  - `TombolUtama` dan `JudulBagian` di [tombol_utama.dart](file:///d:/latihan%20dppb%201/resep.makanan/lib/widgets/tombol_utama.dart)
- [x] **Minimal 2 StatefulWidget buatan sendiri:**
  - `SplashScreen` di [splash_screen.dart](file:///d:/latihan%20dppb%201/resep.makanan/lib/screens/splash_screen.dart)
  - `LoginScreen` di [login_screen.dart](file:///d:/latihan%20dppb%201/resep.makanan/lib/screens/login_screen.dart)
  - `HomeScreen` di [home_screen.dart](file:///d:/latihan%20dppb%201/resep.makanan/lib/screens/home_screen.dart)
  - `DetailScreen` di [detail_screen.dart](file:///d:/latihan%20dppb%201/resep.makanan/lib/screens/detail_screen.dart)
  - `FormScreen` di [form_screen.dart](file:///d:/latihan%20dppb%201/resep.makanan/lib/screens/form_screen.dart)
  - `KategoriScreen` di [kategori_screen.dart](file:///d:/latihan%20dppb%201/resep.makanan/lib/screens/kategori_screen.dart)
- [x] **Minimal 1 Form input dengan TextField & TextEditingController yang datanya dipakai:**
  - `LoginScreen`: `_usernameController` & `_passwordController` digunakan untuk otentikasi login.
  - `FormScreen`: 5 `TextEditingController` (`_namaController`, `_deskripsiController`, `_durasiController`, `_bahanController`, `_langkahController`) digunakan untuk instansiasi objek `Resep`.
  - `HomeScreen`: `_cariController` untuk menyaring daftar resep secara real-time.
- [x] **Minimal 1 perubahan tampilan dengan setState:**
  - `HomeScreen`: toggle status favorit, penyaringan kata kunci/kategori, penambahan/penghapusan resep.
  - `LoginScreen`: toggle visibilitas password (`_sandiTersembunyi`).
  - `DetailScreen`: toggle status favorit dan tombol penanda "sedang dimasak".
- [x] **Minimal 2 custom widget yang dipakai ulang di lebih dari satu tempat:**
  - `KartuResep`: dipakai di `HomeScreen` (horizontal list) dan `KategoriScreen` (vertical grid).
  - `TombolUtama`: dipakai di `LoginScreen`, `HomeScreen` (banner & empty state), `FormScreen`, dan `DetailScreen`.

### B. Layout dan Adaptive Layout (CLO C - Bobot 8%)
- [x] **Kombinasi Row, Column, Stack atau Expanded, serta ListView atau GridView:**
  - `Row` & `Column`: tersebar di seluruh screen dan widget komponen.
  - `Stack`: digunakan pada `KartuResep` untuk menumpuk gambar latar, badge kategori, dan icon button favorit.
  - `Expanded`: digunakan di `KartuResep`, `DetailScreen`, `HomeScreen` untuk mencegah overflow layout.
  - `ListView`: digunakan di `HomeScreen` (`ListView.separated` horizontal), `DetailScreen` (list bahan), `KategoriScreen`, serta modal bottom sheet.
  - `GridView`: digunakan di `KategoriScreen` (`GridView.builder` adaptif).
- [x] **Tampilan berbeda untuk layar sempit dan lebar dengan LayoutBuilder / MediaQuery:**
  - `KategoriScreen`: menggunakan `LayoutBuilder` untuk mengatur kolom grid: lebar < 600px = 1 kolom, lebar 600–899px = 2 kolom, lebar >= 900px = 3 kolom.
  - `HomeScreen`: menggunakan `LayoutBuilder` untuk kalkulasi lebar kartu resep (clamp dinamis) dan padding adaptif (16px vs 24px).
  - `LoginScreen`: pembatasan lebar kartu form (lebar kartu 420px di layar >= 600px).
- [x] **Tidak ada error overflow saat aplikasi diputar ke mode landscape:**
  - Diuji dan diverifikasi menggunakan widget test khusus (`test/overflow_test.dart`) pada ukuran lanskap 844x390 dan tablet 800px. Semua lolos tanpa garis kuning-hitam (*A RenderFlex overflowed...*).

### C. Navigasi (CLO C - Bobot 8%)
- [x] **Minimal 4 screen dengan named route yang didaftarkan di MaterialApp:**
  - Terdapat 6 screen yang terdaftar di [main.dart](file:///d:/latihan%20dppb%201/resep.makanan/lib/main.dart):
    1. `Rute.splash` (`/`)
    2. `Rute.login` (`/login`)
    3. `Rute.home` (`/home`)
    4. `Rute.form` (`/form`)
    5. `Rute.detail` (`/detail`)
    6. `Rute.kategori` (`/kategori`)
- [x] **Minimal 1 pengiriman data ke screen tujuan (konstruktor / arguments):**
  - Dari `LoginScreen` ke `HomeScreen` via arguments (`String` username).
  - Dari `HomeScreen` ke `DetailScreen` via arguments (objek `Resep`).
  - Dari `HomeScreen` ke `KategoriScreen` via arguments (`Map<String, List<Resep>>`).
- [x] **Minimal 1 penerimaan data kembali dari screen tujuan dengan Navigator.pop(context, data):**
  - Dari `FormScreen` mengembalikan objek `Resep` baru.
  - Dari `DetailScreen` mengembalikan status penghapusan (`bool`).
  - Dari `KategoriScreen` mengembalikan daftar resep yang telah dimutasi (`List<Resep>`).
  - Dari BottomSheet filter mengembalikan nama kategori terpilih.
- [x] **Menggunakan pushReplacementNamed pada alur yang tidak boleh kembali:**
  - `SplashScreen` -> `LoginScreen` (pengguna tidak bisa kembali ke splash screen).
  - `LoginScreen` -> `HomeScreen` (pengguna tidak bisa kembali ke login screen setelah masuk).
  - `FormScreen` -> `DetailScreen` (setelah resep tersimpan, form digantikan oleh detail).

### D. Alert dan Pemberitahuan (CLO C - Bobot 6%)
- [x] **SnackBar minimal di 2 kejadian berbeda, salah satunya memiliki aksi (misal BATAL):**
  - Kejadian 1: SnackBar saat login gagal di `LoginScreen`.
  - Kejadian 2: SnackBar konfirmasi tambah resep di `HomeScreen`.
  - Kejadian 3 (dengan aksi BATAL): SnackBar toggle favorit di `HomeScreen` & `DetailScreen`.
  - Kejadian 4 (dengan aksi BATAL): SnackBar setelah hapus resep di `HomeScreen` & `KategoriScreen`.
- [x] **AlertDialog untuk konfirmasi aksi penting:**
  - `DetailScreen`: dialog konfirmasi sebelum menghapus resep ("Hapus resep?").
- [x] **BottomSheet minimal 1:**
  - `HomeScreen`: `showModalBottomSheet` untuk memilih filter kategori masakan.
- [x] **Validasi input dengan pesan kesalahan jelas:**
  - `LoginScreen`: validasi username kosong / < 3 karakter, validasi password kosong / < 6 karakter.
  - `FormScreen`: validasi nama resep, deskripsi, durasi memasak (rentang 1-600), bahan minimal 1 baris, langkah minimal 1 baris.

### E. Ekspresi, Modularitas, dan Struktur Data (CLO B & C - Bobot 10%)
- [x] **Ekspresi:**
  - Operator logika/perbandingan: `username == AkunDemo.username && password == AkunDemo.password`.
  - Ekspresi kondisional ternary: `resep.favorit ? Icons.favorite : Icons.favorite_border`, `_sandiTersembunyi ? ... : ...`.
  - String interpolation: `'${widget.username} 👋'`, `'${resep.durasiMenit} menit'`, `'${hasil.nama} berhasil ditambahkan'`.
- [x] **Modular:**
  - Pemisahan folder rapi: `models/`, `screens/`, `widgets/`, `data/`, `utils/`.
- [x] **Struktur Data Linear:**
  - `List<Resep>` pada `DataResep.daftar` dan `_semuaResep` di `HomeScreen`, ditampilkan dengan `ListView.separated`.
- [x] **Struktur Data Non-Linear:**
  - `Map<String, List<Resep>>` pada `DataResep.perKategori()` untuk mengelompokkan data berdasarkan kategori.
  - Struktur bersarang (Nested Object): Setiap objek `Resep` menyimpan `List<String> bahan` dan `List<String> langkah`.

---

## 4. Catatan Koreksi & Perbaikan Kode yang Dilakukan

Semua perbaikan kode di bawah ini telah ditandai dengan komentar `#perbaikan` di file sumber:

1. **File:** [detail_screen.dart](file:///d:/latihan%20dppb%201/resep.makanan/lib/screens/detail_screen.dart#L50-L56)
   - **Bagian yang Diperbaiki:** Teks dialog konfirmasi `AlertDialog` pada fungsi `_konfirmasiHapus()`.
   - **Alasan:** Sebelumnya teks dialog menyatakan *"Tindakan ini tidak bisa dibatalkan."*, padahal pada arsitektur alur aplikasi (`HomeScreen` dan `KategoriScreen`), setelah resep dihapus pengguna diberikan `SnackBarAction` berlabel **BATAL** untuk mengembalikan resep yang terhapus (undo delete). Teks disederhanakan menjadi `'${resep.nama} akan dihapus dari daftar resep.'` agar konsisten secara fungsional.
   - **Komentar:** `// #perbaikan: Menyesuaikan pesan konfirmasi karena aksi penghapusan dapat dibatalkan melalui SnackBar BATAL di layar pemanggil`

2. **File:** [README.md](file:///d:/latihan%20dppb 1/resep.makanan/README.md#L45-L50)
   - **Bagian yang Diperbaiki:** Keterangan class `SplashScreen` pada diagram alur navigasi dan daftar kriteria.
   - **Alasan:** Sebelumnya di README tertulis `SplashScreen (Stateless)`. Faktanya, implementasi `SplashScreen` di `lib/screens/splash_screen.dart` adalah `StatefulWidget` karena mengelola state `Timer` (`initState` dan `dispose`). README diselaraskan agar fakta kode dengan dokumentasi sinkron 100%. Untuk kriteria `StatelessWidget`, project tetap memenuhi syarat dengan adanya `KartuResep`, `TombolUtama`, dan `JudulBagian`.

---

## 5. Hal yang Masih Perlu Dicek / Dilengkapi oleh Tim

Berdasarkan ketentuan halaman 9 & 10 pada panduan ujian (Penilaian CLO A & Persiapan Presentasi):

1. **Kelengkapan Identitas Tim di `README.md` (CLO A - Bobot 15%):**
   - Panduan mewajibkan `README.md` berisi: **nama dan peran tiap anggota kelompok**.
   - *Rekomendasi:* Segera tambahkan tabel nama, NIM, dan peran masing-masing anggota kelompok di bagian atas file `README.md`.
2. **Riwayat Commit (CLO A):**
   - Panduan mensyaratkan: *"Setiap anggota wajib melakukan commit dari akunnya sendiri. Riwayat commit dipakai untuk menilai pembagian kerja."*
   - Pastikan sebelum pengumpulan repositori GitHub, seluruh anggota tim memiliki riwayat commit di repositori.
3. **Persiapan Demo & Tanya Jawab Presentasi (CLO B - Bobot 25%):**
   - Setiap anggota kelompok wajib memahami:
     - Mengapa suatu widget dibuat `StatefulWidget` vs `StatelessWidget`.
     - Baris kode penerimaan arguments navigasi dan `Navigator.pop`.
     - Mengapa data dikelompokkan dalam `Map<String, List<Resep>>` dan bagaimana cara mengakses entri-nya.
     - Perbedaan konteks pemakaian `SnackBar` (notifikasi ringan/undo) vs `AlertDialog` (konfirmasi aksi destruktif).
4. **Persiapan Tes Coding Individu (CLO B & C - Bobot 35%):**
   - Pelajari 10 bank soal modifikasi yang tercantum di halaman 7 panduan PDF (favorit, pencarian, grid adaptif 2/3 kolom, panel layar lebar, screen statistik, dsb). Struktur kode project ini sudah sangat modular dan siap untuk dimodifikasi sesuai bank soal tersebut.
5. **Build APK Rilis/Debug:**
   - Siapkan file `.apk` (misalnya melalui `flutter build apk --debug`) dan slide presentasi untuk pengumpulan di Minggu 3 dan 4.
