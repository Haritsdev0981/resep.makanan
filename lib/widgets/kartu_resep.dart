import 'package:flutter/material.dart';

import '../models/resep.dart';
import '../utils/konstanta.dart';

/// Custom widget #1: kartu resep, dipakai di Home (list) dan Kategori (grid).
class KartuResep extends StatelessWidget {
  const KartuResep({
    super.key,
    required this.resep,
    required this.onTap,
    this.onFavorit,
    this.ringkas = false,
  });

  final Resep resep;
  final VoidCallback onTap;
  final VoidCallback? onFavorit;

  /// Mode ringkas dipakai pada grid dua kolom di layar lebar.
  final bool ringkas;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack dipakai untuk menumpuk gambar, label kategori, dan tombol favorit.
              // Expanded membuat gambar menyesuaikan sisa tinggi kartu, sehingga
              // teks tidak pernah terdorong keluar (aman untuk font besar).
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      child: Image.asset(
                        resep.gambar,
                        fit: BoxFit.cover,
                        // Gambar dummy bisa gagal dimuat; jangan sampai error.
                        errorBuilder: (_, __, ___) => Container(
                          color: Warna.krem,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Warna.merah,
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          resep.kategori,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Warna.merah,
                          ),
                        ),
                      ),
                    ),
                    if (onFavorit != null)
                      Positioned(
                        top: 2,
                        right: 2,
                        child: IconButton(
                          onPressed: onFavorit,
                          tooltip: resep.favorit
                              ? 'Hapus dari favorit'
                              : 'Tambah ke favorit',
                          icon: Icon(
                            resep.favorit
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Warna.merah,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resep.nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      resep.deskripsi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Warna.teksSamar,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Row dengan Expanded supaya tidak overflow di layar sempit.
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 14,
                          color: Warna.teksSamar,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${resep.durasiMenit} menit',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Warna.teksSamar,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.people_outline,
                          size: 14,
                          color: Warna.teksSamar,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${resep.porsi} porsi',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Warna.teksSamar,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
