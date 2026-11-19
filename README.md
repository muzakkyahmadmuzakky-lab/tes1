# Esports Arena - Aplikasi Desktop Manajemen Turnamen (Java Swing)

Proyek kelompok SBD + PBO. Sesuai dokumen "Struktur dan Fitur Aplikasi Turnamen E-Sports".

## Cara menjalankan
1. Jalankan MySQL (XAMPP / Laragon). Database dan 6 tabel dibuat otomatis (lihat `schema.sql`).
2. Unduh **mysql-connector-j** (file .jar) dan taruh di folder `lib/`.
3. Sesuaikan `config.properties` bila user/password MySQL berbeda.
4. Jalankan `run.bat` (Windows) atau `./run.sh` (Linux/Mac). Perlu JDK 17+.
5. Login awal: **admin / admin123**.

## Alur pemakaian
Tim -> Daftarkan Tim (min. 5 pemain) -> Jadwal -> Bagi Grup & Jadwal -> Skor & KDA (isi semua BO3)
-> Jadwal -> Buat Playoff -> Skor & KDA -> Lanjut Ronde (sampai Grand Final BO7) -> Juara.

## Fitur (nomor sesuai dokumen)
1 Login Admin, 2 Manajemen Tim, 3 Pendaftaran Tim, 4 Jadwal, 5 Input Skor, 6 Klasemen/Bracket, 7 Juara,
8 Pemain & Role, 9 KDA + MVP otomatis, 10 Validasi (pemain ganda, minimal 5), 11 BO3 grup / BO5 playoff / BO7 final.

## 4 Pilar OOP
- Inheritance: `AnggotaTim` -> `KaptenTim`, `PemainReguler`
- Encapsulation: `Statistik` (kill/death/assist private, setter menolak negatif)
- Abstraction: `AturanMatch` (abstract class)
- Polymorphism: `tentukanPemenang()` / `hitungPoin()` di `MatchGrup` dan `MatchPlayoff`
- Custom exception: `PemainGandaException`, `AnggotaKurangException` (pop-up error di GUI)

## Aturan yang dipakai
- Poin grup: menang 2-0 = 3, menang 2-1 = 2, kalah 1-2 = 1, kalah 0-2 = 0.
- MVP otomatis: pemain tim pemenang dengan KDA tertinggi, KDA = (K + A) / max(1, D).
- Playoff: 2 tim teratas tiap grup, sistem gugur tunggal (single elimination), jumlah tim dibulatkan ke pangkat dua.
