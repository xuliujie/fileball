/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 100114
Source Host           : localhost:3306
Source Database       : fancsgo

Target Server Type    : MYSQL
Target Server Version : 100114
File Encoding         : 65001

Date: 2017-11-28 18:40:25
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
INSERT INTO `auth_permission` VALUES ('25', 'Can add user profile', '9', 'add_userprofile');
INSERT INTO `auth_permission` VALUES ('26', 'Can change user profile', '9', 'change_userprofile');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete user profile', '9', 'delete_userprofile');
INSERT INTO `auth_permission` VALUES ('28', 'Can add Games', '10', 'add_coinflipgame');
INSERT INTO `auth_permission` VALUES ('29', 'Can change Games', '10', 'change_coinflipgame');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete Games', '10', 'delete_coinflipgame');
INSERT INTO `auth_permission` VALUES ('31', 'Can add Temp Game Hash', '11', 'add_tempgamehash');
INSERT INTO `auth_permission` VALUES ('32', 'Can change Temp Game Hash', '11', 'change_tempgamehash');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete Temp Game Hash', '11', 'delete_tempgamehash');
INSERT INTO `auth_permission` VALUES ('34', 'Can add message', '12', 'add_message');
INSERT INTO `auth_permission` VALUES ('35', 'Can change message', '12', 'change_message');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete message', '12', 'delete_message');
INSERT INTO `auth_permission` VALUES ('37', 'Can add Site Configs', '13', 'add_siteconfig');
INSERT INTO `auth_permission` VALUES ('38', 'Can change Site Configs', '13', 'change_siteconfig');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete Site Configs', '13', 'delete_siteconfig');
INSERT INTO `auth_permission` VALUES ('40', 'Can add Betting Bots', '14', 'add_bettingbot');
INSERT INTO `auth_permission` VALUES ('41', 'Can change Betting Bots', '14', 'change_bettingbot');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete Betting Bots', '14', 'delete_bettingbot');
INSERT INTO `auth_permission` VALUES ('43', 'Can add market item', '15', 'add_marketitem');
INSERT INTO `auth_permission` VALUES ('44', 'Can change market item', '15', 'change_marketitem');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete market item', '15', 'delete_marketitem');
INSERT INTO `auth_permission` VALUES ('46', 'Can add UserAmountReocrds', '16', 'add_useramountrecord');
INSERT INTO `auth_permission` VALUES ('47', 'Can change UserAmountReocrds', '16', 'change_useramountrecord');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete UserAmountReocrds', '16', 'delete_useramountrecord');
INSERT INTO `auth_permission` VALUES ('49', 'Can add room', '17', 'add_room');
INSERT INTO `auth_permission` VALUES ('50', 'Can change room', '17', 'change_room');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete room', '17', 'delete_room');
INSERT INTO `auth_permission` VALUES ('52', 'Can add Announcements', '18', 'add_announcement');
INSERT INTO `auth_permission` VALUES ('53', 'Can change Announcements', '18', 'change_announcement');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete Announcements', '18', 'delete_announcement');
INSERT INTO `auth_permission` VALUES ('55', 'Can add Give Away', '19', 'add_giveaway');
INSERT INTO `auth_permission` VALUES ('56', 'Can change Give Away', '19', 'change_giveaway');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete Give Away', '19', 'delete_giveaway');
INSERT INTO `auth_permission` VALUES ('58', 'Can add steamrobot api item', '20', 'add_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('59', 'Can change steamrobot api item', '20', 'change_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete steamrobot api item', '20', 'delete_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('61', 'Can add Prop Items', '21', 'add_propitem');
INSERT INTO `auth_permission` VALUES ('62', 'Can change Prop Items', '21', 'change_propitem');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete Prop Items', '21', 'delete_propitem');
INSERT INTO `auth_permission` VALUES ('64', 'Can add Send Records', '22', 'add_sendrecord');
INSERT INTO `auth_permission` VALUES ('65', 'Can change Send Records', '22', 'change_sendrecord');
INSERT INTO `auth_permission` VALUES ('66', 'Can delete Send Records', '22', 'delete_sendrecord');
INSERT INTO `auth_permission` VALUES ('67', 'Can add Deposit', '23', 'add_deposit');
INSERT INTO `auth_permission` VALUES ('68', 'Can change Deposit', '23', 'change_deposit');
INSERT INTO `auth_permission` VALUES ('69', 'Can delete Deposit', '23', 'delete_deposit');
INSERT INTO `auth_permission` VALUES ('70', 'Can add SteamUsers', '24', 'add_steamuser');
INSERT INTO `auth_permission` VALUES ('71', 'Can change SteamUsers', '24', 'change_steamuser');
INSERT INTO `auth_permission` VALUES ('72', 'Can delete SteamUsers', '24', 'delete_steamuser');
INSERT INTO `auth_permission` VALUES ('73', 'Can add association', '25', 'add_association');
INSERT INTO `auth_permission` VALUES ('74', 'Can change association', '25', 'change_association');
INSERT INTO `auth_permission` VALUES ('75', 'Can delete association', '25', 'delete_association');
INSERT INTO `auth_permission` VALUES ('76', 'Can add user social auth', '26', 'add_usersocialauth');
INSERT INTO `auth_permission` VALUES ('77', 'Can change user social auth', '26', 'change_usersocialauth');
INSERT INTO `auth_permission` VALUES ('78', 'Can delete user social auth', '26', 'delete_usersocialauth');
INSERT INTO `auth_permission` VALUES ('79', 'Can add nonce', '27', 'add_nonce');
INSERT INTO `auth_permission` VALUES ('80', 'Can change nonce', '27', 'change_nonce');
INSERT INTO `auth_permission` VALUES ('81', 'Can delete nonce', '27', 'delete_nonce');
INSERT INTO `auth_permission` VALUES ('82', 'Can add code', '28', 'add_code');
INSERT INTO `auth_permission` VALUES ('83', 'Can change code', '28', 'change_code');
INSERT INTO `auth_permission` VALUES ('84', 'Can delete code', '28', 'delete_code');
INSERT INTO `auth_permission` VALUES ('85', 'Can add partial', '29', 'add_partial');
INSERT INTO `auth_permission` VALUES ('86', 'Can change partial', '29', 'change_partial');
INSERT INTO `auth_permission` VALUES ('87', 'Can delete partial', '29', 'delete_partial');

-- ----------------------------
-- Table structure for betting_announcement
-- ----------------------------
DROP TABLE IF EXISTS `betting_announcement`;
CREATE TABLE `betting_announcement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `page_type` smallint(6) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_coinflipgame
-- ----------------------------
INSERT INTO `betting_coinflipgame` VALUES ('1', 'ae457f70d36411e7b6bde03f497cc42f', '2017-11-27 11:18:23.207000', '2017-11-27 11:18:23.207000', 'b13d1b85a30e6f1e7122f7a69e7a1c07', 'YDBYFUZVZT', '40.9407529519083', '1', null, '0', '0', '0', '0', '2017-11-27 11:18:23.206000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('2', 'd25cb161d3de11e7b3b1e03f497cc42f', '2017-11-28 01:52:42.358000', '2017-11-28 01:52:42.358000', '4a163548ad6ffd0a2327d143d140ae16', 'CYRSSYZLFO', '50.4770127206947', '0', null, '0', '0', '0', '-1', '2017-11-28 01:52:42.358000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('3', 'e5ac1530d3de11e7b71ae03f497cc42f', '2017-11-28 01:53:14.755000', '2017-11-28 01:53:14.755000', 'edf66ecd8b450f48e8fdabac1ca57ea6', 'ERVKLPWXBI', '11.3635597501377', '0', null, '0', '0', '0', '-1', '2017-11-28 01:53:14.755000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('4', '3de735e1d3df11e7be9be03f497cc42f', '2017-11-28 01:55:42.782000', '2017-11-28 01:55:42.782000', 'cfcb25954aebe544cab3b333cdc13f1d', 'PNYGBCIEJX', '32.2067554221191', '0', null, '0', '0', '0', '-1', '2017-11-28 01:55:42.782000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('5', '75ed45f0d41711e7bc86e03f497cc42f', '2017-11-28 08:38:08.591000', '2017-11-28 08:38:08.591000', '9f0fa1090ef7ee2e6e8a1f0144633f23', 'FRYRMWJRZO', '57.7739971689674', '0', null, '0', '0', '0', '-1', '2017-11-28 08:38:08.591000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('6', 'd6648e21d41711e7a127e03f497cc42f', '2017-11-28 08:40:50.434000', '2017-11-28 08:40:50.434000', '322fd006ee1e92a3c5ef1b1a48f24acf', 'RTQFITSXYC', '69.1183147162082', '0', null, '0', '0', '0', '-1', '2017-11-28 08:40:50.433000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('7', 'e47e2c9ed41711e7a947e03f497cc42f', '2017-11-28 08:41:14.090000', '2017-11-28 08:41:14.090000', '3fdd8ef80c7e8ec3f37002b1bf539255', 'IPCWYMZYBR', '66.0083933517019', '0', null, '0', '0', '0', '-1', '2017-11-28 08:41:14.090000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('8', '32d3e29ed41811e7b914e03f497cc42f', '2017-11-28 08:43:25.514000', '2017-11-28 08:43:25.514000', '525fd38c72d08ad6c12eae0fcc83c59c', 'ECPKIAMYEH', '84.472877379413', '0', null, '0', '0', '0', '-1', '2017-11-28 08:43:25.514000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('9', '5e0e7980d41811e7892fe03f497cc42f', '2017-11-28 08:44:38.041000', '2017-11-28 08:44:38.041000', 'b9f597268a1088124cf5f3d2ad0c33f1', 'JQOTALAWSZ', '92.3291819779465', '0', null, '0', '0', '0', '-1', '2017-11-28 08:44:38.040000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('10', '99b132c0d41811e7ad93e03f497cc42f', '2017-11-28 08:46:18.093000', '2017-11-28 08:46:18.093000', '0ede3bf029acd370e41fa89da9e5e762', 'VLQCULBMFV', '96.2876095645059', '0', null, '0', '0', '0', '-1', '2017-11-28 08:46:18.092000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('11', 'e1d7f65ed41811e7875be03f497cc42f', '2017-11-28 08:48:19.142000', '2017-11-28 08:48:19.142000', '81f3cd644c717394e64835ec4876542b', 'VQLAZPNRDP', '18.7187239177377', '1', null, '0', '0', '0', '-1', '2017-11-28 08:48:19.142000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('12', 'f3bb2000d41811e79dd8e03f497cc42f', '2017-11-28 08:48:49.153000', '2017-11-28 08:51:28.874000', '405a85a478233dfb1c427477ed768c27', 'SDGOKBPJLA', '40.6350951562554', '0', null, '19.3', '2', '1929', '-1', '2017-11-28 08:48:49.152000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('13', 'fd8a438fd41811e7b0e7e03f497cc42f', '2017-11-28 08:49:05.609000', '2017-11-28 08:49:32.241000', 'b61421d64a2fde9a6b92c9554d976deb', 'UJAVYLDFIC', '45.2764004227789', '0', null, '8.98', '1', '898', '-1', '2017-11-28 08:49:05.609000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('14', '58ffcec0d41911e7afd3e03f497cc42f', '2017-11-28 08:51:39.052000', '2017-11-28 08:51:52.727000', 'cba153ba29952f48b5bcc2036ee98c1a', 'NXYTOSCWXD', '82.5903363616433', '0', null, '9.92', '1', '992', '-1', '2017-11-28 08:51:39.052000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('15', '01a099b0d41a11e7be36e03f497cc42f', '2017-11-28 08:56:21.964000', '2017-11-28 10:32:31.032000', '18039d1ef1ee985c35796c3e86c2dbb4', 'ZZAMKUPWWI', '92.1846746269032', '1', null, '19.19', '2', '1918', '-1', '2017-11-28 08:56:21.963000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('16', '6dc5176ed41e11e7ad47e03f497cc42f', '2017-11-28 09:28:01.383000', '2017-11-28 09:38:54.549000', '3cd2fd63aebd59bf078609acfc644d66', 'LLDYHWLMWE', '90.8338957004917', '0', null, '19.35', '2', '1935', '-1', '2017-11-28 09:28:01.382000', '6', '0');
INSERT INTO `betting_coinflipgame` VALUES ('17', '0b96c911d42111e7a354e03f497cc42f', '2017-11-28 09:46:45.153000', '2017-11-28 10:27:48.581000', '1f1927a33cd122b669c6b99e82fd958b', 'UUHPZGMUSX', '79.383422355596', '0', null, '18.7', '2', '1870', '-1', '2017-11-28 09:46:45.152000', '6', '0');
INSERT INTO `betting_coinflipgame` VALUES ('18', '27eb890fd42711e788e9e03f497cc42f', '2017-11-28 10:30:29.665000', '2017-11-28 10:30:43.773000', 'af6bff7e7e2b77fc5ba37225b178961f', 'EARHJYCRCA', '55.715124109824', '0', null, '19.6', '2', '1960', '-1', '2017-11-28 10:30:29.665000', '2', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_deposit
-- ----------------------------
INSERT INTO `betting_deposit` VALUES ('1', 'd66689f0d41711e7a411e03f497cc42f', '2017-11-28 08:40:50.447000', '2017-11-28 08:40:50.447000', '0', '0', '0', '0', '19.54', '0', '1', 'O5INH8C3', null, null, '-1', '-1', '6', '1');
INSERT INTO `betting_deposit` VALUES ('2', 'ef4e6c80d41711e7bb0ae03f497cc42f', '2017-11-28 08:41:32.232000', '2017-11-28 08:41:32.232000', '0', '0', '0', '0', '19.71', '0', '1', 'T61M858T', null, null, '-1', '-1', '7', '1');
INSERT INTO `betting_deposit` VALUES ('3', '32d7da40d41811e7879fe03f497cc42f', '2017-11-28 08:43:25.540000', '2017-11-28 08:43:25.540000', '0', '0', '0', '0', '19.65', '0', '1', 'Y7JWNXV5', null, null, '-1', '-1', '8', '1');
INSERT INTO `betting_deposit` VALUES ('4', '5e11add1d41811e7a4e6e03f497cc42f', '2017-11-28 08:44:38.061000', '2017-11-28 08:44:38.061000', '0', '0', '0', '0', '19.71', '0', '1', '2KM6UIVQ', null, null, '-1', '-1', '9', '1');
INSERT INTO `betting_deposit` VALUES ('5', '99b37cb0d41811e79850e03f497cc42f', '2017-11-28 08:46:18.107000', '2017-11-28 08:47:12.146000', '0', '0', '0', '0', '19.46', '0', '1', 'OKBCGM8A', '2102296394', null, '-1', '-1', '10', '1');
INSERT INTO `betting_deposit` VALUES ('6', 'f3c0290fd41811e78df0e03f497cc42f', '2017-11-28 08:48:49.185000', '2017-11-28 08:51:30.187000', '0', '0', '0', '0', '19.3', '1', '20', '7O34IK87', '2102296394', '2017-11-28 08:51:28.877000', '1', '1929', '12', '1');
INSERT INTO `betting_deposit` VALUES ('7', 'fd8d29c0d41811e79ac5e03f497cc42f', '2017-11-28 08:49:05.628000', '2017-11-28 08:51:28.817000', '0', '0', '0', '0', '8.98', '1', '20', '0OW8JLJY', '2102296395', '2017-11-28 08:51:28.808000', '1', '898', '13', '1');
INSERT INTO `betting_deposit` VALUES ('8', '5904d7cfd41911e7bfb8e03f497cc42f', '2017-11-28 08:51:39.085000', '2017-11-28 08:51:52.717000', '0', '0', '0', '0', '9.92', '1', '20', 'UBIRGDVT', '2102296394', '2017-11-28 08:51:52.694000', '1', '992', '14', '1');
INSERT INTO `betting_deposit` VALUES ('9', '6dca6e9ed41e11e79fc6e03f497cc42f', '2017-11-28 09:28:01.418000', '2017-11-28 09:28:14.798000', '0', '0', '0', '0', '19.35', '1', '20', 'KJEJ5AL9', '2102296394', '2017-11-28 09:28:14.719000', '1', '1935', '16', '1');
INSERT INTO `betting_deposit` VALUES ('10', '0b9eb84fd42111e7a319e03f497cc42f', '2017-11-28 09:46:45.205000', '2017-11-28 09:47:02.054000', '0', '0', '0', '0', '18.7', '1', '20', '5LM6915W', '2102296395', '2017-11-28 09:47:02.025000', '1', '1870', '17', '1');
INSERT INTO `betting_deposit` VALUES ('11', '27efced1d42711e781b6e03f497cc42f', '2017-11-28 10:30:29.693000', '2017-11-28 10:30:43.762000', '0', '0', '0', '0', '19.6', '1', '20', '6BA13J72', '2102296394', '2017-11-28 10:30:43.735000', '1', '1960', '18', '1');
INSERT INTO `betting_deposit` VALUES ('12', '6844775ed42711e7be5ce03f497cc42f', '2017-11-28 10:32:17.622000', '2017-11-28 10:32:31.022000', '0', '0', '0', '1', '19.19', '1', '20', 'MW2LTG60', '2102296394', '2017-11-28 10:32:30.992000', '1', '1918', '15', '1');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_message
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_propitem
-- ----------------------------
INSERT INTO `betting_propitem` VALUES ('1', '99b4670fd41811e7b037e03f497cc42f', '2017-11-28 08:46:18.114000', '2017-11-28 08:46:18.117000', '12272881485', 'Autograph Capsule | Team Kinguin | Cologne 2015', 'Autograph Capsule | Team Kinguin | Cologne 2015', 'Autograph Capsule | Team Kinguin | Cologne 2015', '9.74', 'Base Grade', 'b0c3d9', null, '12272881485', '730', '1208229347', '2', '143865972', '5', null);
INSERT INTO `betting_propitem` VALUES ('2', '99b59f8fd41811e7b349e03f497cc42f', '2017-11-28 08:46:18.121000', '2017-11-28 08:46:18.124000', '12259762035', 'Galil AR | Tuxedo', 'Galil AR | Tuxedo (Field-Tested)', 'Galil AR | Tuxedo (Field-Tested)', '9.72', 'Mil-Spec Grade', '4b69ff', 'Field-Tested', '12259762035', '730', '469446099', '2', '302028390', '5', null);
INSERT INTO `betting_propitem` VALUES ('3', 'f3c447c0d41811e788c1e03f497cc42f', '2017-11-28 08:48:49.212000', '2017-11-28 08:51:28.936000', '12359791220', 'MAG-7 | Silver', 'MAG-7 | Silver (Factory New)', 'MAG-7 | Silver (Factory New)', '9.77', 'Industrial Grade', '5e98d9', 'Factory New', '112359791220', '730', '519982666', '2', '480085569', '6', null);
INSERT INTO `betting_propitem` VALUES ('4', 'f3c58040d41811e7abe3e03f497cc42f', '2017-11-28 08:48:49.220000', '2017-11-28 08:51:28.957000', '12359791563', 'Tec-9 | Bamboo Forest', 'Tec-9 | Bamboo Forest (Field-Tested)', 'Tec-9 | Bamboo Forest (Field-Tested)', '9.53', 'Consumer Grade', 'b0c3d9', 'Field-Tested', '112359791563', '730', '992089234', '2', '519977179', '6', null);
INSERT INTO `betting_propitem` VALUES ('5', 'fd92a800d41811e78bc2e03f497cc42f', '2017-11-28 08:49:05.664000', '2017-11-28 08:51:28.814000', '12359791154', 'P90 | Death Grip', 'P90 | Death Grip (Field-Tested)', 'P90 | Death Grip (Field-Tested)', '8.98', 'Restricted', '8847ff', 'Field-Tested', '112359791154', '730', '2316441441', '2', '188530139', '7', null);
INSERT INTO `betting_propitem` VALUES ('6', '590dd880d41911e783dae03f497cc42f', '2017-11-28 08:51:39.144000', '2017-11-28 08:51:52.701000', '12359791437', 'MAG-7 | Silver', 'MAG-7 | Silver (Factory New)', 'MAG-7 | Silver (Factory New)', '9.92', 'Industrial Grade', '5e98d9', 'Factory New', '112359791437', '730', '519982666', '2', '480085569', '8', null);
INSERT INTO `betting_propitem` VALUES ('7', '6dce181ed41e11e7a6c2e03f497cc42f', '2017-11-28 09:28:01.443000', '2017-11-28 09:28:14.729000', '12272881676', 'Dual Berettas | Urban Shock', 'Dual Berettas | Urban Shock (Field-Tested)', 'Dual Berettas | Urban Shock (Field-Tested)', '9.77', 'Restricted', '8847ff', 'Field-Tested', '112272881676', '730', '720301092', '2', '188530139', '9', null);
INSERT INTO `betting_propitem` VALUES ('8', '6dd20fc0d41e11e7b416e03f497cc42f', '2017-11-28 09:28:01.468000', '2017-11-28 09:28:14.752000', '12447285440', 'Galil AR | Firefight', 'Galil AR | Firefight (Field-Tested)', 'Galil AR | Firefight (Field-Tested)', '9.58', 'Restricted', '8847ff', 'Field-Tested', '112447285440', '730', '1703084157', '2', '188530139', '9', null);
INSERT INTO `betting_propitem` VALUES ('9', '0ba213b0d42111e7b1dbe03f497cc42f', '2017-11-28 09:46:45.227000', '2017-11-28 09:47:02.031000', '12272881493', 'Autograph Capsule | Team Kinguin | Cologne 2015', 'Autograph Capsule | Team Kinguin | Cologne 2015', 'Autograph Capsule | Team Kinguin | Cologne 2015', '9.37', 'Base Grade', 'b0c3d9', null, '112272881493', '730', '1208229347', '2', '143865972', '10', null);
INSERT INTO `betting_propitem` VALUES ('10', '0ba4d2cfd42111e79387e03f497cc42f', '2017-11-28 09:46:45.245000', '2017-11-28 09:47:02.037000', '12359791376', 'MAG-7 | Silver', 'MAG-7 | Silver (Factory New)', 'MAG-7 | Silver (Factory New)', '9.33', 'Industrial Grade', '5e98d9', 'Factory New', '112359791376', '730', '519982666', '2', '302028390', '10', null);
INSERT INTO `betting_propitem` VALUES ('11', '27f39f5ed42711e7a891e03f497cc42f', '2017-11-28 10:30:29.718000', '2017-11-28 10:30:43.741000', '12359791563', 'Tec-9 | Bamboo Forest', 'Tec-9 | Bamboo Forest (Field-Tested)', 'Tec-9 | Bamboo Forest (Field-Tested)', '9.82', 'Consumer Grade', 'b0c3d9', 'Field-Tested', '112359791563', '730', '992089234', '2', '519977179', '11', null);
INSERT INTO `betting_propitem` VALUES ('12', '27f748e1d42711e7b378e03f497cc42f', '2017-11-28 10:30:29.742000', '2017-11-28 10:30:43.747000', '12359791172', 'MAG-7 | Silver', 'MAG-7 | Silver (Factory New)', 'MAG-7 | Silver (Factory New)', '9.78', 'Industrial Grade', '5e98d9', 'Factory New', '112359791172', '730', '519982666', '2', '519977179', '11', null);
INSERT INTO `betting_propitem` VALUES ('13', '6848960fd42711e78ae3e03f497cc42f', '2017-11-28 10:32:17.649000', '2017-11-28 10:32:31.000000', '10869306748', 'Music Kit | Daniel Sadowski, The 8-Bit Kit', 'Music Kit | Daniel Sadowski, The 8-Bit Kit', 'Music Kit | Daniel Sadowski, The 8-Bit Kit', '9.7', 'High Grade', '4b69ff', null, '110869306748', '730', '1325773219', '2', '143865972', '12', null);
INSERT INTO `betting_propitem` VALUES ('14', '6849ce91d42711e7aa2ee03f497cc42f', '2017-11-28 10:32:17.657000', '2017-11-28 10:32:31.007000', '12272881493', 'Autograph Capsule | Team Kinguin | Cologne 2015', 'Autograph Capsule | Team Kinguin | Cologne 2015', 'Autograph Capsule | Team Kinguin | Cologne 2015', '9.49', 'Base Grade', 'b0c3d9', null, '112272881493', '730', '1208229347', '2', '143865972', '12', null);

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
  `steamer_id` int(11) NOT NULL,
  `game_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `betting_sendrecord_steamer_id_8a54c2ad_fk_social_au` (`steamer_id`),
  KEY `betting_sendrecord_game_id_8b8e2252_fk_betting_coinflipgame_id` (`game_id`),
  CONSTRAINT `betting_sendrecord_game_id_8b8e2252_fk_betting_coinflipgame_id` FOREIGN KEY (`game_id`) REFERENCES `betting_coinflipgame` (`id`),
  CONSTRAINT `betting_sendrecord_steamer_id_8a54c2ad_fk_social_au` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_sendrecord
-- ----------------------------

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5` (`md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_steamrobotapiitem
-- ----------------------------

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
INSERT INTO `django_content_type` VALUES ('18', 'betting', 'announcement');
INSERT INTO `django_content_type` VALUES ('14', 'betting', 'bettingbot');
INSERT INTO `django_content_type` VALUES ('10', 'betting', 'coinflipgame');
INSERT INTO `django_content_type` VALUES ('23', 'betting', 'deposit');
INSERT INTO `django_content_type` VALUES ('19', 'betting', 'giveaway');
INSERT INTO `django_content_type` VALUES ('15', 'betting', 'marketitem');
INSERT INTO `django_content_type` VALUES ('12', 'betting', 'message');
INSERT INTO `django_content_type` VALUES ('21', 'betting', 'propitem');
INSERT INTO `django_content_type` VALUES ('17', 'betting', 'room');
INSERT INTO `django_content_type` VALUES ('22', 'betting', 'sendrecord');
INSERT INTO `django_content_type` VALUES ('13', 'betting', 'siteconfig');
INSERT INTO `django_content_type` VALUES ('20', 'betting', 'steamrobotapiitem');
INSERT INTO `django_content_type` VALUES ('11', 'betting', 'tempgamehash');
INSERT INTO `django_content_type` VALUES ('16', 'betting', 'useramountrecord');
INSERT INTO `django_content_type` VALUES ('9', 'betting', 'userprofile');
INSERT INTO `django_content_type` VALUES ('6', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('2', 'jet', 'bookmark');
INSERT INTO `django_content_type` VALUES ('1', 'jet', 'pinnedapplication');
INSERT INTO `django_content_type` VALUES ('7', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('8', 'sites', 'site');
INSERT INTO `django_content_type` VALUES ('24', 'social_auth', 'steamuser');
INSERT INTO `django_content_type` VALUES ('25', 'social_django', 'association');
INSERT INTO `django_content_type` VALUES ('28', 'social_django', 'code');
INSERT INTO `django_content_type` VALUES ('27', 'social_django', 'nonce');
INSERT INTO `django_content_type` VALUES ('29', 'social_django', 'partial');
INSERT INTO `django_content_type` VALUES ('26', 'social_django', 'usersocialauth');

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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2017-11-27 09:26:55.246000');
INSERT INTO `django_migrations` VALUES ('2', 'admin', '0001_initial', '2017-11-27 09:26:55.815000');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0002_logentry_remove_auto_add', '2017-11-27 09:26:55.824000');
INSERT INTO `django_migrations` VALUES ('4', 'contenttypes', '0002_remove_content_type_name', '2017-11-27 09:26:55.963000');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0001_initial', '2017-11-27 09:26:57.474000');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2017-11-27 09:26:57.562000');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2017-11-27 09:26:57.572000');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2017-11-27 09:26:57.583000');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2017-11-27 09:26:57.593000');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2017-11-27 09:26:57.596000');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2017-11-27 09:26:57.607000');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0008_alter_user_username_max_length', '2017-11-27 09:26:57.617000');
INSERT INTO `django_migrations` VALUES ('13', 'betting', '0001_initial', '2017-11-27 09:27:01.110000');
INSERT INTO `django_migrations` VALUES ('14', 'jet', '0001_initial', '2017-11-27 09:27:01.508000');
INSERT INTO `django_migrations` VALUES ('15', 'jet', '0002_delete_userdashboardmodule', '2017-11-27 09:27:01.535000');
INSERT INTO `django_migrations` VALUES ('16', 'jet', '0003_userdashboardmodule', '2017-11-27 09:27:01.592000');
INSERT INTO `django_migrations` VALUES ('17', 'jet', '0004_delete_userdashboardmodule', '2017-11-27 09:27:01.623000');
INSERT INTO `django_migrations` VALUES ('18', 'sessions', '0001_initial', '2017-11-27 09:27:01.958000');
INSERT INTO `django_migrations` VALUES ('19', 'sites', '0001_initial', '2017-11-27 09:27:02.106000');
INSERT INTO `django_migrations` VALUES ('20', 'sites', '0002_alter_domain_unique', '2017-11-27 09:27:02.137000');
INSERT INTO `django_migrations` VALUES ('21', 'default', '0001_initial', '2017-11-27 09:27:03.378000');
INSERT INTO `django_migrations` VALUES ('22', 'social_auth', '0001_initial', '2017-11-27 09:27:03.382000');
INSERT INTO `django_migrations` VALUES ('23', 'default', '0002_add_related_name', '2017-11-27 09:27:03.511000');
INSERT INTO `django_migrations` VALUES ('24', 'social_auth', '0002_add_related_name', '2017-11-27 09:27:03.515000');
INSERT INTO `django_migrations` VALUES ('25', 'default', '0003_alter_email_max_length', '2017-11-27 09:27:03.648000');
INSERT INTO `django_migrations` VALUES ('26', 'social_auth', '0003_alter_email_max_length', '2017-11-27 09:27:03.652000');
INSERT INTO `django_migrations` VALUES ('27', 'default', '0004_auto_20160423_0400', '2017-11-27 09:27:03.674000');
INSERT INTO `django_migrations` VALUES ('28', 'social_auth', '0004_auto_20160423_0400', '2017-11-27 09:27:03.678000');
INSERT INTO `django_migrations` VALUES ('29', 'social_auth', '0005_auto_20160727_2333', '2017-11-27 09:27:03.710000');
INSERT INTO `django_migrations` VALUES ('30', 'social_django', '0006_partial', '2017-11-27 09:27:03.955000');
INSERT INTO `django_migrations` VALUES ('31', 'social_django', '0002_add_related_name', '2017-11-27 09:27:03.964000');
INSERT INTO `django_migrations` VALUES ('32', 'social_django', '0003_alter_email_max_length', '2017-11-27 09:27:03.969000');
INSERT INTO `django_migrations` VALUES ('33', 'social_django', '0001_initial', '2017-11-27 09:27:03.976000');
INSERT INTO `django_migrations` VALUES ('34', 'social_django', '0004_auto_20160423_0400', '2017-11-27 09:27:03.981000');
INSERT INTO `django_migrations` VALUES ('35', 'social_django', '0005_auto_20160727_2333', '2017-11-27 09:27:03.986000');
INSERT INTO `django_migrations` VALUES ('36', 'betting', '0002_auto_20171128_1645', '2017-11-28 08:46:02.267000');
INSERT INTO `django_migrations` VALUES ('37', 'betting', '0003_sendrecord_game', '2017-11-28 10:29:24.038000');

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
INSERT INTO `django_session` VALUES ('chn06e4245a0153b6881eba2872e6048', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:34:41.317000');
INSERT INTO `django_session` VALUES ('chn0a81a2c694cae6cd82f287676e5ec', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 01:55:05.069000');
INSERT INTO `django_session` VALUES ('chn0cf5980819717700ee8ad13a533c3', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:31:51.349000');
INSERT INTO `django_session` VALUES ('chn0dbaeb01ba51677a202a75af2cafd', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:27:15.466000');
INSERT INTO `django_session` VALUES ('chn183de3aacfdcacaa17712ee525917', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 01:52:13.155000');
INSERT INTO `django_session` VALUES ('chn1c76bf54b387d2798963ad31edb06', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:47:02.962000');
INSERT INTO `django_session` VALUES ('chn1e2b1a5a9faff005e73f033edf6ca', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:27:51.441000');
INSERT INTO `django_session` VALUES ('chn220d03d9729d85a89780db3f19ec4', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:47:06.407000');
INSERT INTO `django_session` VALUES ('chn295079c1b9bfd8fd05142afb2b057', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:29:51.960000');
INSERT INTO `django_session` VALUES ('chn295c32aa7392d296f8cfa15b850c6', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:40:41.822000');
INSERT INTO `django_session` VALUES ('chn2f9a2bbeee0c067ad4ceba1a4f04c', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:54:15.797000');
INSERT INTO `django_session` VALUES ('chn302f0bfa898d5c45130798bcb4d74', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 01:48:59.882000');
INSERT INTO `django_session` VALUES ('chn307615458d9d0723fabc64bd2a3fd', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:09:25.302000');
INSERT INTO `django_session` VALUES ('chn31d6f964a07e0dc020836c8d2f630', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:51:34.290000');
INSERT INTO `django_session` VALUES ('chn34deafcd0e0feb9cd8e9d08ac6f29', 'M2NmZGNjYTdlOGQ1MzM2ZWZjNWI2Y2YwMjYxNjllZWQ3MDE4ZWZlZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-12 10:35:39.507000');
INSERT INTO `django_session` VALUES ('chn34e17a0b9803559e46239c1b51bce', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:30:26.240000');
INSERT INTO `django_session` VALUES ('chn3558aaf185ae70f3d147968048950', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:56:22.527000');
INSERT INTO `django_session` VALUES ('chn3645e326e33b5e392b91ab1a6ef6c', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:28:31.503000');
INSERT INTO `django_session` VALUES ('chn36545dc23eaaceba1423e22dabde9', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:21:08.765000');
INSERT INTO `django_session` VALUES ('chn368f0c1c692ff66ba1403356ea18c', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:05:06.060000');
INSERT INTO `django_session` VALUES ('chn3863097cc0a4eea4452848415dad4', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:47:27.171000');
INSERT INTO `django_session` VALUES ('chn38b6111b94b5ea0e2d0cc15171da6', 'M2NmZGNjYTdlOGQ1MzM2ZWZjNWI2Y2YwMjYxNjllZWQ3MDE4ZWZlZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-12 10:39:52.522000');
INSERT INTO `django_session` VALUES ('chn38deefafc97bdaa4f579cb53cb1fc', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:05:22.782000');
INSERT INTO `django_session` VALUES ('chn3a8663c0f4983b5853bf83a5040b2', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:51:32.122000');
INSERT INTO `django_session` VALUES ('chn3db06ec44c006aa88b9cd10504a5f', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:43:02.659000');
INSERT INTO `django_session` VALUES ('chn3fe78758ea20d66451e1b9fcad852', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 01:51:00.032000');
INSERT INTO `django_session` VALUES ('chn40dc78f3370c0e18e1bd4f6700746', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:53:31.879000');
INSERT INTO `django_session` VALUES ('chn41e820953e65d7aa8d71c3c6dfe2e', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:47:06.313000');
INSERT INTO `django_session` VALUES ('chn426a40c84e19fe7ca62ea364943e8', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:46:10.448000');
INSERT INTO `django_session` VALUES ('chn470bdc8f074f8ccafb4c6c64ae583', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:02:48.460000');
INSERT INTO `django_session` VALUES ('chn4b032078bba6f5e5f8bfb3260d379', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:35:05.006000');
INSERT INTO `django_session` VALUES ('chn4b043826e8c263f71a6198f9e06ce', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:31:57.458000');
INSERT INTO `django_session` VALUES ('chn4d2eb0892d318a781c01bce9fac2b', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:03:38.795000');
INSERT INTO `django_session` VALUES ('chn4ecbbb2a9bcfc11c6c830a11a8bfc', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:39:52.706000');
INSERT INTO `django_session` VALUES ('chn509077fb465cff1a20d846431687f', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:49:31.889000');
INSERT INTO `django_session` VALUES ('chn5ac00acd16d05378044cc4799fc16', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:47:01.892000');
INSERT INTO `django_session` VALUES ('chn5ed9b636047f21aa4457de12c9383', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:51:32.121000');
INSERT INTO `django_session` VALUES ('chn65c38137f30d4b2c8b6453518c1df', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:49:00.199000');
INSERT INTO `django_session` VALUES ('chn69c6341689562afda586857f67f98', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:27:56.279000');
INSERT INTO `django_session` VALUES ('chn71eca0ffff4946b977bcbd935168d', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:44:33.508000');
INSERT INTO `django_session` VALUES ('chn72a80b85403828ce2d9d10a9f65cb', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:55:43.551000');
INSERT INTO `django_session` VALUES ('chn7677d2f694a1a4ce5a6bc1dde9690', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 01:38:22.833000');
INSERT INTO `django_session` VALUES ('chn7ee2ddb812e07dff7fc81e1ccd752', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:31:49.719000');
INSERT INTO `django_session` VALUES ('chn7f6332cf7d7688667afa19a3d80b2', 'M2NmZGNjYTdlOGQ1MzM2ZWZjNWI2Y2YwMjYxNjllZWQ3MDE4ZWZlZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-12 10:36:37.679000');
INSERT INTO `django_session` VALUES ('chn7fa5d8f4298aced65daa9e4055031', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:26:09.319000');
INSERT INTO `django_session` VALUES ('chn8249ed3f8aa1c9d0cde90e3853834', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:17:31.542000');
INSERT INTO `django_session` VALUES ('chn86cde68e1b77812f07812c6b0e8d3', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:02:34.198000');
INSERT INTO `django_session` VALUES ('chn8a4ece63dee310e5932342cf80d5d', 'M2NmZGNjYTdlOGQ1MzM2ZWZjNWI2Y2YwMjYxNjllZWQ3MDE4ZWZlZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-12 10:37:54.592000');
INSERT INTO `django_session` VALUES ('chn8c278cdbaa80b8a184b060f1d91cb', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 01:48:45.470000');
INSERT INTO `django_session` VALUES ('chn8cf2b5bb03726969cec6b12c9c944', 'M2NmZGNjYTdlOGQ1MzM2ZWZjNWI2Y2YwMjYxNjllZWQ3MDE4ZWZlZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-12 10:39:59.318000');
INSERT INTO `django_session` VALUES ('chn8f639ce7c06c44e6c8c79d6aa2334', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:46:55.360000');
INSERT INTO `django_session` VALUES ('chna0b5a5b2df4c61dfca06219b78872', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:17:28.703000');
INSERT INTO `django_session` VALUES ('chna1c0556bdbc9ac03abbbbbc0e281c', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:48:42.739000');
INSERT INTO `django_session` VALUES ('chna6e00405eda26699f2d088e463b78', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:10:27.209000');
INSERT INTO `django_session` VALUES ('chnb4cf0334d9d020009417a325b5b6f', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:26:09.215000');
INSERT INTO `django_session` VALUES ('chnb4dcf4d9262eb25cf2c870da6d16a', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 01:45:17.245000');
INSERT INTO `django_session` VALUES ('chnb4ece63d776356ceec0fc74200588', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:49:31.803000');
INSERT INTO `django_session` VALUES ('chnb8c24d5d717f87c835ed9d4a17309', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:19:36.135000');
INSERT INTO `django_session` VALUES ('chnb8c4ba29df3aa91c654cb01a409b3', 'M2NmZGNjYTdlOGQ1MzM2ZWZjNWI2Y2YwMjYxNjllZWQ3MDE4ZWZlZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-12 10:36:23.010000');
INSERT INTO `django_session` VALUES ('chnb9c95bfd65a511dad443c7ea7637e', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:56:44.458000');
INSERT INTO `django_session` VALUES ('chnbc31b71822c23147b498df0657068', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:38:26.287000');
INSERT INTO `django_session` VALUES ('chnbdf1bc83aed649d03ad9743ea8f36', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:35:40.879000');
INSERT INTO `django_session` VALUES ('chnbffcaf8d20ad938f1f39ec2803ddc', 'M2NmZGNjYTdlOGQ1MzM2ZWZjNWI2Y2YwMjYxNjllZWQ3MDE4ZWZlZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-12 10:32:06.314000');
INSERT INTO `django_session` VALUES ('chnc36dd5eb34d094a849b31dfb036b8', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:11:32.174000');
INSERT INTO `django_session` VALUES ('chnc59a5d7632d5ef7d70faa304b2fcb', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:37:48.826000');
INSERT INTO `django_session` VALUES ('chnc679330fdb872cbd260a054111b2d', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:40:46.327000');
INSERT INTO `django_session` VALUES ('chnc69fd052380c12f60101b8ebb3316', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:37:45.895000');
INSERT INTO `django_session` VALUES ('chnc8cb5e7b307080589a91e0c77de3d', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:29:48.519000');
INSERT INTO `django_session` VALUES ('chnc9cb3057cd1b8092140186a0610f9', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:27:17.278000');
INSERT INTO `django_session` VALUES ('chnd21344fad625464c13727c174426e', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:29:47.771000');
INSERT INTO `django_session` VALUES ('chnd233700d3eecf9156551846df2061', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:56:04.299000');
INSERT INTO `django_session` VALUES ('chnd2f453a28ac2b30cb26e2b92cd0be', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:46:14.480000');
INSERT INTO `django_session` VALUES ('chnd33e4feaa5670169b31e47dd7111d', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:56:42.911000');
INSERT INTO `django_session` VALUES ('chnd72985cc77880eec17584bd10ff3d', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 01:45:31.567000');
INSERT INTO `django_session` VALUES ('chnd84ce00fa52f4a896cb437e343109', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:28:16.950000');
INSERT INTO `django_session` VALUES ('chnda69de04768843d9b1c48a5c7cc41', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:43:20.583000');
INSERT INTO `django_session` VALUES ('chnda8b301b2b6c05d0c6662ac6cda6e', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:57:00.727000');
INSERT INTO `django_session` VALUES ('chndbf594e36bbea9a85df0089f4ca25', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:46:09.747000');
INSERT INTO `django_session` VALUES ('chndd3b757b312991951d38da158571e', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:43:07.109000');
INSERT INTO `django_session` VALUES ('chnddd4deeca6a78740cfa4f4b8c2b46', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:05:01.530000');
INSERT INTO `django_session` VALUES ('chnde121385dcb74117a55ef086a2cba', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:48:19.708000');
INSERT INTO `django_session` VALUES ('chne20bd2dfc84552849abf6457c0076', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:46:56.458000');
INSERT INTO `django_session` VALUES ('chne3edf0285154b14b7699b049283e7', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:44:34.868000');
INSERT INTO `django_session` VALUES ('chne641e3b2605d2cb364cd77ecabff2', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 10:28:31.313000');
INSERT INTO `django_session` VALUES ('chne856c3b57bfb49b7d170c9625313c', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:20:13.312000');
INSERT INTO `django_session` VALUES ('chnea0a3d298e05914d67a7a7ee97fae', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:56:23.457000');
INSERT INTO `django_session` VALUES ('chneaa7dc167e9e1a37c51c6c03f7372', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:30:06.729000');
INSERT INTO `django_session` VALUES ('chnf103c8f8fca0dbfe63edd4a2114b4', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:27:56.509000');
INSERT INTO `django_session` VALUES ('chnf2e00c28e014442380f0717845cbd', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:55:44.476000');
INSERT INTO `django_session` VALUES ('chnf4c7dfd4bd1061ab83854ad65dbef', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:27:14.508000');
INSERT INTO `django_session` VALUES ('chnf5e30e41cd512644e1c5019e2b795', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:26:30.554000');
INSERT INTO `django_session` VALUES ('chnf6035c334f554c955864604a5f602', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:26:12.040000');
INSERT INTO `django_session` VALUES ('chnf782b05e39b18fcb6aaa9b5737c0d', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:26:30.665000');
INSERT INTO `django_session` VALUES ('chnf83bb1027a173dfc2de710f86c42f', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:56:46.493000');
INSERT INTO `django_session` VALUES ('chnf9cf05fdd850c3984a6f9457e16a9', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 09:27:55.418000');
INSERT INTO `django_session` VALUES ('chnffb11df64fa3a6ec4a1cbc9b6ba7a', 'Mzc0NGQ4MzQzOTUzM2JmYjEzNWFmNjQyMWRiMzUyZTE4ZmZmNDNlZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImZkZDdjMWY5MWY4N2Y0YzlkZWJmM2QzZGIyZmRmYzc1YjVhMDE4OWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-12 08:44:31.946000');
INSERT INTO `django_session` VALUES ('eor0ryqemftzpwt3vumwdam8nnvo4zub', 'MjdhM2YyYzg0MDI4MzBhMDc5MmQxMmYxMDhmYjdlYWM4MjEwM2Q3Yzp7InNvY2lhbF9hdXRoX2xhc3RfbG9naW5fYmFja2VuZCI6InN0ZWFtIiwib3BlbmlkIjp7fSwiX2F1dGhfdXNlcl9oYXNoIjoiZmRkN2MxZjkxZjg3ZjRjOWRlYmYzZDNkYjJmZGZjNzViNWEwMTg5YiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==', '2017-12-12 08:34:40.106000');
INSERT INTO `django_session` VALUES ('g89pcwq2kle6nnw78xci6qvkvqsixnhm', 'MjdhM2YyYzg0MDI4MzBhMDc5MmQxMmYxMDhmYjdlYWM4MjEwM2Q3Yzp7InNvY2lhbF9hdXRoX2xhc3RfbG9naW5fYmFja2VuZCI6InN0ZWFtIiwib3BlbmlkIjp7fSwiX2F1dGhfdXNlcl9oYXNoIjoiZmRkN2MxZjkxZjg3ZjRjOWRlYmYzZDNkYjJmZGZjNzViNWEwMTg5YiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==', '2017-12-12 01:38:18.966000');
INSERT INTO `django_session` VALUES ('gvp6e9ez2bof5lsfcb1n54qm4uc7u0ir', 'MjdhM2YyYzg0MDI4MzBhMDc5MmQxMmYxMDhmYjdlYWM4MjEwM2Q3Yzp7InNvY2lhbF9hdXRoX2xhc3RfbG9naW5fYmFja2VuZCI6InN0ZWFtIiwib3BlbmlkIjp7fSwiX2F1dGhfdXNlcl9oYXNoIjoiZmRkN2MxZjkxZjg3ZjRjOWRlYmYzZDNkYjJmZGZjNzViNWEwMTg5YiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==', '2017-12-12 08:30:03.029000');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_steamuser
-- ----------------------------
INSERT INTO `social_auth_steamuser` VALUES ('1', '!HB6akd5e6xIp5nez0597SIEcE23NyaYcoquP0gSQ', '2017-11-28 08:34:40.102000', '0', '76561198042231205', 'zhouzhouli', 'http://steamcommunity.com/id/zhouzhouli/', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_full.jpg', '', '2017-11-28 01:38:18.919000', '1', '0', 'https://steamcommunity.com/tradeoffer/new/?partner=81965477&token=tOXxzSCE', '1', '0', '1', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_usersocialauth
-- ----------------------------
INSERT INTO `social_auth_usersocialauth` VALUES ('1', 'steam', '76561198042231205', '{\"player\": {\"steamid\": \"76561198042231205\", \"primaryclanid\": \"103582791429521408\", \"timecreated\": 1306067183, \"personaname\": \"zhouzhouli\", \"personastate\": 0, \"personastateflags\": 0, \"communityvisibilitystate\": 3, \"loccountrycode\": \"CN\", \"profilestate\": 1, \"profileurl\": \"http://steamcommunity.com/id/zhouzhouli/\", \"loccityid\": 9888, \"avatar\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6.jpg\", \"locstatecode\": \"32\", \"avatarfull\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_full.jpg\", \"avatarmedium\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_medium.jpg\", \"lastlogoff\": 1511486832}, \"auth_time\": 1511858080}', '1');
