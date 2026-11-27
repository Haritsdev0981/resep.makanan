# Dokumen Assessment & Panduan Pembagian Tugas Tim
**Proyek:** Aplikasi Resep Makanan (DPPB - Desain dan Pemrograman Perangkat Bergerak)  
**Anggota Tim:**
1. **Harits** (Team Lead & Core Architect) - `@harits`
2. **Aurel** (Frontend & Navigation Specialist) - `@aurel`
3. **Aress** (UI/UX & Adaptive Layout Specialist) - `@aress`

---

## 1. Panduan Alur Kerja Tim (Git Flow & GitHub Standard)

Agar riwayat pengerjaan tercatat secara rapi dan dinilai maksimal oleh dosen (CLO A - Bobot 15%), seluruh anggota tim wajib mengikuti alur kerja berikut:

### A. Format Penamaan Branch
Setiap anggota mengerjakan tugas pada branch masing-masing yang dibuat dari branch `develop`:
- Fitur baru: `feat/<nama-fitur>-<nama-anggota>` (Contoh: `feat/login-screen-aurel`, `feat/card-widget-aress`)
- Perbaikan: `fix/<nama-bug>-<nama-anggota>` (Contoh: `fix/overflow-detail-aress`)
- Dokumentasi/Refactor: `docs/<nama-dokumen>` atau `refactor/<nama-bagian>`

### B. Format Commit Message (Conventional Commits)
Setiap commit harus jelas dan mencantumkan nomor Issue GitHub:
- `feat(auth): implementasi LoginScreen dan validasi form (#3)`
- `feat(ui): buat custom reusable widget KartuResep (#4)`
- `fix(layout): perbaiki render overflow pada mode landscape (#7)`
- `docs(readme): tambahkan identitas anggota tim (#1)`

### C. Alur Pull Request (PR)
1. Anggota menyelesaikan task sesuai checklist Issue.
2. Push branch ke GitHub: `git push origin feat/<nama-fitur>-<nama-anggota>`.
3. Buka **Pull Request (PR)** dari branch fitur ke branch `develop`.
4. Beri keterangan PR: `Closes #<nomor_issue>` beserta screenshot tampilan.
5. Harits (Lead) melakukan review kode, lalu melakukan merge ke `develop`.

---

## 2. Matriks Pembagian Tugas & Kriteria Penilaian

| Anggota Tim | Peran Utama | Fokus Kriteria DPPB | Estimasi Bobot Kerja |
|---|---|---|---|
| **Harits** | Team Lead, Architecture, Data & Home Logic | Named Routes, Struktur Data Linear & Non-Linear, State Management Home | 34% |
| **Aurel** | Navigation & Form Flow Developer | Splash & Login, Form Input & Validation, `pushReplacementNamed`, SnackBar | 33% |
| **Aress** | UI/UX & Adaptive Layout Developer | Custom Reusable Widgets, Layout & Adaptive (LayoutBuilder), Alert & Dialogs | 33% |

---

## 3. Daftar Detail Task & Template GitHub Issues (Ready-to-Prompt)

Format di bawah ini disusun sedemikian rupa agar dapat langsung disalin atau di-prompt menjadi **GitHub Issues**.

---

### [ISSUE-01] Setup Fondasi Proyek, Routing Named Routes, & Dokumentasi Tim
- **Assignee:** `@harits`
- **Milestone:** Sprint 1 - Project Setup & Architecture
- **Labels:** `setup`, `documentation`, `core`
- **Kriteria DPPB:** CLO A (Kelengkapan Identitas Tim & README), CLO C (Named Routes)
- **Nama Branch Rekomendasi:** `feat/setup-architecture-harits`

#### Deskripsi Pekerjaan:
Mempersiapkan struktur arsitektur proyek yang modular, mendefinisikan konstanta warna/rute, mendaftarkan semua screen pada `MaterialApp` named routes, dan melengkapi informasi kelompok pada `README.md`.

#### Checklist Pengerjaan (Acceptance Criteria):
- [ ] Buat file `lib/utils/konstanta.dart`:
  - `class Rute` (mendefinisikan static const `/`, `/login`, `/home`, `/detail`, `/form`, `/kategori`).
  - `class WarnaAplikasi` (skema warna tema masakan: amber/orange/teal).
  - `class AkunDemo` (kredensial akun dummy: `ares` / `ares123`).
