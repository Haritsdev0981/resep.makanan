# Aplikasi Resep Makanan (Ujian Project Flutter DPPB)

Selamat datang di repositori kolaborasi **Ujian Project Desain & Pemrograman Perangkat Bergerak (DPPB)** dengan tema **Daftar Resep Masakan**.

Branch `develop` ini adalah **Starter Template (Clean Slate)** yang berfungsi sebagai titik awal (*baseline*) bagi seluruh anggota tim untuk mengerjakan task masing-masing sesuai pembagian kerja di GitHub Issues.

---

## 👥 Tim & Pembagian Tugas

| Anggota Tim | GitHub Username | Peran Utama | Fokus Pengerjaan |
| :--- | :--- | :--- | :--- |
| **Harits** | [`@Haritsdev0981`](https://github.com/Haritsdev0981) | Team Lead & Core Architect | Setup routing, state/data models, home screen, automated testing |
| **Aurel** | [`@aureelnp`](https://github.com/aureelnp) | Frontend & Navigation Specialist | Splash screen, login validasi form, form tambah resep baru |
| **Ares** | [`@alfarezi170107`](https://github.com/alfarezi170107) | UI/UX & Adaptive Specialist | Reusable widgets, detail screen & dialogs, adaptif kategori |

Panduan lengkap, daftar kriteria penilaian (CLO A, B, C), dan rincian per issue dapat dilihat di:
👉 **[assesment.md](assesment.md)**

---

## 🛠️ Alur Kerja Tim (Git Flow & GitHub Issues)

Setiap anggota tim mengerjakan tugasnya secara independen menggunakan branch fitur, lalu membuat Pull Request (PR) kembali ke branch `develop`:

1. **Pull branch terbaru:**
   ```bash
   git checkout develop
   git pull origin develop
   ```

2. **Buat branch fitur baru:**
   ```bash
   git checkout -b feat/<nama-fitur>
   # Contoh: git checkout -b feat/splash-login
   ```

3. **Kerjakan task dan lakukan commit (Conventional Commits):**
   ```bash
   git add .
   git commit -m "feat: implement splash screen with delay navigation (fixes #4)"
   ```

4. **Push branch fitur ke remote:**
   ```bash
   git push -u origin feat/<nama-fitur>
   ```

5. **Buat Pull Request ke branch `develop` di GitHub:**
   - Berikan deskripsi perubahan dan checklist kriteria.
   - Cantumkan referensi issue (contoh: `Closes #4` atau `Fixes #4`).
   - Minta review dari rekan tim sebelum di-merge.

---

## 🚀 Menjalankan Proyek

Pastikan Flutter SDK terpasang di komputer Anda:

```bash
flutter pub get
flutter run
```

### Menjalankan Pengujian & Analisis Kode:
```bash
flutter test
flutter analyze
```

### Build APK Debug:
```bash
flutter build apk --debug
```
Hasil APK debug akan berada di folder `build/app/outputs/flutter-apk/app-debug.apk`.
