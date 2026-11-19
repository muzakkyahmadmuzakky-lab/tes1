-- database: :memory:
-- Skema database Esports Arena (dibuat otomatis oleh aplikasi saat pertama dijalankan).
-- File ini disertakan untuk laporan SBD / import manual.
CREATE DATABASE IF NOT EXISTS turnamen_esports CHARACTER SET utf8mb4;
USE turnamen_esports;

CREATE TABLE IF NOT EXISTS admin (
  id_admin INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(30) NOT NULL UNIQUE,
  password VARCHAR(64) NOT NULL,            -- SHA-256
  nama     VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS turnamen (
  id_turnamen INT AUTO_INCREMENT PRIMARY KEY,
  nama        VARCHAR(80) NOT NULL,
  game        VARCHAR(40) NOT NULL,
  tgl_mulai   DATE NOT NULL,
  status      VARCHAR(15) NOT NULL DEFAULT 'PENDAFTARAN'  -- PENDAFTARAN/GRUP/PLAYOFF/FINAL/SELESAI
);

CREATE TABLE IF NOT EXISTS tim (
  id_tim      INT AUTO_INCREMENT PRIMARY KEY,
  id_turnamen INT NOT NULL,
  nama_tim    VARCHAR(40) NOT NULL UNIQUE,
  grup        CHAR(1) NULL,
  FOREIGN KEY (id_turnamen) REFERENCES turnamen(id_turnamen) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS pemain (            -- relasi 1:N ke tim
  id_pemain INT AUTO_INCREMENT PRIMARY KEY,
  id_tim    INT NOT NULL,
  ign       VARCHAR(30) NOT NULL UNIQUE,       -- UNIQUE: satu pemain tidak boleh masuk dua tim
  nama      VARCHAR(60) NOT NULL,
  role_game VARCHAR(20) NOT NULL,
  is_kapten TINYINT(1) NOT NULL DEFAULT 0,
  FOREIGN KEY (id_tim) REFERENCES tim(id_tim) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS pertandingan (
  id_match    INT AUTO_INCREMENT PRIMARY KEY,
  id_turnamen INT NOT NULL,
  babak       VARCHAR(10) NOT NULL,            -- GRUP / PLAYOFF / FINAL
  ronde       INT NOT NULL DEFAULT 1,
  id_tim1     INT NOT NULL,
  id_tim2     INT NOT NULL,
  skor1       INT NOT NULL DEFAULT 0,
  skor2       INT NOT NULL DEFAULT 0,
  jadwal      DATETIME NULL,
  status      VARCHAR(10) NOT NULL DEFAULT 'TERJADWAL',
  format_bo   INT NOT NULL,                    -- 3, 5, atau 7
  FOREIGN KEY (id_turnamen) REFERENCES turnamen(id_turnamen) ON DELETE CASCADE,
  FOREIGN KEY (id_tim1) REFERENCES tim(id_tim) ON DELETE CASCADE,
  FOREIGN KEY (id_tim2) REFERENCES tim(id_tim) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS statistik_pemain (  -- pemain x pertandingan
  id_stat      INT AUTO_INCREMENT PRIMARY KEY,
  id_match     INT NOT NULL,
  id_pemain    INT NOT NULL,
  kill_count   INT NOT NULL DEFAULT 0,
  death_count  INT NOT NULL DEFAULT 0,
  assist_count INT NOT NULL DEFAULT 0,
  mvp          TINYINT(1) NOT NULL DEFAULT 0,
  UNIQUE (id_match, id_pemain),
  FOREIGN KEY (id_match)  REFERENCES pertandingan(id_match) ON DELETE CASCADE,
  FOREIGN KEY (id_pemain) REFERENCES pemain(id_pemain) ON DELETE CASCADE
);
