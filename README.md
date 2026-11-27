# Aplikasi Resep Masakan Nusantara (Ujian Project Flutter DPPB)

Repositori resmi pengerjaan **Ujian Project Desain & Pemrograman Perangkat Bergerak (DPPB)** dengan tema **Daftar Resep Masakan**. Proyek ini dikembangkan secara kolaboratif menggunakan Git Flow dan GitHub Issues dengan pembagian tugas yang merata dan terukur.

---

## 👥 Identitas Tim & Pembagian Peran

Sesuai kriteria penilaian **CLO A (Kelengkapan Identitas Tim & Dokumentasi)**:

| No | Nama Lengkap | NIM | Akun GitHub | Peran Utama | Fokus Pengerjaan Kriteria DPPB |
|:---:|:---|:---:|:---:|:---|:---|
| 1 | **Harits** | `(diisi)` | [`@Haritsdev0981`](https://github.com/Haritsdev0981) | **Team Lead & Core Architect** | Named Routes, Arsitektur Proyek, Linear `List<Resep>` & Non-Linear `Map`, State Management Home, Quality Assurance & Automated Tests |
| 2 | **Aurel** | `(diisi)` | [`@aureelnp`](https://github.com/aureelnp) | **Frontend & Navigation Specialist** | Splash Screen (`Timer`), Login Screen (`TextEditingController`, validasi input, toggle password, `pushReplacementNamed`), Form Tambah Resep |
| 3 | **Ares** | `(diisi)` | [`@alfarezi170107`](https://github.com/alfarezi170107) | **UI/UX & Adaptive Specialist** | Custom Reusable Widgets (`KartuResep`, `TombolUtama`), Detail Screen (`AlertDialog` konfirmasi hapus, `SnackBar` undo), Layout Adaptif `KategoriScreen` |

---

## 🏛️ Arsitektur & Struktur Proyek

Aplikasi dirancang secara modular dan terpisah berdasarkan tanggung jawab layer (*Separation of Concerns*):

```
lib/
├── data/              # Sumber data in-memory masakan nusantara (ISSUE-02)
│   └── data_resep.dart
├── models/            # Objek model data Dart OOP (ISSUE-02)
│   └── resep.dart
├── screens/           # Halaman UI utama aplikasi
│   ├── splash_screen.dart      # Splash Screen (ISSUE-03)
│   ├── login_screen.dart       # Form Login & Validasi (ISSUE-03)
│   ├── home_screen.dart        # Katalog Resep, Search, & Filter (ISSUE-05)
│   ├── detail_screen.dart      # Rincian Bahan, Langkah, Dialog (ISSUE-07)
│   ├── form_screen.dart        # Form Tambah Resep Baru (ISSUE-06)
│   └── kategori_screen.dart    # Grid Kategori Adaptif (ISSUE-08)
├── utils/             # Konstanta rute, tema warna, & kredensial demo (ISSUE-01)
│   └── konstanta.dart
├── widgets/           # Custom Reusable Widgets Stateless/Stateful (ISSUE-04)
│   ├── kartu_resep.dart
│   └── tombol_utama.dart
└── main.dart          # Entry point & Pendaftaran Named Routes (ISSUE-01)
```

---

## 🗺️ Kontrak Navigasi (Named Routes)

Navigasi antar layar menggunakan **Named Routes** yang didaftarkan secara terpusat di `lib/main.dart` dengan konstanta string di `lib/utils/konstanta.dart`:

| Rute | Konstanta | Tipe Screen | Keterangan & Argumen |
|:---|:---|:---|:---|
| `/` | `Rute.splash` | `SplashScreen` | Layar pembuka timer otomatis |
| `/login` | `Rute.login` | `LoginScreen` | Masuk aplikasi dengan validasi form |
| `/home` | `Rute.home` | `HomeScreen` | Menerima argumen username `String` |
| `/detail` | `Rute.detail` | `DetailScreen` | Menerima argumen objek `Resep` |
| `/form` | `Rute.form` | `FormScreen` | Form input resep baru |
| `/kategori` | `Rute.kategori` | `KategoriScreen` | Menerima argumen `Map<String, List<Resep>>` |

---

## 🔐 Kredensial Akun Uji Coba (Dummy Demo)

Untuk keperluan pengujian validasi login pada sesi demo:
- **Username:** `ares`
- **Password:** `ares123`

---

## 🛠️ Alur Kerja Git & GitHub Issues

Panduan lengkap penilaian, 10 GitHub Issue resmi, dan matriks rubrik:
👉 **[assesment.md](assesment.md)**

```bash
# 1. Tarik pembaruan branch develop
git checkout develop
git pull origin develop

# 2. Buat branch fitur dari develop
git checkout -b feat/<nama-fitur>

# 3. Commit menggunakan Conventional Commits
git commit -m "feat(scope): keterangan task (#<issue_number>)"

# 4. Push dan buat Pull Request ke develop
git push -u origin feat/<nama-fitur>
```

---

## 🚀 Panduan Menjalankan & Pengujian

```bash
# Mengambil dependensi
flutter pub get

# Menjalankan aplikasi
flutter run

# Menjalankan seluruh pengujian (Widget Test)
flutter test

# Memeriksa standar kode dan linter
flutter analyze

# Membangun file APK Debug
flutter build apk --debug
```
File APK akan berada pada direktori: `build/app/outputs/flutter-apk/app-debug.apk`.
