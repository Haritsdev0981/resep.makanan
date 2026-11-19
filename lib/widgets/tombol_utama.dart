import 'package:flutter/material.dart';

import '../utils/konstanta.dart';

/// Custom widget #2: tombol utama, dipakai di Home, Form, dan Detail.
class TombolUtama extends StatelessWidget {
  const TombolUtama({
    super.key,
    required this.label,
    required this.onPressed,
    this.ikon,
    this.lebarPenuh = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? ikon;
  final bool lebarPenuh;

  @override
  Widget build(BuildContext context) {
    final tombol = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Warna.merah,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey.shade300,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (ikon != null) ...[
            Icon(ikon, size: 18),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    if (!lebarPenuh) return tombol;
    return SizedBox(width: double.infinity, child: tombol);
  }
}

/// Custom widget #3: judul bagian, dipakai di Detail dan Form.
class JudulBagian extends StatelessWidget {
  const JudulBagian({super.key, required this.teks, this.ikon});

  final String teks;
  final IconData? ikon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          if (ikon != null) ...[
            Icon(ikon, size: 18, color: Warna.merah),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              teks,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