- [ ] Daftarkan named routes di `lib/main.dart` dengan rute awal `Rute.splash`.
- [ ] Buat struktur folder modular: `models/`, `screens/`, `widgets/`, `data/`, `utils/`.
- [ ] Perbarui `README.md` dengan tabel nama lengkap, NIM, dan peran masing-masing anggota (Harits, Aurel, Aress).
- [ ] Lakukan commit dan push dengan format: `feat(core): setup project architecture and named routes (#1)`.

---

### [ISSUE-02] Desain Model Data Resep, Linear List, & Non-Linear Map
- **Assignee:** `@harits`
- **Milestone:** Sprint 1 - Data Layer
- **Labels:** `data`, `core`
- **Kriteria DPPB:** CLO B & C (Struktur Data Linear `List<Model>`, Non-Linear `Map<String, List<Model>>`, Nested Structure)
- **Nama Branch Rekomendasi:** `feat/data-model-resep-harits`

#### Deskripsi Pekerjaan:
Membuat model objek `Resep` lengkap dengan relasi data bersarang (*nested list* untuk bahan dan langkah memasak), serta dataset dummy in-memory masakan nusantara dengan pengelompokan linear dan non-linear.

#### Checklist Pengerjaan (Acceptance Criteria):
- [ ] Buat file `lib/models/resep.dart`:
  - Properti: `id`, `nama`, `kategori`, `deskripsi`, `durasiMenit`, `porsi`, `tingkatKesulitan`, `gambarUrl`, `bahan` (`List<String>`), `langkah` (`List<String>`), `favorit` (`bool`).
  - Method `copyWith` untuk pembaruan state mutasi data.
- [ ] Buat file `lib/data/data_resep.dart`:
  - `List<Resep> daftar`: minimal 6 data resep nusantara yang menarik (misal: Rendang Daging, Soto Ayam, Nasi Goreng Spesial, Sate Ayam Madura, Sayur Asem, Gado-Gado).
  - Method `Map<String, List<Resep>> perKategori()` untuk mengelompokkan data berdasarkan kategori masakan (Makanan Utama, Berkuah, Olahan Daging, Makanan Sehat).
  - List konstanta `List<String> semuaKategori`.
- [ ] Lakukan commit dan push dengan format: `feat(model): create Resep model and in-memory dummy dataset (#2)`.

---

### [ISSUE-03] Implementasi Splash Screen & Login Screen Berbasis Validasi Form
- **Assignee:** `@aurel`
- **Milestone:** Sprint 1 - Auth & Entry Flow
- **Labels:** `ui`, `auth`, `navigation`
- **Kriteria DPPB:** CLO C (StatefulWidget, TextEditingController, pushReplacementNamed, SnackBar, Validasi Input)
- **Nama Branch Rekomendasi:** `feat/splash-login-screen-aurel`

#### Deskripsi Pekerjaan:
Membuat layar pembuka (`SplashScreen`) dengan timer otomatis yang menuju layar masuk (`LoginScreen`). Layar login harus memiliki form interaktif dengan controller, validasi error yang jelas, show/hide password toggle, serta transisi satu arah tanpa bisa kembali ke splash.

#### Checklist Pengerjaan (Acceptance Criteria):
- [ ] Buat file `lib/screens/splash_screen.dart` (`StatefulWidget`):
  - Menggunakan `Timer` durasi 2 detik pada `initState` dan `dispose` timer saat unmount.
  - Tampilan logo/ikon makanan dengan animasi atau tipografi menarik.
  - Berpindah ke login menggunakan `Navigator.pushReplacementNamed(context, Rute.login)`.
- [ ] Buat file `lib/screens/login_screen.dart` (`StatefulWidget`):
  - Dua `TextEditingController`: `_usernameController` dan `_passwordController`.
  - State boolean `_sandiTersembunyi` dengan tombol toggle ikon mata (`setState`).
  - Validasi form: username tidak boleh kosong/minimal 3 karakter, password minimal 6 karakter.
  - SnackBar error jika akun tidak cocok dengan `AkunDemo`.
  - Berhasil login: pindah ke `HomeScreen` via `Navigator.pushReplacementNamed(context, Rute.home, arguments: username)`.
  - Tampilan adaptif: batasi lebar kartu login di layar lebar (maks 420px).
- [ ] Lakukan commit dan push: `feat(auth): implement splash screen and login form with validation (#3)`.

---

### [ISSUE-04] Pembuatan Custom Reusable Widget: KartuResep, TombolUtama, & JudulBagian
- **Assignee:** `@aress`
- **Milestone:** Sprint 1 - Reusable UI Components
- **Labels:** `ui`, `widgets`
- **Kriteria DPPB:** CLO C (StatelessWidget buatan sendiri, Stack, Expanded, Custom Widget dipakai ulang di >1 tempat)
- **Nama Branch Rekomendasi:** `feat/reusable-widgets-aress`

