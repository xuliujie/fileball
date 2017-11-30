/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 100114
Source Host           : localhost:3306
Source Database       : fancsgo_bak

Target Server Type    : MYSQL
Target Server Version : 100114
File Encoding         : 65001

Date: 2017-11-30 11:54:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for betting_steamrobotapiitem
-- ----------------------------
DROP TABLE IF EXISTS `betting_steamrobotapiitem`;
CREATE TABLE `betting_steamrobotapiitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `md5` varchar(128) NOT NULL,
  `hash_name` varchar(128) NOT NULL,
  `item_price_trend_ajax_url` varchar(1024) DEFAULT NULL,
  `item_price_trend_url` varchar(1024) NOT NULL,
  `item_refer_price_dollar` double DEFAULT NULL,
  `item_name` varchar(128) NOT NULL,
  `item_recent_7_avg_price` double DEFAULT NULL,
  `c5_item_id` varchar(128) NOT NULL,
  `item_refer_price_rmb` double DEFAULT NULL,
  `steam_url` varchar(1024) DEFAULT NULL,
  `item_recent_hour_price` double DEFAULT NULL,
  `appid` varchar(128) NOT NULL,
  `item_recent_day_price` double DEFAULT NULL,
  `item_sell_record_url` varchar(1024) DEFAULT NULL,
  `steam_sale_price_dollar` double DEFAULT NULL,
  `steam_normal_price_dollar` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5` (`md5`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_steamrobotapiitem
-- ----------------------------
INSERT INTO `betting_steamrobotapiitem` VALUES ('1', 'd64c587989055a4e0bf0dd220d49e36a', 'Autograph Capsule | Team Kinguin | Cologne 2015', null, '', null, '', null, '', null, null, null, '', null, null, '0.47', '0.49');
INSERT INTO `betting_steamrobotapiitem` VALUES ('2', '72041c83b05b8784c1504a31f0f75825', 'Music Kit | Daniel Sadowski, The 8-Bit Kit', null, '', null, '', null, '', null, null, null, '', null, null, '4.49', '4.69');
INSERT INTO `betting_steamrobotapiitem` VALUES ('3', '2041fe1ab45ac5944281038b2e890e46', 'Sealed Graffiti | Popdog (Desert Amber)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', '0.03');
