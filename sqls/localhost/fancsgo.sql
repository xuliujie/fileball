/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 100114
Source Host           : localhost:3306
Source Database       : fancsgo

Target Server Type    : MYSQL
Target Server Version : 100114
File Encoding         : 65001

Date: 2017-11-30 15:44:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add pinned application', '1', 'add_pinnedapplication');
INSERT INTO `auth_permission` VALUES ('2', 'Can change pinned application', '1', 'change_pinnedapplication');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete pinned application', '1', 'delete_pinnedapplication');
INSERT INTO `auth_permission` VALUES ('4', 'Can add bookmark', '2', 'add_bookmark');
INSERT INTO `auth_permission` VALUES ('5', 'Can change bookmark', '2', 'change_bookmark');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete bookmark', '2', 'delete_bookmark');
INSERT INTO `auth_permission` VALUES ('7', 'Can add log entry', '3', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('8', 'Can change log entry', '3', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete log entry', '3', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('10', 'Can add group', '4', 'add_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can change group', '4', 'change_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete group', '4', 'delete_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add permission', '5', 'add_permission');
INSERT INTO `auth_permission` VALUES ('14', 'Can change permission', '5', 'change_permission');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete permission', '5', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('16', 'Can add content type', '6', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('17', 'Can change content type', '6', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete content type', '6', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('19', 'Can add session', '7', 'add_session');
INSERT INTO `auth_permission` VALUES ('20', 'Can change session', '7', 'change_session');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete session', '7', 'delete_session');
INSERT INTO `auth_permission` VALUES ('22', 'Can add site', '8', 'add_site');
INSERT INTO `auth_permission` VALUES ('23', 'Can change site', '8', 'change_site');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete site', '8', 'delete_site');
INSERT INTO `auth_permission` VALUES ('25', 'Can add SteamUsers', '9', 'add_steamuser');
INSERT INTO `auth_permission` VALUES ('26', 'Can change SteamUsers', '9', 'change_steamuser');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete SteamUsers', '9', 'delete_steamuser');
INSERT INTO `auth_permission` VALUES ('28', 'Can add association', '10', 'add_association');
INSERT INTO `auth_permission` VALUES ('29', 'Can change association', '10', 'change_association');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete association', '10', 'delete_association');
INSERT INTO `auth_permission` VALUES ('31', 'Can add user social auth', '11', 'add_usersocialauth');
INSERT INTO `auth_permission` VALUES ('32', 'Can change user social auth', '11', 'change_usersocialauth');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete user social auth', '11', 'delete_usersocialauth');
INSERT INTO `auth_permission` VALUES ('34', 'Can add nonce', '12', 'add_nonce');
INSERT INTO `auth_permission` VALUES ('35', 'Can change nonce', '12', 'change_nonce');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete nonce', '12', 'delete_nonce');
INSERT INTO `auth_permission` VALUES ('37', 'Can add code', '13', 'add_code');
INSERT INTO `auth_permission` VALUES ('38', 'Can change code', '13', 'change_code');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete code', '13', 'delete_code');
INSERT INTO `auth_permission` VALUES ('40', 'Can add partial', '14', 'add_partial');
INSERT INTO `auth_permission` VALUES ('41', 'Can change partial', '14', 'change_partial');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete partial', '14', 'delete_partial');
INSERT INTO `auth_permission` VALUES ('43', 'Can add user profile', '15', 'add_userprofile');
INSERT INTO `auth_permission` VALUES ('44', 'Can change user profile', '15', 'change_userprofile');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete user profile', '15', 'delete_userprofile');
INSERT INTO `auth_permission` VALUES ('46', 'Can add Games', '16', 'add_coinflipgame');
INSERT INTO `auth_permission` VALUES ('47', 'Can change Games', '16', 'change_coinflipgame');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete Games', '16', 'delete_coinflipgame');
INSERT INTO `auth_permission` VALUES ('49', 'Can add Temp Game Hash', '17', 'add_tempgamehash');
INSERT INTO `auth_permission` VALUES ('50', 'Can change Temp Game Hash', '17', 'change_tempgamehash');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete Temp Game Hash', '17', 'delete_tempgamehash');
INSERT INTO `auth_permission` VALUES ('52', 'Can add message', '18', 'add_message');
INSERT INTO `auth_permission` VALUES ('53', 'Can change message', '18', 'change_message');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete message', '18', 'delete_message');
INSERT INTO `auth_permission` VALUES ('55', 'Can add Site Configs', '19', 'add_siteconfig');
INSERT INTO `auth_permission` VALUES ('56', 'Can change Site Configs', '19', 'change_siteconfig');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete Site Configs', '19', 'delete_siteconfig');
INSERT INTO `auth_permission` VALUES ('58', 'Can add Betting Bots', '20', 'add_bettingbot');
INSERT INTO `auth_permission` VALUES ('59', 'Can change Betting Bots', '20', 'change_bettingbot');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete Betting Bots', '20', 'delete_bettingbot');
INSERT INTO `auth_permission` VALUES ('61', 'Can add market item', '21', 'add_marketitem');
INSERT INTO `auth_permission` VALUES ('62', 'Can change market item', '21', 'change_marketitem');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete market item', '21', 'delete_marketitem');
INSERT INTO `auth_permission` VALUES ('64', 'Can add UserAmountReocrds', '22', 'add_useramountrecord');
INSERT INTO `auth_permission` VALUES ('65', 'Can change UserAmountReocrds', '22', 'change_useramountrecord');
INSERT INTO `auth_permission` VALUES ('66', 'Can delete UserAmountReocrds', '22', 'delete_useramountrecord');
INSERT INTO `auth_permission` VALUES ('67', 'Can add room', '23', 'add_room');
INSERT INTO `auth_permission` VALUES ('68', 'Can change room', '23', 'change_room');
INSERT INTO `auth_permission` VALUES ('69', 'Can delete room', '23', 'delete_room');
INSERT INTO `auth_permission` VALUES ('70', 'Can add Announcements', '24', 'add_announcement');
INSERT INTO `auth_permission` VALUES ('71', 'Can change Announcements', '24', 'change_announcement');
INSERT INTO `auth_permission` VALUES ('72', 'Can delete Announcements', '24', 'delete_announcement');
INSERT INTO `auth_permission` VALUES ('73', 'Can add Give Away', '25', 'add_giveaway');
INSERT INTO `auth_permission` VALUES ('74', 'Can change Give Away', '25', 'change_giveaway');
INSERT INTO `auth_permission` VALUES ('75', 'Can delete Give Away', '25', 'delete_giveaway');
INSERT INTO `auth_permission` VALUES ('76', 'Can add steamrobot api item', '26', 'add_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('77', 'Can change steamrobot api item', '26', 'change_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('78', 'Can delete steamrobot api item', '26', 'delete_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('79', 'Can add Prop Items', '27', 'add_propitem');
INSERT INTO `auth_permission` VALUES ('80', 'Can change Prop Items', '27', 'change_propitem');
INSERT INTO `auth_permission` VALUES ('81', 'Can delete Prop Items', '27', 'delete_propitem');
INSERT INTO `auth_permission` VALUES ('82', 'Can add Send Records', '28', 'add_sendrecord');
INSERT INTO `auth_permission` VALUES ('83', 'Can change Send Records', '28', 'change_sendrecord');
INSERT INTO `auth_permission` VALUES ('84', 'Can delete Send Records', '28', 'delete_sendrecord');
INSERT INTO `auth_permission` VALUES ('85', 'Can add Deposit', '29', 'add_deposit');
INSERT INTO `auth_permission` VALUES ('86', 'Can change Deposit', '29', 'change_deposit');
INSERT INTO `auth_permission` VALUES ('87', 'Can delete Deposit', '29', 'delete_deposit');

-- ----------------------------
-- Table structure for betting_announcement
-- ----------------------------
DROP TABLE IF EXISTS `betting_announcement`;
CREATE TABLE `betting_announcement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `anno_type` smallint(6) NOT NULL,
  `content` longtext NOT NULL,
  `content_en` longtext NOT NULL,
  `enable` tinyint(1) NOT NULL,
  `num` int(11) NOT NULL,
  `remark` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_announcement
-- ----------------------------

-- ----------------------------
-- Table structure for betting_bettingbot
-- ----------------------------
DROP TABLE IF EXISTS `betting_bettingbot`;
CREATE TABLE `betting_bettingbot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coinflip_enable` tinyint(1) NOT NULL,
  `coinflip_joinable` tinyint(1) NOT NULL,
  `coinflip_join_idle` int(11) NOT NULL,
  `coinflip_creatable` tinyint(1) NOT NULL,
  `coinflip_create_idle` int(11) NOT NULL,
  `coinflip_value_min` int(11) NOT NULL,
  `coinflip_value_max` int(11) NOT NULL,
  `coinflip_max_count` int(11) NOT NULL,
  `jackpot_enable` tinyint(1) NOT NULL,
  `jackpot_join_idle` int(11) NOT NULL,
  `jackpot_value_min` int(11) NOT NULL,
  `jackpot_value_max` int(11) NOT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `steamer_id` (`steamer_id`),
  CONSTRAINT `betting_bettingbot_steamer_id_47ce065d_fk_social_au` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_bettingbot
-- ----------------------------

-- ----------------------------
-- Table structure for betting_coinflipgame
-- ----------------------------
DROP TABLE IF EXISTS `betting_coinflipgame`;
CREATE TABLE `betting_coinflipgame` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `secret` varchar(32) NOT NULL,
  `percentage` double NOT NULL,
  `game_type` smallint(6) NOT NULL,
  `run_ts` datetime(6) DEFAULT NULL,
  `total_amount` double NOT NULL,
  `total_items` int(11) NOT NULL,
  `total_tickets` bigint(20) NOT NULL,
  `win_ticket` bigint(20) NOT NULL,
  `win_ts` datetime(6) NOT NULL,
  `status` smallint(6) NOT NULL,
  `end` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_coinflipgame
-- ----------------------------
INSERT INTO `betting_coinflipgame` VALUES ('1', '4b413980d58211e7a0d3e03f497cc42f', '2017-11-30 03:55:24.313000', '2017-11-30 03:55:24.313000', '5bb4a7cf6bd051394ae2b3cca2581da3', 'ZDJVBSFINO', '5.99880688586605', '1', null, '0', '0', '0', '-1', '2017-11-30 03:55:24.312000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('2', '5e730330d58211e7acbce03f497cc42f', '2017-11-30 03:55:56.515000', '2017-11-30 06:26:40.389000', '8ae23f7af40405d49357e7ef25c91207', 'GDCSWYGLQA', '95.6111399010376', '1', '2017-11-30 06:25:40.339000', '44.16', '6', '4415', '4221', '2017-11-30 06:26:40.389000', '11', '1');
INSERT INTO `betting_coinflipgame` VALUES ('3', '6d1d3c5ed59711e7b104e03f497cc42f', '2017-11-30 06:26:40.550000', '2017-11-30 06:26:40.550000', '296fe581a67130c0f8426c4b3612a0e8', 'ECRTBXWPER', '85.2380871083224', '1', null, '0', '0', '0', '-1', '2017-11-30 06:26:40.550000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('4', '837fac8fd59711e7abe3e03f497cc42f', '2017-11-30 06:27:18.105000', '2017-11-30 06:28:18.612000', '2ef007fc12d8aed8ca4a3f70e731c5fd', 'EIGYEBJAAE', '50.6811792521016', '0', null, '18.22', '2', '1822', '923', '2017-11-30 06:28:18.612000', '11', '1');
INSERT INTO `betting_coinflipgame` VALUES ('5', '0dc227b0d59911e7ba53e03f497cc42f', '2017-11-30 06:38:19.563000', '2017-11-30 06:49:15.023000', '4a2ad19da894e8d6a5cdb29f401af425', 'QKYJQOHICC', '11.1801174256782', '0', null, '15.66', '2', '1566', '-1', '2017-11-30 06:38:19.563000', '6', '0');

-- ----------------------------
-- Table structure for betting_deposit
-- ----------------------------
DROP TABLE IF EXISTS `betting_deposit`;
CREATE TABLE `betting_deposit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `team` int(11) NOT NULL,
  `is_creator` tinyint(1) NOT NULL,
  `is_joined` tinyint(1) NOT NULL,
  `game_type` smallint(6) NOT NULL,
  `amount` double NOT NULL,
  `status` int(11) NOT NULL,
  `join_status` smallint(6) NOT NULL,
  `security_code` varchar(32) DEFAULT NULL,
  `trade_no` varchar(64) DEFAULT NULL,
  `accept_time` datetime(6) DEFAULT NULL,
  `tickets_begin` bigint(20) NOT NULL,
  `tickets_end` bigint(20) NOT NULL,
  `game_id` int(11) DEFAULT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `betting_deposit_game_id_cfe72b5c_fk_betting_coinflipgame_id` (`game_id`),
  KEY `betting_deposit_steamer_id_4c61d59d_fk_social_auth_steamuser_id` (`steamer_id`),
  CONSTRAINT `betting_deposit_game_id_cfe72b5c_fk_betting_coinflipgame_id` FOREIGN KEY (`game_id`) REFERENCES `betting_coinflipgame` (`id`),
  CONSTRAINT `betting_deposit_steamer_id_4c61d59d_fk_social_auth_steamuser_id` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_deposit
-- ----------------------------
INSERT INTO `betting_deposit` VALUES ('1', '2015d84fd59711e7931ce03f497cc42f', '2017-11-30 06:24:31.328000', '2017-11-30 06:24:44.923000', '0', '0', '0', '1', '19.62', '1', '20', 'ACJNPCMI', '2102296394', '2017-11-30 06:24:44.888000', '1', '1961', '2', '1');
INSERT INTO `betting_deposit` VALUES ('2', '41321a30d59711e79530e03f497cc42f', '2017-11-30 06:25:26.867000', '2017-11-30 06:25:40.330000', '0', '0', '0', '1', '24.54', '1', '20', 'D1U5Z1ET', '2102296395', '2017-11-30 06:25:40.294000', '1962', '4415', '2', '2');
INSERT INTO `betting_deposit` VALUES ('3', '8388ad40d59711e7a790e03f497cc42f', '2017-11-30 06:27:18.164000', '2017-11-30 06:28:18.600000', '0', '0', '0', '0', '9.15', '1', '20', '08W9K3XL', '2102296396', '2017-11-30 06:27:32.038000', '1', '915', '4', '2');
INSERT INTO `betting_deposit` VALUES ('4', '9f5b7ac0d59711e7a860e03f497cc42f', '2017-11-30 06:28:04.844000', '2017-11-30 06:28:18.602000', '1', '0', '0', '0', '9.07', '1', '20', 'S9OH02BU', '2102296397', '2017-11-30 06:28:18.563000', '916', '1822', '4', '1');
INSERT INTO `betting_deposit` VALUES ('5', '0dc69480d59911e7950ee03f497cc42f', '2017-11-30 06:38:19.592000', '2017-11-30 06:38:33.376000', '0', '0', '0', '0', '15.66', '1', '20', '7KQSNTKE', '2102296394', '2017-11-30 06:38:33.343000', '1', '1566', '5', '2');

-- ----------------------------
-- Table structure for betting_giveaway
-- ----------------------------
DROP TABLE IF EXISTS `betting_giveaway`;
CREATE TABLE `betting_giveaway` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `title` varchar(128) NOT NULL,
  `img` varchar(200) NOT NULL,
  `href` varchar(200) NOT NULL,
  `button` varchar(64) NOT NULL,
  `num` int(11) NOT NULL,
  `enable` tinyint(1) NOT NULL,
  `remark` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_giveaway
-- ----------------------------

-- ----------------------------
-- Table structure for betting_marketitem
-- ----------------------------
DROP TABLE IF EXISTS `betting_marketitem`;
CREATE TABLE `betting_marketitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `md5` varchar(128) NOT NULL,
  `market_name` varchar(128) NOT NULL,
  `sm_url` varchar(200) DEFAULT NULL,
  `quality` varchar(128) DEFAULT NULL,
  `avg_price_7_days` double DEFAULT NULL,
  `avg_price_7_days_raw` double DEFAULT NULL,
  `avg_price_30_days` double DEFAULT NULL,
  `avg_price_30_days_raw` double DEFAULT NULL,
  `link` varchar(200) DEFAULT NULL,
  `current_price` double DEFAULT NULL,
  `current_price_last_checked` datetime(6) DEFAULT NULL,
  `sold_last_24h` int(11) DEFAULT NULL,
  `sold_last_7d` int(11) DEFAULT NULL,
  `avg_daily_volume` int(11) DEFAULT NULL,
  `img` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5` (`md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_marketitem
-- ----------------------------

-- ----------------------------
-- Table structure for betting_message
-- ----------------------------
DROP TABLE IF EXISTS `betting_message`;
CREATE TABLE `betting_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `room_id` int(11) NOT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `betting_message_timestamp_3bb76cf5` (`timestamp`),
  KEY `betting_message_room_id_85ee396d_fk_betting_room_id` (`room_id`),
  KEY `betting_message_steamer_id_08befdca_fk_social_auth_steamuser_id` (`steamer_id`),
  CONSTRAINT `betting_message_room_id_85ee396d_fk_betting_room_id` FOREIGN KEY (`room_id`) REFERENCES `betting_room` (`id`),
  CONSTRAINT `betting_message_steamer_id_08befdca_fk_social_auth_steamuser_id` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_message
-- ----------------------------
INSERT INTO `betting_message` VALUES ('1', '11', '2017-11-30 06:26:40.744000', '1', '2');

-- ----------------------------
-- Table structure for betting_propitem
-- ----------------------------
DROP TABLE IF EXISTS `betting_propitem`;
CREATE TABLE `betting_propitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `sid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `market_name` varchar(255) NOT NULL,
  `market_hash_name` varchar(255) DEFAULT NULL,
  `amount` double NOT NULL,
  `rarity` varchar(128) DEFAULT NULL,
  `rarity_color` varchar(128) DEFAULT NULL,
  `exterior` varchar(128) DEFAULT NULL,
  `assetid` varchar(128) DEFAULT NULL,
  `appid` varchar(128) NOT NULL,
  `classid` varchar(128) NOT NULL,
  `contextid` int(11) NOT NULL,
  `instanceid` varchar(128) DEFAULT NULL,
  `deposit_id` int(11) NOT NULL,
  `send_record_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `betting_propitem_deposit_id_2635fd34_fk_betting_deposit_id` (`deposit_id`),
  KEY `betting_propitem_send_record_id_1e82811d_fk_betting_s` (`send_record_id`),
  CONSTRAINT `betting_propitem_deposit_id_2635fd34_fk_betting_deposit_id` FOREIGN KEY (`deposit_id`) REFERENCES `betting_deposit` (`id`),
  CONSTRAINT `betting_propitem_send_record_id_1e82811d_fk_betting_s` FOREIGN KEY (`send_record_id`) REFERENCES `betting_sendrecord` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_propitem
-- ----------------------------
INSERT INTO `betting_propitem` VALUES ('1', '201da080d59711e7bbcee03f497cc42f', '2017-11-30 06:24:31.368000', '2017-11-30 06:26:40.426000', '12350115720', 'CZ75-Auto | Imprint', 'CZ75-Auto | Imprint (Battle-Scarred)', 'CZ75-Auto | Imprint (Battle-Scarred)', '9.77', 'Mil-Spec Grade', '4b69ff', 'Battle-Scarred', '112350115720', '730', '1934423929', '2', '188530139', '1', '1');
INSERT INTO `betting_propitem` VALUES ('2', '20278b91d59711e7a6fbe03f497cc42f', '2017-11-30 06:24:31.433000', '2017-11-30 06:26:40.416000', '12359791200', 'Dual Berettas | Cobalt Quartz', 'Dual Berettas | Cobalt Quartz (Field-Tested)', 'Dual Berettas | Cobalt Quartz (Field-Tested)', '9.85', 'Restricted', '8847ff', 'Field-Tested', '112359791200', '730', '310777518', '2', '302028390', '1', '1');
INSERT INTO `betting_propitem` VALUES ('3', '4133048fd59711e79083e03f497cc42f', '2017-11-30 06:25:26.873000', '2017-11-30 06:26:40.423000', '11875844665', 'SCAR-20 | Contractor', 'SCAR-20 | Contractor (Minimal Wear)', 'SCAR-20 | Contractor (Minimal Wear)', '8.22', 'Consumer Grade', 'b0c3d9', 'Minimal Wear', '111875844665', '730', '310776632', '2', '302028390', '2', '1');
INSERT INTO `betting_propitem` VALUES ('4', '4133eef0d59711e784cae03f497cc42f', '2017-11-30 06:25:26.880000', '2017-11-30 06:26:40.412000', '11875811527', 'Glock-18 | Groundwater', 'Glock-18 | Groundwater (Minimal Wear)', 'Glock-18 | Groundwater (Minimal Wear)', '5', 'Industrial Grade', '5e98d9', 'Minimal Wear', '111875811527', '730', '310779514', '2', '0', '2', '1');
INSERT INTO `betting_propitem` VALUES ('5', '41352770d59711e78316e03f497cc42f', '2017-11-30 06:25:26.888000', '2017-11-30 06:26:40.419000', '10784164955', 'Sealed Graffiti | Popdog (Desert Amber)', 'Sealed Graffiti | Popdog (Desert Amber)', 'Sealed Graffiti | Popdog (Desert Amber)', '4.15', 'Base Grade', 'b0c3d9', null, '110784164955', '730', '1989322935', '2', '302028390', '2', '1');
INSERT INTO `betting_propitem` VALUES ('6', '413611cfd59711e7bb67e03f497cc42f', '2017-11-30 06:25:26.893000', '2017-11-30 06:26:40.408000', '11875878879', 'PP-Bizon | Urban Dashed', 'PP-Bizon | Urban Dashed (Field-Tested)', 'PP-Bizon | Urban Dashed (Field-Tested)', '7.17', 'Consumer Grade', 'b0c3d9', 'Field-Tested', '111875878879', '730', '310776765', '2', '302028390', '2', '1');
INSERT INTO `betting_propitem` VALUES ('7', '8389beb0d59711e7b308e03f497cc42f', '2017-11-30 06:27:18.171000', '2017-11-30 06:28:18.631000', '12337114152', 'M4A1-S | Boreal Forest', 'M4A1-S | Boreal Forest (Well-Worn)', 'M4A1-S | Boreal Forest (Well-Worn)', '9.15', 'Industrial Grade', '5e98d9', 'Well-Worn', '112337114152', '730', '310777929', '2', '302028390', '3', '2');
INSERT INTO `betting_propitem` VALUES ('8', '9f5e60eed59711e79ddae03f497cc42f', '2017-11-30 06:28:04.863000', '2017-11-30 06:28:18.634000', '12359791200', 'Dual Berettas | Cobalt Quartz', 'Dual Berettas | Cobalt Quartz (Field-Tested)', 'Dual Berettas | Cobalt Quartz (Field-Tested)', '9.07', 'Restricted', '8847ff', 'Field-Tested', '112359791200', '730', '310777518', '2', '302028390', '4', '2');
INSERT INTO `betting_propitem` VALUES ('9', '0dc7a5f0d59911e79227e03f497cc42f', '2017-11-30 06:38:19.599000', '2017-11-30 06:49:15.101000', '10784164955', 'Sealed Graffiti | Popdog (Desert Amber)', 'Sealed Graffiti | Popdog (Desert Amber)', 'Sealed Graffiti | Popdog (Desert Amber)', '7.99', 'Base Grade', 'b0c3d9', null, '110784164955', '730', '1989322935', '2', '302028390', '5', '3');
INSERT INTO `betting_propitem` VALUES ('10', '0dca16f0d59911e798c5e03f497cc42f', '2017-11-30 06:38:19.615000', '2017-11-30 06:49:15.104000', '11875811527', 'Glock-18 | Groundwater', 'Glock-18 | Groundwater (Minimal Wear)', 'Glock-18 | Groundwater (Minimal Wear)', '7.67', 'Industrial Grade', '5e98d9', 'Minimal Wear', '111875811527', '730', '310779514', '2', '0', '5', '3');

-- ----------------------------
-- Table structure for betting_room
-- ----------------------------
DROP TABLE IF EXISTS `betting_room`;
CREATE TABLE `betting_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext NOT NULL,
  `label` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_room
-- ----------------------------
INSERT INTO `betting_room` VALUES ('1', '', 'chat_room');

-- ----------------------------
-- Table structure for betting_sendrecord
-- ----------------------------
DROP TABLE IF EXISTS `betting_sendrecord`;
CREATE TABLE `betting_sendrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `status` smallint(6) NOT NULL,
  `amount` double NOT NULL,
  `security_code` varchar(32) DEFAULT NULL,
  `trade_no` varchar(64) DEFAULT NULL,
  `bot_status` int(11) NOT NULL,
  `bot_msg` longtext,
  `trade_ts` datetime(6) NOT NULL,
  `game_id` int(11) DEFAULT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `betting_sendrecord_game_id_8b8e2252_fk_betting_coinflipgame_id` (`game_id`),
  KEY `betting_sendrecord_steamer_id_8a54c2ad_fk_social_au` (`steamer_id`),
  CONSTRAINT `betting_sendrecord_game_id_8b8e2252_fk_betting_coinflipgame_id` FOREIGN KEY (`game_id`) REFERENCES `betting_coinflipgame` (`id`),
  CONSTRAINT `betting_sendrecord_steamer_id_8a54c2ad_fk_social_au` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_sendrecord
-- ----------------------------
INSERT INTO `betting_sendrecord` VALUES ('1', '6d071c4fd59711e79018e03f497cc42f', '2017-11-30 06:26:40.405000', '2017-11-30 06:29:51.102000', '1', '0', 'ESEV1TSC', '4233252111', '0', '', '2017-11-30 06:26:40.405000', '2', '2');
INSERT INTO `betting_sendrecord` VALUES ('2', 'a7929930d59711e7bb39e03f497cc42f', '2017-11-30 06:28:18.627000', '2017-11-30 06:29:51.087000', '1', '0', 'YVSEK08K', '4233252112', '0', '', '2017-11-30 06:28:18.627000', '4', '1');
INSERT INTO `betting_sendrecord` VALUES ('3', '947365c0d59a11e7868de03f497cc42f', '2017-11-30 06:49:15.036000', '2017-11-30 06:50:21.633000', '1', '0', 'EZI2LEGI', '4233252111', '0', '', '2017-11-30 06:49:15.036000', '5', '2');

-- ----------------------------
-- Table structure for betting_siteconfig
-- ----------------------------
DROP TABLE IF EXISTS `betting_siteconfig`;
CREATE TABLE `betting_siteconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(64) NOT NULL,
  `value` int(11) NOT NULL,
  `value_string` varchar(128) NOT NULL,
  `enable` tinyint(1) NOT NULL,
  `remark` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_siteconfig
-- ----------------------------

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
  `item_refer_igxe_price` double DEFAULT NULL,
  `item_refer_igxe_steam_price` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5` (`md5`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_steamrobotapiitem
-- ----------------------------
INSERT INTO `betting_steamrobotapiitem` VALUES ('1', 'd64c587989055a4e0bf0dd220d49e36a', 'Autograph Capsule | Team Kinguin | Cologne 2015', null, '', null, '', null, '', null, null, null, '', null, null, '0.47', '0.49', null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('2', '72041c83b05b8784c1504a31f0f75825', 'Music Kit | Daniel Sadowski, The 8-Bit Kit', null, '', null, '', null, '', null, null, null, '', null, null, '4.49', '4.69', null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('3', '2041fe1ab45ac5944281038b2e890e46', 'Sealed Graffiti | Popdog (Desert Amber)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', '0.03', null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('4', 'e8db87f8f952837438e289595fd88078', 'SSG 08 | Blue Spruce (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.15', '0.2');
INSERT INTO `betting_steamrobotapiitem` VALUES ('5', 'e26b9ca8658dcd5474be5ad8c0c03d97', 'Tec-9 | Bamboo Forest (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.04', null, '0.31', '0.33');
INSERT INTO `betting_steamrobotapiitem` VALUES ('6', 'fd74bd68a680093394cee14de93d1b35', 'SCAR-20 | Sand Mesh (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.16', '0.2');
INSERT INTO `betting_steamrobotapiitem` VALUES ('7', '219ff71fa2fb635b4607ce213cd38091', 'Glock-18 | Brass (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '1.95', null, '10.87', '11.5');
INSERT INTO `betting_steamrobotapiitem` VALUES ('8', '622c838a09192e77202c0ce88f9504a9', 'Galil AR | Firefight (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.28', null, '1.55', '1.59');
INSERT INTO `betting_steamrobotapiitem` VALUES ('9', '039f708c4744050bd0931c9bad9ff71d', 'Tec-9 | Avalanche (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.45', null, '2.82', '2.84');
INSERT INTO `betting_steamrobotapiitem` VALUES ('10', '5004dd69c9036ad6cadbbe7094692b27', 'StatTrak™ XM1014 | Teclu Burner (Well-Worn)', null, '', null, '', null, '', null, null, null, '', null, null, '2.42', null, '16.59', null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('11', 'b4a0a61f4cc302e082ae87a6f718102a', 'StatTrak™ P90 | Chopper (Minimal Wear)', null, '', null, '', null, '', null, null, null, '', null, null, '2.46', null, '14.67', null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('12', '6e9bda60fc915a1e35e662ebcd216d55', 'CZ75-Auto | Pole Position (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.26', null, '1.57', '1.78');
INSERT INTO `betting_steamrobotapiitem` VALUES ('13', '766dd7265de00b77c87ee906ca879a7f', 'SG 553 | Army Sheen (Minimal Wear)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.16', '0.2');
INSERT INTO `betting_steamrobotapiitem` VALUES ('14', '4ceabd3748bf51b3e7cea4bf0175b473', 'Tec-9 | Cracked Opal (Well-Worn)', null, '', null, '', null, '', null, null, null, '', null, null, '0.07', null, '0.53', '0.59');
INSERT INTO `betting_steamrobotapiitem` VALUES ('15', '4d89a155d54bfebdf62db0a5b251e837', 'Desert Eagle | Heirloom (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.73', null, '4.05', '3.64');
INSERT INTO `betting_steamrobotapiitem` VALUES ('16', '32d77f199c2ba08becad64c8569fd480', 'Nova | Polar Mesh (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.15', '0.2');
INSERT INTO `betting_steamrobotapiitem` VALUES ('17', 'a0307117f38a63e4afdc62996bbcc520', 'Dual Berettas | Cobalt Quartz (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.17', null, '1.03', '1.12');
INSERT INTO `betting_steamrobotapiitem` VALUES ('18', '2ca5a0c1303b4c2bf30bed8b4dd41642', 'MAG-7 | Silver (Factory New)', null, '', null, '', null, '', null, null, null, '', null, null, '0.4', null, '2.56', '2.71');
INSERT INTO `betting_steamrobotapiitem` VALUES ('19', '99ac8c0b9ab77a850d07dace430daa51', 'P90 | Death Grip (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.49', null, '2.63', '3.17');
INSERT INTO `betting_steamrobotapiitem` VALUES ('20', '73d4bc956f25de57fc2704c03b8fa4fa', 'MP7 | Special Delivery (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.45', null, '2.7', '2.78');
INSERT INTO `betting_steamrobotapiitem` VALUES ('21', '147da99a3117afb402b67ae2009a8aac', 'CZ75-Auto | Xiangliu (Factory New)', null, '', null, '', null, '', null, null, null, '', null, null, '5.14', null, '27.54', '33.27');
INSERT INTO `betting_steamrobotapiitem` VALUES ('22', '2f4a79aaecf1756f2ce123f4af94893f', 'Sticker | Sherry', null, '', null, '', null, '', null, null, null, '', null, null, '0.88', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('23', 'd8876741c8f22ac5079f253d69d3056a', 'M4A1-S | Boreal Forest (Well-Worn)', null, '', null, '', null, '', null, null, null, '', null, null, '0.1', null, '0.6', '0.66');
INSERT INTO `betting_steamrobotapiitem` VALUES ('24', 'd66cf84f79ff9e2c9336dd4372da21f6', 'CZ75-Auto | Imprint (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.08', null, '0.56', '0.53');
INSERT INTO `betting_steamrobotapiitem` VALUES ('25', '6d336fa57650a680e3e98d3bcd280fff', 'G3SG1 | Jungle Dashed (Factory New)', null, '', null, '', null, '', null, null, null, '', null, null, '0.08', null, '0.82', '0.6');
INSERT INTO `betting_steamrobotapiitem` VALUES ('26', 'bb577f2699b2237ffe17386be76ea5f0', 'Desert Eagle | Naga (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.47', null, '2.38', '2.45');
INSERT INTO `betting_steamrobotapiitem` VALUES ('27', '8edbc101af810c23d01c881d6031f4b5', 'AK-47 | Elite Build (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.69', null, '4.22', '4.36');
INSERT INTO `betting_steamrobotapiitem` VALUES ('28', '7de6794abbf62e0e319573576c31c591', 'Sawed-Off | Orange DDPAT (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '2.17', null, '13.17', '14.42');
INSERT INTO `betting_steamrobotapiitem` VALUES ('29', 'f1efb28fc6d553fe35c4c387399138e1', 'Autograph Capsule | Team EnVyUs | Cologne 2015', null, '', null, '', null, '', null, null, null, '', null, null, '0.49', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('30', 'e56eee6b0527fbc2971e5a79548ce2ee', 'MAG-7 | Heat (Minimal Wear)', null, '', null, '', null, '', null, null, null, '', null, null, '0.31', null, '1.76', '1.98');
INSERT INTO `betting_steamrobotapiitem` VALUES ('31', '5399d0b06d2a1ac5420c97e7a6e45ff8', 'Galil AR | Rocket Pop (Well-Worn)', null, '', null, '', null, '', null, null, null, '', null, null, '0.13', null, '0.75', '0.79');
INSERT INTO `betting_steamrobotapiitem` VALUES ('32', '52b2af7b70c86209ff0ac0017c3e2569', 'R8 Revolver | Amber Fade (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.46', null, '2.9', '2.78');
INSERT INTO `betting_steamrobotapiitem` VALUES ('33', '421d1e65606bf016ee3c8b3c897a1655', 'Dual Berettas | Urban Shock (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.36', null, '2.02', '2.45');
INSERT INTO `betting_steamrobotapiitem` VALUES ('34', '243e6378914a9c3422443de565b233c2', 'Spectrum Case Key', null, '', null, '', null, '', null, null, null, '', null, null, '2.55', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('35', '3840a8ba3f6840daf722b404653edfcf', 'Galil AR | Tuxedo (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.12', null, '0.72', '0.79');
INSERT INTO `betting_steamrobotapiitem` VALUES ('36', 'f60af8be1debd22f6b6eca2e3dd57a57', 'Operation Hydra Case Key', null, '', null, '', null, '', null, null, null, '', null, null, '2.48', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('37', '08a232f24b3eb63101ee6806fba7828f', 'Spectrum Case', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('38', '8b86267e1574edca46e21a6e90a40e7b', 'SSG 08 | Blue Spruce (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.18', '0.2');
INSERT INTO `betting_steamrobotapiitem` VALUES ('39', 'ead2b52bbe4827cb641fd065decbc180', 'Glove Case', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('40', '20f8b9e4b73ec2830f28a2799c985768', 'Sealed Graffiti | Still Happy (Dust Brown)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, null, null);

-- ----------------------------
-- Table structure for betting_tempgamehash
-- ----------------------------
DROP TABLE IF EXISTS `betting_tempgamehash`;
CREATE TABLE `betting_tempgamehash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(255) NOT NULL,
  `secret` varchar(32) NOT NULL,
  `percentage` double NOT NULL,
  `used` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_tempgamehash
-- ----------------------------

-- ----------------------------
-- Table structure for betting_useramountrecord
-- ----------------------------
DROP TABLE IF EXISTS `betting_useramountrecord`;
CREATE TABLE `betting_useramountrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `amount` double NOT NULL,
  `total_amount` double NOT NULL,
  `reason` varchar(256) DEFAULT NULL,
  `game_id` int(11) NOT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `betting_useramountre_game_id_205b8438_fk_betting_c` (`game_id`),
  KEY `betting_useramountre_steamer_id_a1dbae99_fk_social_au` (`steamer_id`),
  CONSTRAINT `betting_useramountre_game_id_205b8438_fk_betting_c` FOREIGN KEY (`game_id`) REFERENCES `betting_coinflipgame` (`id`),
  CONSTRAINT `betting_useramountre_steamer_id_a1dbae99_fk_social_au` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_useramountrecord
-- ----------------------------

-- ----------------------------
-- Table structure for betting_userprofile
-- ----------------------------
DROP TABLE IF EXISTS `betting_userprofile`;
CREATE TABLE `betting_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `theme` varchar(64) NOT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `steamer_id` (`steamer_id`),
  CONSTRAINT `betting_userprofile_steamer_id_f6f076fb_fk_social_au` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_userprofile
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_social_auth_steamuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_social_auth_steamuser_id` FOREIGN KEY (`user_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('3', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('5', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('24', 'betting', 'announcement');
INSERT INTO `django_content_type` VALUES ('20', 'betting', 'bettingbot');
INSERT INTO `django_content_type` VALUES ('16', 'betting', 'coinflipgame');
INSERT INTO `django_content_type` VALUES ('29', 'betting', 'deposit');
INSERT INTO `django_content_type` VALUES ('25', 'betting', 'giveaway');
INSERT INTO `django_content_type` VALUES ('21', 'betting', 'marketitem');
INSERT INTO `django_content_type` VALUES ('18', 'betting', 'message');
INSERT INTO `django_content_type` VALUES ('27', 'betting', 'propitem');
INSERT INTO `django_content_type` VALUES ('23', 'betting', 'room');
INSERT INTO `django_content_type` VALUES ('28', 'betting', 'sendrecord');
INSERT INTO `django_content_type` VALUES ('19', 'betting', 'siteconfig');
INSERT INTO `django_content_type` VALUES ('26', 'betting', 'steamrobotapiitem');
INSERT INTO `django_content_type` VALUES ('17', 'betting', 'tempgamehash');
INSERT INTO `django_content_type` VALUES ('22', 'betting', 'useramountrecord');
INSERT INTO `django_content_type` VALUES ('15', 'betting', 'userprofile');
INSERT INTO `django_content_type` VALUES ('6', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('2', 'jet', 'bookmark');
INSERT INTO `django_content_type` VALUES ('1', 'jet', 'pinnedapplication');
INSERT INTO `django_content_type` VALUES ('7', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('8', 'sites', 'site');
INSERT INTO `django_content_type` VALUES ('9', 'social_auth', 'steamuser');
INSERT INTO `django_content_type` VALUES ('10', 'social_django', 'association');
INSERT INTO `django_content_type` VALUES ('13', 'social_django', 'code');
INSERT INTO `django_content_type` VALUES ('12', 'social_django', 'nonce');
INSERT INTO `django_content_type` VALUES ('14', 'social_django', 'partial');
INSERT INTO `django_content_type` VALUES ('11', 'social_django', 'usersocialauth');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2017-11-30 03:52:38.801000');
INSERT INTO `django_migrations` VALUES ('2', 'admin', '0001_initial', '2017-11-30 03:52:39.475000');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0002_logentry_remove_auto_add', '2017-11-30 03:52:39.486000');
INSERT INTO `django_migrations` VALUES ('4', 'contenttypes', '0002_remove_content_type_name', '2017-11-30 03:52:39.628000');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0001_initial', '2017-11-30 03:52:41.274000');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2017-11-30 03:52:41.353000');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2017-11-30 03:52:41.364000');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2017-11-30 03:52:41.376000');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2017-11-30 03:52:41.387000');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2017-11-30 03:52:41.390000');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2017-11-30 03:52:41.402000');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0008_alter_user_username_max_length', '2017-11-30 03:52:41.416000');
INSERT INTO `django_migrations` VALUES ('13', 'betting', '0001_initial', '2017-11-30 03:52:45.420000');
INSERT INTO `django_migrations` VALUES ('14', 'jet', '0001_initial', '2017-11-30 03:52:46.202000');
INSERT INTO `django_migrations` VALUES ('15', 'jet', '0002_delete_userdashboardmodule', '2017-11-30 03:52:46.226000');
INSERT INTO `django_migrations` VALUES ('16', 'jet', '0003_userdashboardmodule', '2017-11-30 03:52:46.285000');
INSERT INTO `django_migrations` VALUES ('17', 'jet', '0004_delete_userdashboardmodule', '2017-11-30 03:52:46.327000');
INSERT INTO `django_migrations` VALUES ('18', 'sessions', '0001_initial', '2017-11-30 03:52:46.708000');
INSERT INTO `django_migrations` VALUES ('19', 'sites', '0001_initial', '2017-11-30 03:52:46.860000');
INSERT INTO `django_migrations` VALUES ('20', 'sites', '0002_alter_domain_unique', '2017-11-30 03:52:46.903000');
INSERT INTO `django_migrations` VALUES ('21', 'default', '0001_initial', '2017-11-30 03:52:48.580000');
INSERT INTO `django_migrations` VALUES ('22', 'social_auth', '0001_initial', '2017-11-30 03:52:48.583000');
INSERT INTO `django_migrations` VALUES ('23', 'default', '0002_add_related_name', '2017-11-30 03:52:48.701000');
INSERT INTO `django_migrations` VALUES ('24', 'social_auth', '0002_add_related_name', '2017-11-30 03:52:48.705000');
INSERT INTO `django_migrations` VALUES ('25', 'default', '0003_alter_email_max_length', '2017-11-30 03:52:48.802000');
INSERT INTO `django_migrations` VALUES ('26', 'social_auth', '0003_alter_email_max_length', '2017-11-30 03:52:48.806000');
INSERT INTO `django_migrations` VALUES ('27', 'default', '0004_auto_20160423_0400', '2017-11-30 03:52:48.827000');
INSERT INTO `django_migrations` VALUES ('28', 'social_auth', '0004_auto_20160423_0400', '2017-11-30 03:52:48.832000');
INSERT INTO `django_migrations` VALUES ('29', 'social_auth', '0005_auto_20160727_2333', '2017-11-30 03:52:48.862000');
INSERT INTO `django_migrations` VALUES ('30', 'social_django', '0006_partial', '2017-11-30 03:52:49.171000');
INSERT INTO `django_migrations` VALUES ('31', 'social_django', '0002_add_related_name', '2017-11-30 03:52:49.184000');
INSERT INTO `django_migrations` VALUES ('32', 'social_django', '0003_alter_email_max_length', '2017-11-30 03:52:49.189000');
INSERT INTO `django_migrations` VALUES ('33', 'social_django', '0001_initial', '2017-11-30 03:52:49.193000');
INSERT INTO `django_migrations` VALUES ('34', 'social_django', '0004_auto_20160423_0400', '2017-11-30 03:52:49.198000');
INSERT INTO `django_migrations` VALUES ('35', 'social_django', '0005_auto_20160727_2333', '2017-11-30 03:52:49.202000');
INSERT INTO `django_migrations` VALUES ('36', 'betting', '0002_auto_20171130_1533', '2017-11-30 07:33:24.886000');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('3nio6yzs9192sudcaaf3ugkbaywr45q3', 'NGRlNzM0ZTUwYmU2YmIwYjczYjBmMjU2ZDNhN2Q1ZWE5OTkwMTMzYTp7InNvY2lhbF9hdXRoX2xhc3RfbG9naW5fYmFja2VuZCI6InN0ZWFtIiwib3BlbmlkIjp7fSwiX2F1dGhfdXNlcl9oYXNoIjoiNmMxZmFkMmQ3ZmM5N2U1NGExYjg0ZGNhZjJkYTQ0ZjQ1OGI2ODc0ZSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==', '2017-12-14 07:35:27.764000');
INSERT INTO `django_session` VALUES ('chn16b91287b8aa8709e8904c2b0440c', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 06:16:28.070000');
INSERT INTO `django_session` VALUES ('chn1b0e774d6c9351297d2ce5dae31b1', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 06:16:33.419000');
INSERT INTO `django_session` VALUES ('chn1ca688e9d6ad63538f38c28620310', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:24:18.075000');
INSERT INTO `django_session` VALUES ('chn1e467513d3fc806f21f5f5c2a522e', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 04:01:57.673000');
INSERT INTO `django_session` VALUES ('chn23b9292ebfcc1c4ef356f16eb502b', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:22:32.761000');
INSERT INTO `django_session` VALUES ('chn24582d3644a3e792112f2c3353fbd', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 07:40:26.945000');
INSERT INTO `django_session` VALUES ('chn2b3d6b7a37b0902cfb6b33e074d05', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:55:18.238000');
INSERT INTO `django_session` VALUES ('chn2b5c442dffa78a4b18718860e18dc', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:56:00.623000');
INSERT INTO `django_session` VALUES ('chn2ca5237edd85d2de0cce9c2f678a5', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:40:49.628000');
INSERT INTO `django_session` VALUES ('chn2f3f703419f3d985b950b5599e994', 'NjY2YTE1MmQxMmYzN2U2MThmM2FjMjZhYjNlMTQzMzAzNmE4Mzk1ZTp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-14 06:24:21.216000');
INSERT INTO `django_session` VALUES ('chn3263dfec431f96aaaf1b2977b5030', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:56:04.505000');
INSERT INTO `django_session` VALUES ('chn32c1fa93f9ec66facb044dc94088f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:54:56.789000');
INSERT INTO `django_session` VALUES ('chn348ab466b12ddbc95fd7d0a667907', 'NGFiY2NmOGMxZmY0NTUyYWE1ZjZmMzUxNTViMzc1ZjA1Zjc5YTcyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijk3YTI5ZmJiZWU2ZDY1ZTkwMjAxM2RlMjI3Yzg4MjU0MGZhZTIxMjgiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:30:02.056000');
INSERT INTO `django_session` VALUES ('chn34c297367432793389d8028a30088', 'N2U2YmUwZDYzODMzNzU2ZGE3NTUxY2FiZTRkN2NlYTZmZDJkYTJkZjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijk3YTI5ZmJiZWU2ZDY1ZTkwMjAxM2RlMjI3Yzg4MjU0MGZhZTIxMjgiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-14 06:25:20.465000');
INSERT INTO `django_session` VALUES ('chn37128203b393bdad42a178ab1b695', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:30:33.355000');
INSERT INTO `django_session` VALUES ('chn386308618054b094a74ea060c4a55', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 04:00:53.644000');
INSERT INTO `django_session` VALUES ('chn41434c1fe68197e6d4d62084cbaee', 'NGFiY2NmOGMxZmY0NTUyYWE1ZjZmMzUxNTViMzc1ZjA1Zjc5YTcyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijk3YTI5ZmJiZWU2ZDY1ZTkwMjAxM2RlMjI3Yzg4MjU0MGZhZTIxMjgiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:29:56.257000');
INSERT INTO `django_session` VALUES ('chn4ab1543068bec754cd803d67298f1', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:59:49.620000');
INSERT INTO `django_session` VALUES ('chn546134290aac7275f7cc1b044bb9c', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:55:14.567000');
INSERT INTO `django_session` VALUES ('chn6324eade62db909d35d3bc1fd1523', 'NGFiY2NmOGMxZmY0NTUyYWE1ZjZmMzUxNTViMzc1ZjA1Zjc5YTcyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijk3YTI5ZmJiZWU2ZDY1ZTkwMjAxM2RlMjI3Yzg4MjU0MGZhZTIxMjgiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:27:14.005000');
INSERT INTO `django_session` VALUES ('chn680da9f6ac821dc12170c9a092624', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:41:15.671000');
INSERT INTO `django_session` VALUES ('chn6bd562839dd4f032435ecd66a0df0', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:54:22.809000');
INSERT INTO `django_session` VALUES ('chn70bf85f21d84a9fcad9e2fb087274', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 06:17:03.249000');
INSERT INTO `django_session` VALUES ('chn73513ff7ea715b0a0593db4be91b6', 'NGFiY2NmOGMxZmY0NTUyYWE1ZjZmMzUxNTViMzc1ZjA1Zjc5YTcyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijk3YTI5ZmJiZWU2ZDY1ZTkwMjAxM2RlMjI3Yzg4MjU0MGZhZTIxMjgiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:21:40.196000');
INSERT INTO `django_session` VALUES ('chn76726c28d0407a897de0132569aeb', 'NGFiY2NmOGMxZmY0NTUyYWE1ZjZmMzUxNTViMzc1ZjA1Zjc5YTcyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijk3YTI5ZmJiZWU2ZDY1ZTkwMjAxM2RlMjI3Yzg4MjU0MGZhZTIxMjgiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:41:15.634000');
INSERT INTO `django_session` VALUES ('chn7e7a210d531983a7a8dfa2cb71b0b', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 04:02:44.855000');
INSERT INTO `django_session` VALUES ('chn80d67f6680ebf7b3da0f76fd36a4b', 'N2U2YmUwZDYzODMzNzU2ZGE3NTUxY2FiZTRkN2NlYTZmZDJkYTJkZjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijk3YTI5ZmJiZWU2ZDY1ZTkwMjAxM2RlMjI3Yzg4MjU0MGZhZTIxMjgiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-14 06:21:44.683000');
INSERT INTO `django_session` VALUES ('chn815a8d5c9f943a5929a24d2fae816', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:23:53.284000');
INSERT INTO `django_session` VALUES ('chn8317cc5092e24cf627edb4649257b', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 06:16:46.555000');
INSERT INTO `django_session` VALUES ('chn86fad2dcc3a7fc086b134c88f542b', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 04:02:32.823000');
INSERT INTO `django_session` VALUES ('chn8c5e6dc1fc3f2be1af19971e7dd67', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:55:30.857000');
INSERT INTO `django_session` VALUES ('chn911c0bcd5b7bc437d78dfb14cac2d', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 04:00:21.646000');
INSERT INTO `django_session` VALUES ('chn91582a3a0c4ac2003c7f4388a218a', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:56:42.194000');
INSERT INTO `django_session` VALUES ('chn956ae190e01114fb986da52de6064', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 07:41:37.437000');
INSERT INTO `django_session` VALUES ('chn96431d5c1651156da3685d2a74260', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:26:20.577000');
INSERT INTO `django_session` VALUES ('chn9c013eb4bf1e8ee50ba4559e25dab', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:56:15.251000');
INSERT INTO `django_session` VALUES ('chna1c12e43ada97e9a234512ffcc2a7', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 06:16:41.174000');
INSERT INTO `django_session` VALUES ('chnabf243df9afe03e21c3cf334d9641', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:29:57.428000');
INSERT INTO `django_session` VALUES ('chnb1b2cf4d278ecfdc10c0c16b8ff59', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 04:01:25.639000');
INSERT INTO `django_session` VALUES ('chnbb8fc37411dceaf6dbbd84bf61412', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 06:16:36.919000');
INSERT INTO `django_session` VALUES ('chnbdd8b3175269d879366ca0ce74b5f', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:31:29.010000');
INSERT INTO `django_session` VALUES ('chnbf0c5a608e4a395c8abe003837802', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:08:51.796000');
INSERT INTO `django_session` VALUES ('chncda762d93dc8a0f0844226cad12d7', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 07:40:17.015000');
INSERT INTO `django_session` VALUES ('chnd4e60c650fcc7e9a02469bb1f8c6b', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 04:02:29.351000');
INSERT INTO `django_session` VALUES ('chndb236d46aaad6c11873c089abb7b5', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:55:11.536000');
INSERT INTO `django_session` VALUES ('chndb93e6ca4c9ec5c245630d9f36f63', 'NGFiY2NmOGMxZmY0NTUyYWE1ZjZmMzUxNTViMzc1ZjA1Zjc5YTcyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijk3YTI5ZmJiZWU2ZDY1ZTkwMjAxM2RlMjI3Yzg4MjU0MGZhZTIxMjgiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:40:54.097000');
INSERT INTO `django_session` VALUES ('chndfbdcb9ab092d397ff30e51bb3dcd', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:55:27.854000');
INSERT INTO `django_session` VALUES ('chne3e5cfe6448ae199b970a35dd2a27', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 04:02:37.825000');
INSERT INTO `django_session` VALUES ('chne4d8dc0d75f703899f5e04845015b', 'M2UxZjc3YjlhM2M2YWRhMGE1YjdmOTI2M2Q1OTE2YmY5NjE2NjcyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjZjMWZhZDJkN2ZjOTdlNTRhMWI4NGRjYWYyZGE0NGY0NThiNjg3NGUiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 07:35:31.270000');
INSERT INTO `django_session` VALUES ('chneac27fc7fc08098eae68af366bef0', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 03:53:48.803000');
INSERT INTO `django_session` VALUES ('chnec0ac21d94493d85cbb7f65c8e465', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 04:02:26.288000');
INSERT INTO `django_session` VALUES ('chnec4ad9c63a472ba3537bb8059d927', 'NGFiY2NmOGMxZmY0NTUyYWE1ZjZmMzUxNTViMzc1ZjA1Zjc5YTcyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijk3YTI5ZmJiZWU2ZDY1ZTkwMjAxM2RlMjI3Yzg4MjU0MGZhZTIxMjgiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-14 06:30:33.355000');
INSERT INTO `django_session` VALUES ('chnec7e58f459154f1f7f03f56c31784', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-14 06:16:53.768000');
INSERT INTO `django_session` VALUES ('g5ityqm2hgzp49tk6k5vf1govvcirxfk', 'YWViMWVkMzMzNmQyNTk2Yzk4MDg1MWYxMjE1MmUxZjA0N2QzY2UyYzp7InNvY2lhbF9hdXRoX2xhc3RfbG9naW5fYmFja2VuZCI6InN0ZWFtIiwib3BlbmlkIjp7fSwiX2F1dGhfdXNlcl9oYXNoIjoiOTdhMjlmYmJlZTZkNjVlOTAyMDEzZGUyMjdjODgyNTQwZmFlMjEyOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwiX2F1dGhfdXNlcl9pZCI6IjIifQ==', '2017-12-14 06:21:34.304000');
INSERT INTO `django_session` VALUES ('ig5wlxjkh2veyuvwtor0thmsngbd2lj8', 'NGRlNzM0ZTUwYmU2YmIwYjczYjBmMjU2ZDNhN2Q1ZWE5OTkwMTMzYTp7InNvY2lhbF9hdXRoX2xhc3RfbG9naW5fYmFja2VuZCI6InN0ZWFtIiwib3BlbmlkIjp7fSwiX2F1dGhfdXNlcl9oYXNoIjoiNmMxZmFkMmQ3ZmM5N2U1NGExYjg0ZGNhZjJkYTQ0ZjQ1OGI2ODc0ZSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==', '2017-12-14 06:08:46.770000');

-- ----------------------------
-- Table structure for django_site
-- ----------------------------
DROP TABLE IF EXISTS `django_site`;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_site
-- ----------------------------
INSERT INTO `django_site` VALUES ('1', 'example.com', 'example.com');

-- ----------------------------
-- Table structure for jet_bookmark
-- ----------------------------
DROP TABLE IF EXISTS `jet_bookmark`;
CREATE TABLE `jet_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) NOT NULL,
  `title` varchar(255) NOT NULL,
  `user` int(10) unsigned NOT NULL,
  `date_add` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jet_bookmark
-- ----------------------------

-- ----------------------------
-- Table structure for jet_pinnedapplication
-- ----------------------------
DROP TABLE IF EXISTS `jet_pinnedapplication`;
CREATE TABLE `jet_pinnedapplication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(255) NOT NULL,
  `user` int(10) unsigned NOT NULL,
  `date_add` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jet_pinnedapplication
-- ----------------------------

-- ----------------------------
-- Table structure for social_auth_association
-- ----------------------------
DROP TABLE IF EXISTS `social_auth_association`;
CREATE TABLE `social_auth_association` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `issued` int(11) NOT NULL,
  `lifetime` int(11) NOT NULL,
  `assoc_type` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_association_server_url_handle_078befa2_uniq` (`server_url`,`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_association
-- ----------------------------

-- ----------------------------
-- Table structure for social_auth_code
-- ----------------------------
DROP TABLE IF EXISTS `social_auth_code`;
CREATE TABLE `social_auth_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `code` varchar(32) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_code_email_code_801b2d02_uniq` (`email`,`code`),
  KEY `social_auth_code_code_a2393167` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_code
-- ----------------------------

-- ----------------------------
-- Table structure for social_auth_nonce
-- ----------------------------
DROP TABLE IF EXISTS `social_auth_nonce`;
CREATE TABLE `social_auth_nonce` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `salt` varchar(65) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_nonce_server_url_timestamp_salt_f6284463_uniq` (`server_url`,`timestamp`,`salt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_nonce
-- ----------------------------

-- ----------------------------
-- Table structure for social_auth_partial
-- ----------------------------
DROP TABLE IF EXISTS `social_auth_partial`;
CREATE TABLE `social_auth_partial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL,
  `next_step` smallint(5) unsigned NOT NULL,
  `backend` varchar(32) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_auth_partial_token_3017fea3` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_partial
-- ----------------------------

-- ----------------------------
-- Table structure for social_auth_steamuser
-- ----------------------------
DROP TABLE IF EXISTS `social_auth_steamuser`;
CREATE TABLE `social_auth_steamuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `steamid` varchar(17) NOT NULL,
  `personaname` varchar(255) NOT NULL,
  `profileurl` varchar(300) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `avatarmedium` varchar(255) NOT NULL,
  `avatarfull` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `tradeurl` varchar(300) DEFAULT NULL,
  `level` int(11) NOT NULL,
  `is_cheating` tinyint(1) NOT NULL,
  `can_chat` tinyint(1) NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `steamid` (`steamid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_steamuser
-- ----------------------------
INSERT INTO `social_auth_steamuser` VALUES ('1', '!s7CFvDySHHL5b6TXzpdXOOpXgynXavLDGx8LkVSw', '2017-11-30 07:35:27.759000', '0', '76561198042231205', 'zhouzhouli', 'http://steamcommunity.com/id/zhouzhouli/', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_full.jpg', '', '2017-11-30 06:08:46.683000', '1', '0', 'https://steamcommunity.com/tradeoffer/new/?partner=81965477&token=tOXxzSCE', '1', '0', '1', '0');
INSERT INTO `social_auth_steamuser` VALUES ('2', '!6ecX4bQulPeDBSNq20VF8TFTGRr2rIvSNpQBxS9N', '2017-11-30 06:21:34.300000', '0', '76561198387169533', 'zhouzhou', 'http://steamcommunity.com/profiles/76561198387169533/', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b_full.jpg', '', '2017-11-30 06:21:34.276000', '1', '0', 'https://steamcommunity.com/tradeoffer/new/?partner=426903805&token=1sRlQxa1', '1', '0', '1', '0');

-- ----------------------------
-- Table structure for social_auth_steamuser_groups
-- ----------------------------
DROP TABLE IF EXISTS `social_auth_steamuser_groups`;
CREATE TABLE `social_auth_steamuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steamuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_auth_steamuse_steamuser_id_b0a270ed_fk_social_au` (`steamuser_id`),
  CONSTRAINT `social_auth_steamuse_steamuser_id_b0a270ed_fk_social_au` FOREIGN KEY (`steamuser_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_steamuser_groups
-- ----------------------------

-- ----------------------------
-- Table structure for social_auth_steamuser_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `social_auth_steamuser_user_permissions`;
CREATE TABLE `social_auth_steamuser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steamuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_steamuser_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for social_auth_usersocialauth
-- ----------------------------
DROP TABLE IF EXISTS `social_auth_usersocialauth`;
CREATE TABLE `social_auth_usersocialauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(32) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_usersocialauth_provider_uid_e6b5e668_uniq` (`provider`,`uid`),
  KEY `social_auth_usersoci_user_id_17d28448_fk_social_au` (`user_id`),
  CONSTRAINT `social_auth_usersoci_user_id_17d28448_fk_social_au` FOREIGN KEY (`user_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_usersocialauth
-- ----------------------------
INSERT INTO `social_auth_usersocialauth` VALUES ('1', 'steam', '76561198042231205', '{\"player\": {\"steamid\": \"76561198042231205\", \"primaryclanid\": \"103582791429521408\", \"timecreated\": 1306067183, \"personaname\": \"zhouzhouli\", \"personastate\": 0, \"personastateflags\": 0, \"communityvisibilitystate\": 3, \"loccountrycode\": \"CN\", \"profilestate\": 1, \"profileurl\": \"http://steamcommunity.com/id/zhouzhouli/\", \"loccityid\": 9888, \"avatar\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6.jpg\", \"locstatecode\": \"32\", \"avatarfull\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_full.jpg\", \"avatarmedium\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_medium.jpg\", \"lastlogoff\": 1511486832}, \"auth_time\": 1512027327}', '1');
INSERT INTO `social_auth_usersocialauth` VALUES ('2', 'steam', '76561198387169533', '{\"player\": {\"steamid\": \"76561198387169533\", \"primaryclanid\": \"103582791429521408\", \"timecreated\": 1494053450, \"personaname\": \"zhouzhou\", \"personastate\": 0, \"personastateflags\": 0, \"communityvisibilitystate\": 3, \"profilestate\": 1, \"profileurl\": \"http://steamcommunity.com/profiles/76561198387169533/\", \"avatar\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b.jpg\", \"avatarfull\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b_full.jpg\", \"avatarmedium\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b_medium.jpg\", \"lastlogoff\": 1510890620}, \"auth_time\": 1512022894}', '2');