#### Deskripsi Pekerjaan:
Membangun widget kustom yang modular dan dapat digunakan kembali (*reusable*) di berbagai screen aplikasi, menjaga konsistensi UI dan mencegah redundansi kode.

#### Checklist Pengerjaan (Acceptance Criteria):
- [ ] Buat file `lib/widgets/kartu_resep.dart`:
  - Class `KartuResep` (`StatelessWidget`).
  - Menggunakan `Stack` untuk menumpuk gambar resep, badge kategori masakan, dan ikon tombol favorit di pojok kanan atas.
  - Menampilkan durasi memasak (`Row` dengan icon timer + string interpolation `${resep.durasiMenit} mnt`).
  - Callback event: `onTap` (menuju detail) dan `onToggleFavorit`.
  - Digunakan di `HomeScreen` (horizontal card) dan `KategoriScreen` (vertical grid).
- [ ] Buat file `lib/widgets/tombol_utama.dart`:
  - Class `TombolUtama` (`StatelessWidget`): tombol berdesain konsisten dengan icon opsional dan state disable. Digunakan di Login, Form, Detail, dan Home.
  - Class `JudulBagian` (`StatelessWidget`): teks header bagian yang elegan dengan opsi tombol aksi "Lihat Semua".
- [ ] Lakukan commit dan push: `feat(widgets): implement reusable KartuResep and TombolUtama widgets (#4)`.

---

### [ISSUE-05] Implementasi Home Screen: Banner, Search, Filter Kategori, & Passing Data
- **Assignee:** `@harits`
- **Milestone:** Sprint 2 - Core Features
- **Labels:** `ui`, `feature`, `state-management`
- **Kriteria DPPB:** CLO C (StatefulWidget, setState, ListView, LayoutBuilder, Passing Data arguments & pop)
- **Nama Branch Rekomendasi:** `feat/home-screen-harits`

#### Deskripsi Pekerjaan:
Mengembangkan halaman utama (`HomeScreen`) yang menerima data login, menampilkan sambutan pengguna, kolom pencarian real-time, daftar resep terpopuler horizontal, serta floating action button (FAB) untuk membuka form tambah resep.

#### Checklist Pengerjaan (Acceptance Criteria):
- [ ] Buat file `lib/screens/home_screen.dart` (`StatefulWidget`):
  - Menerima `username` dari login arguments dan menampilkannya: `"Halo, $username 👋"`.
  - Mengelola state lokal `_semuaResep` dari `DataResep.daftar`.
  - Kolom pencarian `_cariController` dengan `onChanged` memfilter resep secara interaktif (`setState`).
  - Horizontal list menggunakan `ListView.separated` untuk resep rekomendasi.
  - Responsive padding & lebar kartu dengan `LayoutBuilder`.
  - Tombol favorit yang langsung memperbarui tampilan dengan `setState`.
  - FAB tambah resep dengan `Navigator.pushNamed(context, Rute.form)` dan menangkap objek resep kembalian dari pop.
- [ ] Tambahkan SnackBar notifikasi sukses ketika resep baru berhasil ditambahkan dari pop.
- [ ] Lakukan commit dan push: `feat(home): build HomeScreen with search, filter, and state management (#5)`.

---

### [ISSUE-06] Pembuatan Form Tambah Resep Lengkap dengan Validasi Input
- **Assignee:** `@aurel`
- **Milestone:** Sprint 2 - Form & Data Creation
- **Labels:** `ui`, `form`, `validation`
- **Kriteria DPPB:** CLO C (Form Input, 5 TextEditingController, Validasi Pesan Jelas, Navigator.pop dengan data)
- **Nama Branch Rekomendasi:** `feat/form-screen-aurel`

#### Deskripsi Pekerjaan:
Membangun halaman tambah resep baru (`FormScreen`) dengan form terstruktur untuk mengumpulkan data nama masakan, kategori, deskripsi, durasi memasak, serta input teks multi-baris untuk bahan dan cara membuat, lalu mengembalikan data objek `Resep` baru ke pemanggil.

