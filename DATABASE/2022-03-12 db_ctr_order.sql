/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 100316
 Source Host           : localhost:3306
 Source Schema         : db_ctr_order

 Target Server Type    : MySQL
 Target Server Version : 100316
 File Encoding         : 65001

 Date: 12/03/2022 00:14:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for log_history
-- ----------------------------
DROP TABLE IF EXISTS `log_history`;
CREATE TABLE `log_history`  (
  `id_log` int(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `status` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `login` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `logout` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_log`) USING BTREE,
  INDEX `id_user`(`id_user`) USING BTREE,
  CONSTRAINT `log_history_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tbl_user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 269 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_connect_paket_produk
-- ----------------------------
DROP TABLE IF EXISTS `tbl_connect_paket_produk`;
CREATE TABLE `tbl_connect_paket_produk`  (
  `id_paket_produk` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_paket` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_produk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `data_status` int(1) NOT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_paket_produk`) USING BTREE,
  INDEX `id_paket`(`id_paket`, `id_produk`) USING BTREE,
  INDEX `id_produk`(`id_produk`) USING BTREE,
  CONSTRAINT `tbl_connect_paket_produk_ibfk_1` FOREIGN KEY (`id_paket`) REFERENCES `tbl_paket` (`id_paket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_connect_paket_produk_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `tbl_produk` (`id_produk`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_connect_paket_produk
-- ----------------------------
INSERT INTO `tbl_connect_paket_produk` VALUES (1, 'PKT000001', 'PRD000001', 0, '2022-03-09 18:29:05', '2022-03-09 18:29:05');

-- ----------------------------
-- Table structure for tbl_kategori
-- ----------------------------
DROP TABLE IF EXISTS `tbl_kategori`;
CREATE TABLE `tbl_kategori`  (
  `id_kategori` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_kategori` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_kategori`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_kategori
-- ----------------------------
INSERT INTO `tbl_kategori` VALUES ('KTG000001', 'NASI DUS', 1, '2022-03-09 12:25:06', '2022-03-09 12:25:20');
INSERT INTO `tbl_kategori` VALUES ('KTG000002', 'PRASMANAN', 1, '2022-03-09 12:25:51', '2022-03-09 12:25:51');
INSERT INTO `tbl_kategori` VALUES ('KTG000003', 'SNACK', 1, '2022-03-09 12:26:03', '2022-03-09 12:26:03');
INSERT INTO `tbl_kategori` VALUES ('KTG000004', 'NASI TUMPENG', 1, '2022-03-09 12:26:24', '2022-03-09 12:26:24');

-- ----------------------------
-- Table structure for tbl_menu
-- ----------------------------
DROP TABLE IF EXISTS `tbl_menu`;
CREATE TABLE `tbl_menu`  (
  `id_menu` int(20) NOT NULL AUTO_INCREMENT,
  `nama_menu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_menu`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_paket
-- ----------------------------
DROP TABLE IF EXISTS `tbl_paket`;
CREATE TABLE `tbl_paket`  (
  `id_paket` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_kategori` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_paket` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `harga_awal` double(20, 2) NOT NULL,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_paket`) USING BTREE,
  INDEX `id_kategori`(`id_kategori`) USING BTREE,
  CONSTRAINT `tbl_paket_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `tbl_kategori` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_paket
-- ----------------------------
INSERT INTO `tbl_paket` VALUES ('PKT000001', 'KTG000001', 'ND - A', 15000.00, 1, '2022-03-09 18:27:55', '2022-03-09 18:27:55');

-- ----------------------------
-- Table structure for tbl_pembayaran
-- ----------------------------
DROP TABLE IF EXISTS `tbl_pembayaran`;
CREATE TABLE `tbl_pembayaran`  (
  `id_pembayaran` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_transaksi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nominal_pembayaran` double(20, 2) NOT NULL,
  `keterangan_pembayaran` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `waktu_pembayaran` datetime(0) NOT NULL,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_pembayaran`) USING BTREE,
  INDEX `id_transaksi`(`id_transaksi`) USING BTREE,
  CONSTRAINT `tbl_pembayaran_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `tbl_transaksi` (`id_transaksi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_pembayaran
-- ----------------------------
INSERT INTO `tbl_pembayaran` VALUES (1, 'TRK000001', 25000.00, '-', '2022-03-09 18:32:02', 1, '2022-03-09 18:32:04', '2022-03-09 18:32:04');

-- ----------------------------
-- Table structure for tbl_pembeli
-- ----------------------------
DROP TABLE IF EXISTS `tbl_pembeli`;
CREATE TABLE `tbl_pembeli`  (
  `id_pembeli` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_pembeli` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kontak_pembeli` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `data_status` int(1) NOT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_pembeli`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_pembeli
-- ----------------------------
INSERT INTO `tbl_pembeli` VALUES ('PBL00001', 'SUWANDI', '082123456789', 0, '2022-03-09 18:29:40', '2022-03-09 18:29:40');

-- ----------------------------
-- Table structure for tbl_produk
-- ----------------------------
DROP TABLE IF EXISTS `tbl_produk`;
CREATE TABLE `tbl_produk`  (
  `id_produk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_produk` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan_produk` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_produk`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_produk
-- ----------------------------
INSERT INTO `tbl_produk` VALUES ('PRD000001', 'NASI KUNING', '500 GRAM', 1, '2022-03-09 18:28:37', '2022-03-09 18:28:37');

-- ----------------------------
-- Table structure for tbl_role
-- ----------------------------
DROP TABLE IF EXISTS `tbl_role`;
CREATE TABLE `tbl_role`  (
  `id_role` int(20) NOT NULL AUTO_INCREMENT,
  `name_role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_role`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_role
-- ----------------------------
INSERT INTO `tbl_role` VALUES (1, 'Superadmin', 1, '2022-03-09 18:20:36', '2022-03-09 18:20:44');
INSERT INTO `tbl_role` VALUES (2, 'Administrator', 1, '2021-04-26 11:55:01', '2022-03-09 18:20:42');
INSERT INTO `tbl_role` VALUES (3, 'Owner', 1, '2021-04-26 11:55:04', '2022-03-09 18:20:41');
INSERT INTO `tbl_role` VALUES (4, 'Kasir', 1, '2021-04-26 20:05:04', '2022-03-09 18:20:40');

-- ----------------------------
-- Table structure for tbl_sub_menu
-- ----------------------------
DROP TABLE IF EXISTS `tbl_sub_menu`;
CREATE TABLE `tbl_sub_menu`  (
  `id_sub_menu` int(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_menu` int(20) NOT NULL,
  `nama` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` int(1) NOT NULL,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_sub_menu`) USING BTREE,
  INDEX `id_menu`(`id_menu`) USING BTREE,
  CONSTRAINT `tbl_sub_menu_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `tbl_menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_transaksi
-- ----------------------------
DROP TABLE IF EXISTS `tbl_transaksi`;
CREATE TABLE `tbl_transaksi`  (
  `id_transaksi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_pembeli` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_invoice` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `harga_total` double(20, 2) NOT NULL,
  `keterangan_transaksi` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `waktu_transaksi` datetime(0) NOT NULL,
  `status_pembayaran` int(1) NOT NULL DEFAULT 1,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_transaksi`) USING BTREE,
  INDEX `id_pembeli`(`id_pembeli`) USING BTREE,
  CONSTRAINT `tbl_transaksi_ibfk_1` FOREIGN KEY (`id_pembeli`) REFERENCES `tbl_pembeli` (`id_pembeli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_transaksi
-- ----------------------------
INSERT INTO `tbl_transaksi` VALUES ('TRK000001', 'PBL00001', 'IVC2022030918301', 0.00, '-', '2022-03-09 18:30:52', 1, 1, '2022-03-09 18:30:59', '2022-03-09 18:30:59');

-- ----------------------------
-- Table structure for tbl_transaksi_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbl_transaksi_detail`;
CREATE TABLE `tbl_transaksi_detail`  (
  `id_transaksi_detail` int(10) NOT NULL AUTO_INCREMENT,
  `id_transaksi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_paket` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `qty` int(10) NOT NULL,
  `harga_akhir` double(20, 2) NOT NULL,
  `harga_subtotal` double(20, 2) NOT NULL,
  `keterangan_transaksi_detail` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_transaksi_detail`) USING BTREE,
  INDEX `id_transaksi`(`id_transaksi`, `id_paket`) USING BTREE,
  INDEX `id_paket`(`id_paket`) USING BTREE,
  CONSTRAINT `tbl_transaksi_detail_ibfk_1` FOREIGN KEY (`id_paket`) REFERENCES `tbl_paket` (`id_paket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_transaksi_detail_ibfk_2` FOREIGN KEY (`id_transaksi`) REFERENCES `tbl_transaksi` (`id_transaksi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_transaksi_detail
-- ----------------------------
INSERT INTO `tbl_transaksi_detail` VALUES (1, 'TRK000001', 'PKT000001', 5, 15000.00, 75000.00, '', 1, '2022-03-09 18:31:38', '2022-03-09 18:31:38');

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user`  (
  `id_user` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_role` int(20) NOT NULL,
  `nama_user` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email_user` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password_user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_active` int(1) NOT NULL DEFAULT 1,
  `file_gambar` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `login_attempt` int(1) NOT NULL DEFAULT 0,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_user`) USING BTREE,
  INDEX `id_role`(`id_role`) USING BTREE,
  CONSTRAINT `tbl_user_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `tbl_role` (`id_role`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('1', 1, 'Superadmin App', 'superadmin@samudra.com', 'superadmin123', 1, 'superadmin.jpg', 0, 1, '2022-03-09 18:26:06', '2022-03-09 18:26:06');
INSERT INTO `tbl_user` VALUES ('10', 4, 'Heru', 'heru@samudra.com', 'heru1023', 1, 'heru.jpg', 0, 1, '2022-03-09 18:26:06', '2022-03-09 18:26:06');
INSERT INTO `tbl_user` VALUES ('2', 2, 'Master Admin', 'master@samudra.com', 'master223', 1, 'master.jpg', 0, 1, '2022-03-09 18:26:06', '2022-03-09 18:26:06');
INSERT INTO `tbl_user` VALUES ('3', 3, 'HJ. XXX', 'hj@samudra.com', 'hj323', 1, 'hj.jpg', 0, 1, '2022-03-09 18:26:06', '2022-03-09 18:26:06');
INSERT INTO `tbl_user` VALUES ('4', 3, 'H. YYYY', 'h@samudra.com', 'h423', 1, 'h.jpg', 0, 1, '2022-03-09 18:26:06', '2022-03-09 18:26:06');
INSERT INTO `tbl_user` VALUES ('5', 4, 'Delta', 'delta@samudra.com', 'delta523', 1, 'delta.jpg', 0, 1, '2022-03-09 18:26:06', '2022-03-09 18:26:06');
INSERT INTO `tbl_user` VALUES ('6', 4, 'Dori', 'dori@samudra.com', 'dori623', 1, 'dori.jpg', 0, 1, '2022-03-09 18:26:06', '2022-03-09 18:26:06');
INSERT INTO `tbl_user` VALUES ('7', 4, 'Beny', 'beny@samudra.com', 'beny723', 1, 'beny.jpg', 0, 1, '2022-03-09 18:26:06', '2022-03-09 18:26:06');
INSERT INTO `tbl_user` VALUES ('8', 4, 'Lita', 'lita@samudra.com', 'lita823', 1, 'lita.jpg', 0, 1, '2022-03-09 18:26:06', '2022-03-09 18:26:06');
INSERT INTO `tbl_user` VALUES ('9', 4, 'Vika', 'vika@samudra.com', 'vika923', 1, 'vika.jpg', 0, 1, '2022-03-09 18:26:06', '2022-03-09 18:26:06');

-- ----------------------------
-- Table structure for tbl_user_access_menu
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user_access_menu`;
CREATE TABLE `tbl_user_access_menu`  (
  `id_user_access_menu` int(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_role` int(20) NOT NULL,
  `id_menu` int(20) NOT NULL,
  `data_status` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp(0) NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_user_access_menu`) USING BTREE,
  INDEX `id_role`(`id_role`) USING BTREE,
  INDEX `id_menu`(`id_menu`) USING BTREE,
  CONSTRAINT `tbl_user_access_menu_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `tbl_menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_user_access_menu_ibfk_2` FOREIGN KEY (`id_role`) REFERENCES `tbl_role` (`id_role`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Triggers structure for table tbl_menu
-- ----------------------------
DROP TRIGGER IF EXISTS `TG_DS_menu_submenu`;
delimiter ;;
CREATE DEFINER = `root`@`localhost` TRIGGER `TG_DS_menu_submenu` BEFORE UPDATE ON `tbl_menu` FOR EACH ROW BEGIN
		IF new.data_status IS NULL OR new.data_status = 1 THEN
			update tbl_sub_menu set data_status=1 WHERE id_menu=new.id_menu;
		ELSEIF new.data_status = 0 THEN
			update tbl_sub_menu set data_status=0 WHERE id_menu=new.id_menu;
		ELSE
			update tbl_sub_menu set data_status=0 WHERE id_menu=new.id_menu;
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tbl_menu
-- ----------------------------
DROP TRIGGER IF EXISTS `TG_DS_menu_uam`;
delimiter ;;
CREATE DEFINER = `root`@`localhost` TRIGGER `TG_DS_menu_uam` BEFORE UPDATE ON `tbl_menu` FOR EACH ROW BEGIN
		IF new.data_status IS NULL OR new.data_status = 1 THEN
			update tbl_user_access_menu set data_status=1 WHERE id_menu=new.id_menu;
		ELSEIF new.data_status = 0 THEN
			update tbl_user_access_menu set data_status=0 WHERE id_menu=new.id_menu;
		ELSE
			update tbl_user_access_menu set data_status=0 WHERE id_menu=new.id_menu;
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tbl_role
-- ----------------------------
DROP TRIGGER IF EXISTS `TG_DS_role_user`;
delimiter ;;
CREATE DEFINER = `root`@`localhost` TRIGGER `TG_DS_role_user` BEFORE UPDATE ON `tbl_role` FOR EACH ROW BEGIN
		IF new.data_status IS NULL OR new.data_status = 1 THEN
			update tbl_user set data_status=1 WHERE id_role=new.id_role;
		ELSEIF new.data_status = 0 THEN
			update tbl_user set data_status=0 WHERE id_role=new.id_role;
		ELSE
			update tbl_user set data_status=0 WHERE id_role=new.id_role;
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tbl_role
-- ----------------------------
DROP TRIGGER IF EXISTS `TG_DS_role_uam`;
delimiter ;;
CREATE DEFINER = `root`@`localhost` TRIGGER `TG_DS_role_uam` BEFORE UPDATE ON `tbl_role` FOR EACH ROW BEGIN
		IF new.data_status IS NULL OR new.data_status = 1 THEN
			update tbl_user_access_menu set data_status=1 WHERE id_role=new.id_role;
		ELSEIF new.data_status = 0 THEN
			update tbl_user_access_menu set data_status=0 WHERE id_role=new.id_role;
		ELSE
			update tbl_user_access_menu set data_status=0 WHERE id_role=new.id_role;
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tbl_user
-- ----------------------------
DROP TRIGGER IF EXISTS `TG_DS_user_log`;
delimiter ;;
CREATE DEFINER = `root`@`localhost` TRIGGER `TG_DS_user_log` BEFORE UPDATE ON `tbl_user` FOR EACH ROW BEGIN
		IF new.data_status IS NULL OR new.data_status = 1 THEN
			update log_history set data_status=1 WHERE id_user=new.id_user;
		ELSEIF new.data_status = 0 THEN
			update log_history set data_status=0 WHERE id_user=new.id_user;
		ELSE
			update log_history set data_status=0 WHERE id_user=new.id_user;
		END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