#### Checklist Pengerjaan (Acceptance Criteria):
- [ ] Buat file `lib/screens/form_screen.dart` (`StatefulWidget`):
  - Menggunakan `GlobalKey<FormState> _formKey`.
  - 5 `TextEditingController`:
    1. `_namaController`
    2. `_deskripsiController`
    3. `_durasiController` (keyboard numeric)
    4. `_bahanController` (multi-line, dipisahkan baris baru)
    5. `_langkahController` (multi-line, dipisahkan baris baru)
  - `DropdownButtonFormField` untuk memilih kategori masakan.
  - Validasi form ketat dengan pesan kesalahan spesifik:
    - Nama resep minimal 3 karakter.
    - Durasi harus angka valid antara 1 - 600 menit.
    - Bahan & langkah minimal masing-masing memiliki 1 butir.
  - Saat tombol simpan ditekan:
    - Instansiasi objek `Resep` baru.
    - Kembalikan objek ke `HomeScreen` via `Navigator.pop(context, resepBaru)`.
  - Cegah render overflow pada keyboard terbuka dengan `SingleChildScrollView`.
- [ ] Lakukan commit dan push: `feat(form): create FormScreen with multi-field validation and pop data (#6)`.

---

### [ISSUE-07] Implementasi Detail Screen, Konfirmasi Hapus (AlertDialog), & SnackBar Undo
- **Assignee:** `@aress`
- **Milestone:** Sprint 2 - Detail View & Destructive Action
- **Labels:** `ui`, `dialogs`, `interaction`
- **Kriteria DPPB:** CLO C (Passing Data Object via arguments, AlertDialog, SnackBar dengan aksi BATAL, Navigator.pop)
- **Nama Branch Rekomendasi:** `feat/detail-screen-aress`

#### Deskripsi Pekerjaan:
Mengembangkan halaman rincian resep (`DetailScreen`) yang menampilkan foto besar, badge kategori, durasi, daftar bahan (bullet list), dan langkah memasak terurut. Menyediakan fitur toggle favorit, penanda status sedang dimasak, serta aksi hapus resep dengan proteksi konfirmasi dialog.

#### Checklist Pengerjaan (Acceptance Criteria):
- [ ] Buat file `lib/screens/detail_screen.dart` (`StatefulWidget`):
  - Menerima argumen objek `Resep` via `ModalRoute.of(context)!.settings.arguments as Resep`.
  - Header gambar interaktif dengan tombol kembali dan tombol favorit di AppBar.
  - Widget tab / daftar rapi untuk Bahan dan Langkah Masak (`ListView`).
  - Tombol aksi sekunder "Mulai Masak" yang mengubah teks status menjadi "Sedang Dimasak" (`setState`).
- [ ] Implementasi dialog konfirmasi hapus:
  - Tombol hapus memicu `showDialog` berisi `AlertDialog`.
  - Judul: "Hapus Resep?", Pesan: "${resep.nama} akan dihapus dari daftar resep.".
  - Opsi: "Batal" (`Navigator.pop(context, false)`) dan "Hapus" berwarna merah (`Navigator.pop(context, true)`).
  - Jika dikonfirmasi hapus, panggil `Navigator.pop(context, true)` untuk memberi tahu screen sebelumnya.
- [ ] Di screen pemanggil (`HomeScreen` / `KategoriScreen`), tampilkan `SnackBar` konfirmasi hapus dengan `SnackBarAction(label: 'BATAL', onPressed: ...)` untuk mengembalikan data (undo delete).
- [ ] Lakukan commit dan push: `feat(detail): implement DetailScreen with AlertDialog and undo delete (#7)`.

---

### [ISSUE-08] Implementasi Layar Kategori, GridView Adaptif, & BottomSheet Filter
- **Assignee:** `@aress`
- **Milestone:** Sprint 3 - Adaptive Layout & Category View
- **Labels:** `ui`, `responsive`, `adaptive`
- **Kriteria DPPB:** CLO C (Non-Linear Map access, GridView, LayoutBuilder 1/2/3 kolom, BottomSheet, Bebas Overflow Landscape)
- **Nama Branch Rekomendasi:** `feat/kategori-adaptive-aress`

#### Deskripsi Pekerjaan:
Membangun halaman katalog kategori (`KategoriScreen`) yang menampilkan resep berdasarkan kelompok non-linear `Map<String, List<Resep>>`. Layar ini harus responsif dan adaptif terhadap lebar layar, serta membuat modal `BottomSheet` filter kategori.

#### Checklist Pengerjaan (Acceptance Criteria):
- [ ] Buat file `lib/screens/kategori_screen.dart` (`StatefulWidget`):
  - Menerima argumen non-linear `Map<String, List<Resep>>` dari `HomeScreen`.
  - Chip filter kategori horisontal di bagian atas.
  - Menampilkan resep dalam `GridView.builder` dengan scroll vertikal.
- [ ] Implementasi **Adaptive Layout**:
  - Bungkus grid dengan `LayoutBuilder`:
    - Layar ponsel sempit (< 600px): **1 kolom** (`crossAxisCount: 1`)
    - Layar sedang/tablet (600px – 899px): **2 kolom** (`crossAxisCount: 2`)
    - Layar lebar/desktop (>= 900px): **3 kolom** (`crossAxisCount: 3`)
- [ ] Buat fungsi `showModalBottomSheet` di `HomeScreen` untuk memilih kategori cepat yang mengembalikan nilai string kategori terpilih (`Navigator.pop(context, kategori)`).
- [ ] Uji mode landscape: pastikan tidak ada garis kuning-hitam (*RenderFlex overflow*).
- [ ] Lakukan commit dan push: `feat(category): add KategoriScreen with adaptive LayoutBuilder and BottomSheet (#8)`.

---

### [ISSUE-09] Pengujian Komprehensif (Widget Test, Overflow Landscape, & Lint Check)
- **Assignee:** `@harits`
- **Milestone:** Sprint 3 - Quality Assurance & Testing
- **Labels:** `testing`, `qa`, `lint`
- **Kriteria DPPB:** CLO B & C (Kerapian Kode, Pencegahan Bug Overflow, Nilai Rubrik Maksimal)
- **Nama Branch Rekomendasi:** `test/widget-and-overflow-harits`

#### Deskripsi Pekerjaan:
Melakukan pengujian otomatis terhadap alur UI, widget buatan sendiri, dan memverifikasi ketahanan layout pada orientasi landscape untuk memastikan aplikasi bebas crash dan overflow.

#### Checklist Pengerjaan (Acceptance Criteria):
- [ ] Buat `test/widget_test.dart`:
  - Menguji alur login screen hingga masuk ke home screen.
  - Menguji pencarian resep dan perubahan state list.
- [ ] Buat `test/overflow_test.dart`:
  - Menguji rendering `HomeScreen`, `DetailScreen`, dan `FormScreen` pada ukuran landscape (844 x 390 px) dan tablet (800 x 1280 px).
  - Memastikan tidak ada *RenderFlex overflowed by X pixels*.
- [ ] Jalankan `flutter analyze` dan pastikan 0 error / warning.
- [ ] Lakukan commit dan push: `test(qa): add widget tests and verify landscape no-overflow (#9)`.

---

### [ISSUE-10] Finalisasi Proyek, Rangkuman Audit, & Build APK Debug
- **Assignee:** `@harits` (Didukung oleh `@aurel` dan `@aress`)
- **Milestone:** Sprint 3 - Release & Submission
- **Labels:** `release`, `documentation`, `build`
- **Kriteria DPPB:** CLO A, B, C (Pengumpulan Proyek, Riwayat Commit Merata, APK Siap Demo)
- **Nama Branch Rekomendasi:** `release/final-assessment-harits`

#### Deskripsi Pekerjaan:
Menggabungkan (*merge*) seluruh branch fitur ke branch utama, memverifikasi riwayat commit setiap anggota di GitHub, menyusun dokumen rangkuman audit, serta menghasilkan file APK Android untuk presentasi ujian.

#### Checklist Pengerjaan (Acceptance Criteria):
- [ ] Review seluruh Pull Request di GitHub dan pastikan semua anggota (`harits`, `aurel`, `aress`) memiliki riwayat commit aktif.
- [ ] Merge semua branch ke `develop`, lalu buat PR final ke branch `master`.
- [ ] Buat file `rangkuman.md` sebagai catatan audit kesesuaian kode terhadap rubrik penilaian dosen.
- [ ] Lakukan build APK: `flutter build apk --debug`.
- [ ] Pastikan file APK `build/app/outputs/flutter-apk/app-debug.apk` siap didemokan saat sesi tanya jawab/presentasi.
- [ ] Lakukan commit dan push: `chore(release): finalize project, documentation, and release build (#10)`.

---

## 4. Panduan Eksekusi Git Branch Khusus Penilaian

Jika ingin membuat branch baru yang bersih dan mengunggah file `assesment.md` ini terlebih dahulu ke GitHub:

```bash
# 1. Pastikan working directory bersih
git status

# 2. Buat branch baru dari branch develop
git checkout -b feat/assessment-guideline

# 3. Tambahkan file assesment.md dan commit
git add assesment.md
git commit -m "docs: add assessment roadmap and team task distribution (#1)"

# 4. Push ke repositori GitHub
git push origin feat/assessment-guideline
```

Setelah branch terunggah, buka Pull Request di GitHub agar dosen dan rekan tim dapat langsung melihat pembagian tugas dan referensi issue!
