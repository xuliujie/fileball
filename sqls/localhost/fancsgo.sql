/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 100210
Source Host           : localhost:3306
Source Database       : fancsgo

Target Server Type    : MYSQL
Target Server Version : 100210
File Encoding         : 65001

Date: 2017-12-02 18:29:52
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
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;

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
INSERT INTO `auth_permission` VALUES ('88', 'Can add Promotion', '30', 'add_promotion');
INSERT INTO `auth_permission` VALUES ('89', 'Can change Promotion', '30', 'change_promotion');
INSERT INTO `auth_permission` VALUES ('90', 'Can delete Promotion', '30', 'delete_promotion');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_coinflipgame
-- ----------------------------
INSERT INTO `betting_coinflipgame` VALUES ('9', '9875379ed74a11e7bff8f0795969d36d', '2017-12-02 10:21:44.346000', '2017-12-02 10:21:44.346000', '51cf18b31daa5b531df88e8b85b1d15e', 'NZGNHSSBFK', '76.984014324002', '1', null, '0', '0', '0', '-1', '2017-12-02 10:21:44.346000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('10', 'cc1fb030d74a11e7bc85f0795969d36d', '2017-12-02 10:23:11.028000', '2017-12-02 10:23:11.028000', 'f3c8344b390af9eade43dec1b10c4215', 'VENHAGRFRY', '13.8937677390439', '1', null, '0', '0', '0', '-1', '2017-12-02 10:23:11.027000', '2', '0');
INSERT INTO `betting_coinflipgame` VALUES ('11', 'd21c6f00d74a11e78259f0795969d36d', '2017-12-02 10:23:21.072000', '2017-12-02 10:28:14.864000', '7b3c539ee81e2c715fb2649e50a594ea', 'GXAXQJHWTG', '64.8671388515589', '0', null, '34.99', '4', '3498', '2269', '2017-12-02 10:28:14.864000', '11', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_deposit
-- ----------------------------
INSERT INTO `betting_deposit` VALUES ('14', 'd21f2e1ed74a11e79137f0795969d36d', '2017-12-02 10:23:21.090000', '2017-12-02 10:28:14.851000', '0', '0', '0', '0', '17.34', '1', '20', 'THS6J6WO', '2102296394', '2017-12-02 10:23:34.497000', '1', '1734', '11', '2');
INSERT INTO `betting_deposit` VALUES ('15', '78bf952ed74b11e78407f0795969d36d', '2017-12-02 10:28:00.643000', '2017-12-02 10:28:14.856000', '1', '0', '0', '0', '17.65', '1', '20', 'EWS0I768', '2102296394', '2017-12-02 10:28:14.803000', '1735', '3498', '11', '1');

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
-- Table structure for betting_promotion
-- ----------------------------
DROP TABLE IF EXISTS `betting_promotion`;
CREATE TABLE `betting_promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pointed` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `ref_id` int(11) NOT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `steamer_id` (`steamer_id`),
  KEY `betting_promotion_ref_id_c50fbad3_fk_social_auth_steamuser_id` (`ref_id`),
  CONSTRAINT `betting_promotion_ref_id_c50fbad3_fk_social_auth_steamuser_id` FOREIGN KEY (`ref_id`) REFERENCES `social_auth_steamuser` (`id`),
  CONSTRAINT `betting_promotion_steamer_id_1053a647_fk_social_au` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_promotion
-- ----------------------------
INSERT INTO `betting_promotion` VALUES ('1', '1', '2017-12-02 10:01:50.249000', '2017-12-02 10:15:34.488000', '1', '2');

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_propitem
-- ----------------------------
INSERT INTO `betting_propitem` VALUES ('27', 'd2203f8fd74a11e7ba62f0795969d36d', '2017-12-02 10:23:21.097000', '2017-12-02 10:28:14.913000', '11875811527', 'Glock-18 | Groundwater', 'Glock-18 | Groundwater (Minimal Wear)', 'Glock-18 | Groundwater (Minimal Wear)', '8.75', 'Industrial Grade', '5e98d9', 'Minimal Wear', '111875811527', '730', '310779514', '2', '0', '14', '2');
INSERT INTO `betting_propitem` VALUES ('28', 'd2215100d74a11e78829f0795969d36d', '2017-12-02 10:23:21.104000', '2017-12-02 10:28:14.908000', '10527407651', 'Negev | Army Sheen', 'Negev | Army Sheen (Minimal Wear)', 'Negev | Army Sheen (Minimal Wear)', '8.59', 'Consumer Grade', 'b0c3d9', 'Minimal Wear', '110527407651', '730', '469445126', '2', '302028390', '14', '2');
INSERT INTO `betting_propitem` VALUES ('29', '78c142e1d74b11e79667f0795969d36d', '2017-12-02 10:28:00.654000', '2017-12-02 10:28:14.911000', '12350115720', 'CZ75-Auto | Imprint', 'CZ75-Auto | Imprint (Battle-Scarred)', 'CZ75-Auto | Imprint (Battle-Scarred)', '8.83', 'Mil-Spec Grade', '4b69ff', 'Battle-Scarred', '112350115720', '730', '1934423929', '2', '188530139', '15', '2');
INSERT INTO `betting_propitem` VALUES ('30', '78c22d40d74b11e791cff0795969d36d', '2017-12-02 10:28:00.660000', '2017-12-02 10:28:14.906000', '12272882032', 'Autograph Capsule | Team EnVyUs | Cologne 2015', 'Autograph Capsule | Team EnVyUs | Cologne 2015', 'Autograph Capsule | Team EnVyUs | Cologne 2015', '8.82', 'Base Grade', 'b0c3d9', null, '112272882032', '730', '1208229336', '2', '143865972', '15', '2');

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
  `bot_msg` longtext DEFAULT NULL,
  `trade_ts` datetime(6) NOT NULL,
  `game_id` int(11) DEFAULT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `betting_sendrecord_game_id_8b8e2252_fk_betting_coinflipgame_id` (`game_id`),
  KEY `betting_sendrecord_steamer_id_8a54c2ad_fk_social_au` (`steamer_id`),
  CONSTRAINT `betting_sendrecord_game_id_8b8e2252_fk_betting_coinflipgame_id` FOREIGN KEY (`game_id`) REFERENCES `betting_coinflipgame` (`id`),
  CONSTRAINT `betting_sendrecord_steamer_id_8a54c2ad_fk_social_au` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_sendrecord
-- ----------------------------
INSERT INTO `betting_sendrecord` VALUES ('2', '813f7c70d74b11e7ac1df0795969d36d', '2017-12-02 10:28:14.903000', '2017-12-02 10:28:21.509000', '0', '0', 'M12OMJTE', '4233252111', '0', '', '2017-12-02 10:28:14.903000', '11', '1');

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
  `item_refer_igxe_steam_price` double DEFAULT NULL,
  `item_refer_igxe_price` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5` (`md5`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_steamrobotapiitem
-- ----------------------------
INSERT INTO `betting_steamrobotapiitem` VALUES ('1', 'd8876741c8f22ac5079f253d69d3056a', 'M4A1-S | Boreal Forest (Well-Worn)', null, '', null, '', null, '', null, null, null, '', null, null, '0.09', null, '0.66', '0.6');
INSERT INTO `betting_steamrobotapiitem` VALUES ('2', '6d336fa57650a680e3e98d3bcd280fff', 'G3SG1 | Jungle Dashed (Factory New)', null, '', null, '', null, '', null, null, null, '', null, null, '0.08', null, '0.6', '0.82');
INSERT INTO `betting_steamrobotapiitem` VALUES ('3', 'c17d536edd30cf687b74cb59b109799e', 'PP-Bizon | Urban Dashed (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.2', '0.15');
INSERT INTO `betting_steamrobotapiitem` VALUES ('4', '680dc0c124b69ae6312ea3fc02746228', 'StatTrak™ Tec-9 | Sandstorm (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.18', null, null, '1.39');
INSERT INTO `betting_steamrobotapiitem` VALUES ('5', 'd6e0d59c28657d1412df07e406d9a044', 'SCAR-20 | Contractor (Minimal Wear)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.2', '0.18');
INSERT INTO `betting_steamrobotapiitem` VALUES ('6', '6bd5995764b0d5b880d32270d9fe7f42', 'Glock-18 | Groundwater (Minimal Wear)', null, '', null, '', null, '', null, null, null, '', null, null, '1.44', null, '9.72', '11.84');
INSERT INTO `betting_steamrobotapiitem` VALUES ('7', 'cb1569c689f7fa76e3b4af4b412ac194', 'Tec-9 | Army Mesh (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.2', '0.14');
INSERT INTO `betting_steamrobotapiitem` VALUES ('8', 'c2e4e3a080e5d21d92ff1a85b0b56831', 'G3SG1 | Desert Storm (Well-Worn)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.2', '0.16');
INSERT INTO `betting_steamrobotapiitem` VALUES ('9', '2041fe1ab45ac5944281038b2e890e46', 'Sealed Graffiti | Popdog (Desert Amber)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('10', '72041c83b05b8784c1504a31f0f75825', 'Music Kit | Daniel Sadowski, The 8-Bit Kit', null, '', null, '', null, '', null, null, null, '', null, null, '2.89', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('11', '5eb034af64a1f7af9aec02d72b8024e0', 'Negev | Army Sheen (Minimal Wear)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.2', '0.14');
INSERT INTO `betting_steamrobotapiitem` VALUES ('12', '32d8ba78af8adeca8efc60c7abae0aeb', 'Five-SeveN | Forest Night (Minimal Wear)', null, '', null, '', null, '', null, null, null, '', null, null, '0.03', null, '0.26', '0.22');
INSERT INTO `betting_steamrobotapiitem` VALUES ('13', 'e8db87f8f952837438e289595fd88078', 'SSG 08 | Blue Spruce (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.2', '0.16');
INSERT INTO `betting_steamrobotapiitem` VALUES ('14', 'e26b9ca8658dcd5474be5ad8c0c03d97', 'Tec-9 | Bamboo Forest (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.05', null, '0.4', '0.42');
INSERT INTO `betting_steamrobotapiitem` VALUES ('15', 'fd74bd68a680093394cee14de93d1b35', 'SCAR-20 | Sand Mesh (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.2', '0.14');
INSERT INTO `betting_steamrobotapiitem` VALUES ('16', '219ff71fa2fb635b4607ce213cd38091', 'Glock-18 | Brass (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '1.76', null, '11.64', '10.72');
INSERT INTO `betting_steamrobotapiitem` VALUES ('17', '622c838a09192e77202c0ce88f9504a9', 'Galil AR | Firefight (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.25', null, '1.72', '1.55');
INSERT INTO `betting_steamrobotapiitem` VALUES ('18', '039f708c4744050bd0931c9bad9ff71d', 'Tec-9 | Avalanche (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.46', null, '3.04', '2.84');
INSERT INTO `betting_steamrobotapiitem` VALUES ('19', '5004dd69c9036ad6cadbbe7094692b27', 'StatTrak™ XM1014 | Teclu Burner (Well-Worn)', null, '', null, '', null, '', null, null, null, '', null, null, '2.42', null, null, '16.59');
INSERT INTO `betting_steamrobotapiitem` VALUES ('20', 'b4a0a61f4cc302e082ae87a6f718102a', 'StatTrak™ P90 | Chopper (Minimal Wear)', null, '', null, '', null, '', null, null, null, '', null, null, '2.4', null, null, '14.67');
INSERT INTO `betting_steamrobotapiitem` VALUES ('21', '6e9bda60fc915a1e35e662ebcd216d55', 'CZ75-Auto | Pole Position (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.27', null, '1.79', '1.55');
INSERT INTO `betting_steamrobotapiitem` VALUES ('22', '766dd7265de00b77c87ee906ca879a7f', 'SG 553 | Army Sheen (Minimal Wear)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.2', '0.16');
INSERT INTO `betting_steamrobotapiitem` VALUES ('23', '4ceabd3748bf51b3e7cea4bf0175b473', 'Tec-9 | Cracked Opal (Well-Worn)', null, '', null, '', null, '', null, null, null, '', null, null, '0.07', null, '0.6', '0.55');
INSERT INTO `betting_steamrobotapiitem` VALUES ('24', '4d89a155d54bfebdf62db0a5b251e837', 'Desert Eagle | Heirloom (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.58', null, '4.1', '4.07');
INSERT INTO `betting_steamrobotapiitem` VALUES ('25', '32d77f199c2ba08becad64c8569fd480', 'Nova | Polar Mesh (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.2', '0.15');
INSERT INTO `betting_steamrobotapiitem` VALUES ('26', 'a0307117f38a63e4afdc62996bbcc520', 'Dual Berettas | Cobalt Quartz (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.15', null, '1.06', '1.02');
INSERT INTO `betting_steamrobotapiitem` VALUES ('27', '2ca5a0c1303b4c2bf30bed8b4dd41642', 'MAG-7 | Silver (Factory New)', null, '', null, '', null, '', null, null, null, '', null, null, '0.4', null, '2.85', '2.39');
INSERT INTO `betting_steamrobotapiitem` VALUES ('28', '99ac8c0b9ab77a850d07dace430daa51', 'P90 | Death Grip (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.47', null, '3.18', '2.79');
INSERT INTO `betting_steamrobotapiitem` VALUES ('29', '73d4bc956f25de57fc2704c03b8fa4fa', 'MP7 | Special Delivery (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.47', null, '3.24', '2.76');
INSERT INTO `betting_steamrobotapiitem` VALUES ('30', '147da99a3117afb402b67ae2009a8aac', 'CZ75-Auto | Xiangliu (Factory New)', null, '', null, '', null, '', null, null, null, '', null, null, '4.88', null, '35', '29.69');
INSERT INTO `betting_steamrobotapiitem` VALUES ('31', '2f4a79aaecf1756f2ce123f4af94893f', 'Sticker | Sherry', null, '', null, '', null, '', null, null, null, '', null, null, '0.88', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('32', 'd66cf84f79ff9e2c9336dd4372da21f6', 'CZ75-Auto | Imprint (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.08', null, '0.6', '0.55');
INSERT INTO `betting_steamrobotapiitem` VALUES ('33', 'bb577f2699b2237ffe17386be76ea5f0', 'Desert Eagle | Naga (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.38', null, '2.65', '2.19');
INSERT INTO `betting_steamrobotapiitem` VALUES ('34', '8edbc101af810c23d01c881d6031f4b5', 'AK-47 | Elite Build (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.67', null, '4.63', '4.31');
INSERT INTO `betting_steamrobotapiitem` VALUES ('35', '7de6794abbf62e0e319573576c31c591', 'Sawed-Off | Orange DDPAT (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '2.21', null, '15.28', '13.46');
INSERT INTO `betting_steamrobotapiitem` VALUES ('36', 'f1efb28fc6d553fe35c4c387399138e1', 'Autograph Capsule | Team EnVyUs | Cologne 2015', null, '', null, '', null, '', null, null, null, '', null, null, '0.59', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('37', 'e56eee6b0527fbc2971e5a79548ce2ee', 'MAG-7 | Heat (Minimal Wear)', null, '', null, '', null, '', null, null, null, '', null, null, '0.29', null, '2.12', '1.75');
INSERT INTO `betting_steamrobotapiitem` VALUES ('38', 'd64c587989055a4e0bf0dd220d49e36a', 'Autograph Capsule | Team Kinguin | Cologne 2015', null, '', null, '', null, '', null, null, null, '', null, null, '0.58', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('39', '5399d0b06d2a1ac5420c97e7a6e45ff8', 'Galil AR | Rocket Pop (Well-Worn)', null, '', null, '', null, '', null, null, null, '', null, null, '0.11', null, '0.86', '0.75');
INSERT INTO `betting_steamrobotapiitem` VALUES ('40', '52b2af7b70c86209ff0ac0017c3e2569', 'R8 Revolver | Amber Fade (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.42', null, '2.71', '2.87');
INSERT INTO `betting_steamrobotapiitem` VALUES ('41', '421d1e65606bf016ee3c8b3c897a1655', 'Dual Berettas | Urban Shock (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.4', null, '2.78', '2.24');
INSERT INTO `betting_steamrobotapiitem` VALUES ('42', '243e6378914a9c3422443de565b233c2', 'Spectrum Case Key', null, '', null, '', null, '', null, null, null, '', null, null, '2.45', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('43', '3840a8ba3f6840daf722b404653edfcf', 'Galil AR | Tuxedo (Field-Tested)', null, '', null, '', null, '', null, null, null, '', null, null, '0.11', null, '0.79', '0.7');
INSERT INTO `betting_steamrobotapiitem` VALUES ('44', 'f60af8be1debd22f6b6eca2e3dd57a57', 'Operation Hydra Case Key', null, '', null, '', null, '', null, null, null, '', null, null, '2.39', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('45', '08a232f24b3eb63101ee6806fba7828f', 'Spectrum Case', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('46', '8b86267e1574edca46e21a6e90a40e7b', 'SSG 08 | Blue Spruce (Battle-Scarred)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, '0.2', '0.18');
INSERT INTO `betting_steamrobotapiitem` VALUES ('47', 'ead2b52bbe4827cb641fd065decbc180', 'Glove Case', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, null, null);
INSERT INTO `betting_steamrobotapiitem` VALUES ('48', '20f8b9e4b73ec2830f28a2799c985768', 'Sealed Graffiti | Still Happy (Dust Brown)', null, '', null, '', null, '', null, null, null, '', null, null, '0.02', null, null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_useramountrecord
-- ----------------------------
INSERT INTO `betting_useramountrecord` VALUES ('6', '813bd2f0d74b11e79a04f0795969d36d', '2017-12-02 10:28:14.879000', '2017-12-02 10:28:14.879000', '-17.34', '-72.56', '失敗', '11', '2');
INSERT INTO `betting_useramountrecord` VALUES ('7', '813e9211d74b11e79129f0795969d36d', '2017-12-02 10:28:14.897000', '2017-12-02 10:28:14.897000', '17.34', '55.01', '勝利', '11', '1');

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
  `object_id` longtext DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

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
INSERT INTO `django_content_type` VALUES ('30', 'betting', 'promotion');
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2017-12-02 09:14:45.576000');
INSERT INTO `django_migrations` VALUES ('2', 'admin', '0001_initial', '2017-12-02 09:14:45.707000');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0002_logentry_remove_auto_add', '2017-12-02 09:14:45.714000');
INSERT INTO `django_migrations` VALUES ('4', 'contenttypes', '0002_remove_content_type_name', '2017-12-02 09:14:45.799000');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0001_initial', '2017-12-02 09:14:46.093000');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2017-12-02 09:14:46.148000');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2017-12-02 09:14:46.155000');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2017-12-02 09:14:46.163000');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2017-12-02 09:14:46.170000');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2017-12-02 09:14:46.172000');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2017-12-02 09:14:46.179000');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0008_alter_user_username_max_length', '2017-12-02 09:14:46.187000');
INSERT INTO `django_migrations` VALUES ('13', 'betting', '0001_initial', '2017-12-02 09:14:47.529000');
INSERT INTO `django_migrations` VALUES ('14', 'jet', '0001_initial', '2017-12-02 09:14:47.623000');
INSERT INTO `django_migrations` VALUES ('15', 'jet', '0002_delete_userdashboardmodule', '2017-12-02 09:14:47.640000');
INSERT INTO `django_migrations` VALUES ('16', 'sessions', '0001_initial', '2017-12-02 09:14:47.688000');
INSERT INTO `django_migrations` VALUES ('17', 'sites', '0001_initial', '2017-12-02 09:14:47.718000');
INSERT INTO `django_migrations` VALUES ('18', 'sites', '0002_alter_domain_unique', '2017-12-02 09:14:47.736000');
INSERT INTO `django_migrations` VALUES ('19', 'default', '0001_initial', '2017-12-02 09:14:48.025000');
INSERT INTO `django_migrations` VALUES ('20', 'social_auth', '0001_initial', '2017-12-02 09:14:48.027000');
INSERT INTO `django_migrations` VALUES ('21', 'default', '0002_add_related_name', '2017-12-02 09:14:48.092000');
INSERT INTO `django_migrations` VALUES ('22', 'social_auth', '0002_add_related_name', '2017-12-02 09:14:48.095000');
INSERT INTO `django_migrations` VALUES ('23', 'default', '0003_alter_email_max_length', '2017-12-02 09:14:48.143000');
INSERT INTO `django_migrations` VALUES ('24', 'social_auth', '0003_alter_email_max_length', '2017-12-02 09:14:48.146000');
INSERT INTO `django_migrations` VALUES ('25', 'default', '0004_auto_20160423_0400', '2017-12-02 09:14:48.162000');
INSERT INTO `django_migrations` VALUES ('26', 'social_auth', '0004_auto_20160423_0400', '2017-12-02 09:14:48.165000');
INSERT INTO `django_migrations` VALUES ('27', 'social_auth', '0005_auto_20160727_2333', '2017-12-02 09:14:48.182000');
INSERT INTO `django_migrations` VALUES ('28', 'social_django', '0006_partial', '2017-12-02 09:14:48.228000');
INSERT INTO `django_migrations` VALUES ('29', 'social_django', '0002_add_related_name', '2017-12-02 09:14:48.232000');
INSERT INTO `django_migrations` VALUES ('30', 'social_django', '0003_alter_email_max_length', '2017-12-02 09:14:48.235000');
INSERT INTO `django_migrations` VALUES ('31', 'social_django', '0001_initial', '2017-12-02 09:14:48.237000');
INSERT INTO `django_migrations` VALUES ('32', 'social_django', '0004_auto_20160423_0400', '2017-12-02 09:14:48.240000');
INSERT INTO `django_migrations` VALUES ('33', 'social_django', '0005_auto_20160727_2333', '2017-12-02 09:14:48.243000');

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
INSERT INTO `django_session` VALUES ('5e31dnc9uqpy2qxj41avdabds3rix2zw', 'Y2YxYjlmNTNkOTA2YjkwYjhjM2RlZTc5YmRlMThjZDVmYjViZGIwYTp7InJlZl9jb2RlIjoiRkJTV09JWkciLCJfYXV0aF91c2VyX2lkIjoiMiIsIm9wZW5pZCI6e30sInNvY2lhbF9hdXRoX2xhc3RfbG9naW5fYmFja2VuZCI6InN0ZWFtIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoic29jaWFsX2NvcmUuYmFja2VuZHMuc3RlYW0uU3RlYW1PcGVuSWQiLCJfYXV0aF91c2VyX2hhc2giOiJlODA1NjllZDhhNzlkZGJmMzQ2NzM2MzNlOThhMTJjMzcwOWI1OTdhIn0=', '2017-12-16 10:01:50.144000');
INSERT INTO `django_session` VALUES ('chn0014c88cd220c2a734ea441774bce', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:27:50.690000');
INSERT INTO `django_session` VALUES ('chn02c7752d3ba4f7cb47a230173924e', 'NTIyN2RlNGIxM2FjMzM5NjcxZGExNDJmZTMxYjQ2NDE4NDlmYWQwMTp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIn0=', '2017-12-16 09:58:28.098000');
INSERT INTO `django_session` VALUES ('chn03247c707b72081b7b716e823b2ac', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:32:57.721000');
INSERT INTO `django_session` VALUES ('chn03939ffb8359372ef079c7d176bc2', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:21:47.623000');
INSERT INTO `django_session` VALUES ('chn06351356e955ea9b3d4427a23add3', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:02:26.351000');
INSERT INTO `django_session` VALUES ('chn06f9a4a0bb5c8949038de99068021', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:27:17.272000');
INSERT INTO `django_session` VALUES ('chn06fc4f5546aec67a68117b4f6955a', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:29:09.212000');
INSERT INTO `django_session` VALUES ('chn09aeb81c86a1b2ce1e4950ad10bec', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:50:27.749000');
INSERT INTO `django_session` VALUES ('chn0e9ae3bd3b0fe27cc699059d5e7ca', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:42:52.707000');
INSERT INTO `django_session` VALUES ('chn10799582ea4fa4674b7a308981cb5', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:38:12.733000');
INSERT INTO `django_session` VALUES ('chn10e4c52fc509a23a7bcb09183fe18', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:37:37.732000');
INSERT INTO `django_session` VALUES ('chn11be2afbd290e212b0336ba4e3f82', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:52:12.750000');
INSERT INTO `django_session` VALUES ('chn1348698c635964cfd8a61e3e01b01', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:34:07.737000');
INSERT INTO `django_session` VALUES ('chn16ac7f805019ca6acea52bd6c28a8', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:24:47.722000');
INSERT INTO `django_session` VALUES ('chn1742e019f744e44ee4ba0f6c9929e', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:24:28.217000');
INSERT INTO `django_session` VALUES ('chn17d7fe91fb1cf742b29e44ff06e4a', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:54:32.711000');
INSERT INTO `django_session` VALUES ('chn18e9444711c779692a5ad2991261f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:28:52.722000');
INSERT INTO `django_session` VALUES ('chn19b6a5ef62a0e73c88fe823334c08', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:39:57.732000');
INSERT INTO `django_session` VALUES ('chn1a3cdd73680af91cac0eac6832440', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 10:24:10.432000');
INSERT INTO `django_session` VALUES ('chn1d493dc7bc079337b88928a23f519', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:27:07.714000');
INSERT INTO `django_session` VALUES ('chn1eda11466bf576dc46838607bb987', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:27:42.726000');
INSERT INTO `django_session` VALUES ('chn211a1bb8c29d2245739c8f44572c5', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:53:22.750000');
INSERT INTO `django_session` VALUES ('chn27a8f34676fc1daeaae45aaf01b49', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:09:46.045000');
INSERT INTO `django_session` VALUES ('chn2b3dfcf78f7a40998728fe2a4e023', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:18:22.711000');
INSERT INTO `django_session` VALUES ('chn2bfea06541ebb037952c71567f259', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:02:35.806000');
INSERT INTO `django_session` VALUES ('chn2c9725a62963f5282c169dfd12036', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:09:46.045000');
INSERT INTO `django_session` VALUES ('chn30b0fe51c678a669593d8cc676bfd', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:56:17.720000');
INSERT INTO `django_session` VALUES ('chn3581b6a5337ecd67bf2aa6a58f3d5', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:22:47.296000');
INSERT INTO `django_session` VALUES ('chn3c9a1febf5f28999e998bbb641b3d', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:02:15.357000');
INSERT INTO `django_session` VALUES ('chn41f0d203757e5e6bc6ff07346606c', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:21:17.718000');
INSERT INTO `django_session` VALUES ('chn458c63c54754ea59e518168042ae5', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:14:38.428000');
INSERT INTO `django_session` VALUES ('chn45a0994df0229d8fbfc6ee08cced3', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:18:57.717000');
INSERT INTO `django_session` VALUES ('chn47d15e2111d0dd84ae56aa67920ca', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:26:45.161000');
INSERT INTO `django_session` VALUES ('chn4b6e940af83ece240d85ad2fe0855', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:37:02.736000');
INSERT INTO `django_session` VALUES ('chn4d2e1a5d50f338e52b295bc09286e', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:24:30.742000');
INSERT INTO `django_session` VALUES ('chn4d55e842bd3f25d9b50053365c3da', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:51:37.743000');
INSERT INTO `django_session` VALUES ('chn4f9085ef765069b2fc1e339b81e25', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:09:10.999000');
INSERT INTO `django_session` VALUES ('chn53186d7149872d80fcfa3970a8fb6', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:20:42.693000');
INSERT INTO `django_session` VALUES ('chn54ba13276b0eaa00966547ddfbeb2', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:28:56.159000');
INSERT INTO `django_session` VALUES ('chn54ef6d3ee2bdbb8c0463ec5e29a81', 'NTIyN2RlNGIxM2FjMzM5NjcxZGExNDJmZTMxYjQ2NDE4NDlmYWQwMTp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIn0=', '2017-12-16 09:59:12.744000');
INSERT INTO `django_session` VALUES ('chn5528e45230a719f4e37201463bf04', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:46:22.743000');
INSERT INTO `django_session` VALUES ('chn55f32244cbbb711a2dd3c659475b2', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:25:57.725000');
INSERT INTO `django_session` VALUES ('chn5cade9ea6dd9b9e32777b2a12f5bb', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:49:52.730000');
INSERT INTO `django_session` VALUES ('chn5df98998877feb6923c1d223a680b', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:26:45.786000');
INSERT INTO `django_session` VALUES ('chn5fc83bd7465d8ecd9df25af3b84dc', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:14:38.428000');
INSERT INTO `django_session` VALUES ('chn623fc368b68574287d63d275fe269', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:31:12.735000');
INSERT INTO `django_session` VALUES ('chn634930c15f580c3f96db105c47507', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:21:50.788000');
INSERT INTO `django_session` VALUES ('chn686be04355587a22a88d3bb6a08d3', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:22:27.708000');
INSERT INTO `django_session` VALUES ('chn68971dbed13f39a759f223e2f8ced', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:12:36.212000');
INSERT INTO `django_session` VALUES ('chn6b2cc6269b056a08b609bb8942c2a', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:10:16.223000');
INSERT INTO `django_session` VALUES ('chn6fac472142590dea34f07066bd28c', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:03:00.582000');
INSERT INTO `django_session` VALUES ('chn702b59110fe55ad2d9fe16e87baa8', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:21:53.827000');
INSERT INTO `django_session` VALUES ('chn764eb99d2c02f28951d54feba5442', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:30:37.744000');
INSERT INTO `django_session` VALUES ('chn7ac6573dabe1d46f1eeaf107c29bd', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:26:32.715000');
INSERT INTO `django_session` VALUES ('chn7aff832f9f7bddfc9dc2b9fd25f0a', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:25:34.839000');
INSERT INTO `django_session` VALUES ('chn7bae7817b55401ee4176228776504', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:12:23.549000');
INSERT INTO `django_session` VALUES ('chn7bc2587b2f99ce0d4c1ce37d0a7ee', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:33:32.739000');
INSERT INTO `django_session` VALUES ('chn7e7970756658340bcc3b42efafea6', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:23:02.712000');
INSERT INTO `django_session` VALUES ('chn80e6cf6b2c8f9bb46fa30e662070e', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:55:07.743000');
INSERT INTO `django_session` VALUES ('chn82fdec051aba7ccff8d177bb6b7a8', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:55:42.742000');
INSERT INTO `django_session` VALUES ('chn833b7bf427d3542dbe45dca4996f6', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:31:47.742000');
INSERT INTO `django_session` VALUES ('chn8571b22e2838e7552a38fcfc861f6', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:44:37.727000');
INSERT INTO `django_session` VALUES ('chn85b8f771c8494a01b43aab0c69daf', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:34:42.727000');
INSERT INTO `django_session` VALUES ('chn8b5ad42cf7f37e89508d58b3b6c37', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:45:12.744000');
INSERT INTO `django_session` VALUES ('chn8bbdc1760bb3461d5aede9e79c103', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:27:46.439000');
INSERT INTO `django_session` VALUES ('chn8bc2bd2218851baa21f01bf57da18', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:24:12.698000');
INSERT INTO `django_session` VALUES ('chn8c5fd9aa3c7fc5ed0e572e1b8ea02', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:51:02.739000');
INSERT INTO `django_session` VALUES ('chn923db57665abe22c19aca79c03152', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:49:17.740000');
INSERT INTO `django_session` VALUES ('chn944385572651c56d11b84c733064a', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:42:17.735000');
INSERT INTO `django_session` VALUES ('chn972ddfba38a7a3573ea44033dc2bd', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:44:02.734000');
INSERT INTO `django_session` VALUES ('chn9a3b2391ce10e0d2398621355251f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:35:52.741000');
INSERT INTO `django_session` VALUES ('chn9d31a148bbe49041c7dfd8d71be56', 'NTcyNzI2NTZjMmE2M2Q4YzZkYjdlN2Q1YjAzMjFlNDQ4NDU4MzQyMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImphY2twb3QifQ==', '2017-12-16 10:02:13.371000');
INSERT INTO `django_session` VALUES ('chn9dc03bb28028126472a0c4bf25203', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:23:13.737000');
INSERT INTO `django_session` VALUES ('chna04182c240a4fae8a12d5293cb5d4', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:19:32.717000');
INSERT INTO `django_session` VALUES ('chna40d513085d2632fc6886158c758c', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:23:16.956000');
INSERT INTO `django_session` VALUES ('chna5d0d6d86a9394a078e4eee78c744', 'NTIyN2RlNGIxM2FjMzM5NjcxZGExNDJmZTMxYjQ2NDE4NDlmYWQwMTp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIn0=', '2017-12-16 09:57:27.780000');
INSERT INTO `django_session` VALUES ('chna8299250df12b69e5ea0a0b46e9aa', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:09:50.131000');
INSERT INTO `django_session` VALUES ('chnaac34822c65d15cffa9bc7a2861d0', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:48:42.737000');
INSERT INTO `django_session` VALUES ('chnafcbb95fa7ab7f65344693232db07', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:40:32.732000');
INSERT INTO `django_session` VALUES ('chnb02292f5b957abef658e48a483034', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:27:17.272000');
INSERT INTO `django_session` VALUES ('chnb0c44f979f26f8f4ba2c8d61e062f', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:01:59.976000');
INSERT INTO `django_session` VALUES ('chnb11629778115c9aff042eb6a243c6', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:32:22.728000');
INSERT INTO `django_session` VALUES ('chnb79e0e760b61280dd998bbaeb4693', 'NTIyN2RlNGIxM2FjMzM5NjcxZGExNDJmZTMxYjQ2NDE4NDlmYWQwMTp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIn0=', '2017-12-16 09:58:37.756000');
INSERT INTO `django_session` VALUES ('chnb84466498e0a55679d354f93710fe', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:36:27.736000');
INSERT INTO `django_session` VALUES ('chnb8709063f052db8d87259ec98ef45', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:41:07.739000');
INSERT INTO `django_session` VALUES ('chnb8dd35f96a8062e04eb343d32080f', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:08:47.825000');
INSERT INTO `django_session` VALUES ('chnb9d982a074e9b81d55f68b058fa11', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:29:09.212000');
INSERT INTO `django_session` VALUES ('chnba8663c5da438c1a45e1db4d381b8', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:52:47.739000');
INSERT INTO `django_session` VALUES ('chnbc9c3169725fb7c4f3bc7ec725a69', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:22:14.329000');
INSERT INTO `django_session` VALUES ('chnc6c378d7f81a037355995d88db29f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:30:02.703000');
INSERT INTO `django_session` VALUES ('chnc6c9a524b0634b628660dfc360909', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:22:14.329000');
INSERT INTO `django_session` VALUES ('chnc74c4cefb226a35d1d67c93b5d679', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:38:47.704000');
INSERT INTO `django_session` VALUES ('chncbc0fab252e54eb47ec987debf8b3', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:46:57.743000');
INSERT INTO `django_session` VALUES ('chncc66615c0465697d04fae868b94f3', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:47:32.727000');
INSERT INTO `django_session` VALUES ('chncda5583067ff31dd5b4738fbeca80', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:25:34.839000');
INSERT INTO `django_session` VALUES ('chnd308ea4aa52d35b95e71a65b22548', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:56:52.736000');
INSERT INTO `django_session` VALUES ('chnd3f4f506f1394c913919e2e51dc3e', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:23:37.703000');
INSERT INTO `django_session` VALUES ('chnd6d4e7d8c64e7610f8f76dd615c63', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:48:07.742000');
INSERT INTO `django_session` VALUES ('chne01211e23366c17441ad786e8fac2', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:08:47.824000');
INSERT INTO `django_session` VALUES ('chne1dfa5147b7121ab5ffc09b940613', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:03:00.583000');
INSERT INTO `django_session` VALUES ('chne7a00b8f6c34215d1508ca901e120', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:41:42.736000');
INSERT INTO `django_session` VALUES ('chne9951c746e74133bf3fde0af5fb78', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:29:27.734000');
INSERT INTO `django_session` VALUES ('chneb4900bef0b7d9ada336899975f20', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:09:08.805000');
INSERT INTO `django_session` VALUES ('chneb67af5c9bbd196a3729c3ca03bfd', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:21:52.722000');
INSERT INTO `django_session` VALUES ('chnecda8fe437d9ee09a6d4130fc3b20', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:53:57.738000');
INSERT INTO `django_session` VALUES ('chnedfaeddf708c21653e22718e4e681', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:12:33.107000');
INSERT INTO `django_session` VALUES ('chneea8fe53f502117754fb212663a46', 'ODM2YWY1NjAzZDljMDRiODg5NWRhOTVhOGRiOTJjMmMzMmQwMWZiMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3NmU0ZGZiYmNiMGJiMmNkZDNmZGQwODNiN2IwNzU1MjQ0ZDY3YjciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:23:14.347000');
INSERT INTO `django_session` VALUES ('chnef5a1dfcbb990192407cb0f635975', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:28:17.723000');
INSERT INTO `django_session` VALUES ('chnf8a06db89dfff22827b257c3b859f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:35:17.712000');
INSERT INTO `django_session` VALUES ('chnf8e5965fe51b4cc1deb41e931f3a7', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:25:22.720000');
INSERT INTO `django_session` VALUES ('chnf91567612540c4899068311ec016a', 'ZDNhMjNkOWFjODM1NzE3NTQ1YmRlMzlhNGFhMjgwNGJiOTllNzJhMDp7Il9hdXRoX3VzZXJfaGFzaCI6ImU4MDU2OWVkOGE3OWRkYmYzNDY3MzYzM2U5OGExMmMzNzA5YjU5N2EiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-12-16 10:12:23.549000');
INSERT INTO `django_session` VALUES ('chnfa95b5d1269578c5cb572a3d11e1f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:17:12.708000');
INSERT INTO `django_session` VALUES ('chnfb4a4a659922ee1013442bfc4614a', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:39:22.727000');
INSERT INTO `django_session` VALUES ('chnff2daf35e477a80a9febbc0dd45d3', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:20:07.719000');
INSERT INTO `django_session` VALUES ('chnff8e85dcb29c218868ccec2e1b2e2', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:17:47.736000');
INSERT INTO `django_session` VALUES ('chnff98370f5708200d824ada2a79772', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:45:47.738000');
INSERT INTO `django_session` VALUES ('chnffba7f7cb8ce0367bde00470ec6ab', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:43:27.722000');
INSERT INTO `django_session` VALUES ('hxrp5bod12vti51fpapounaevbj7t7d8', 'ZmFlMWUwODU0YzNiZjU0YTc5YWUxOWEyZDEwODliMzZjYjAwYzcyMDp7InNvY2lhbF9hdXRoX2xhc3RfbG9naW5fYmFja2VuZCI6InN0ZWFtIiwib3BlbmlkIjp7fSwiX2F1dGhfdXNlcl9oYXNoIjoiZjc2ZTRkZmJiY2IwYmIyY2RkM2ZkZDA4M2I3YjA3NTUyNDRkNjdiNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==', '2017-12-16 09:57:04.869000');

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
  `total_amount` double NOT NULL,
  `ref_code` varchar(32) NOT NULL,
  `ref_point` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `steamid` (`steamid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_steamuser
-- ----------------------------
INSERT INTO `social_auth_steamuser` VALUES ('1', '!luwQRDl6fWO1q7LORHBWUb1ZuW0thL7xB28LY6N8', '2017-12-02 09:57:04.864000', '1', '76561198042231205', 'zhouzhouli', 'http://steamcommunity.com/id/zhouzhouli/', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_full.jpg', '', '2017-12-02 09:57:04.814000', '1', '1', 'https://steamcommunity.com/tradeoffer/new/?partner=81965477&token=tOXxzSCE', '1', '0', '1', '55.01', '55.01', 'FBSWOIZG', '1');
INSERT INTO `social_auth_steamuser` VALUES ('2', '!99VCOginJbqCCq8WKefpeSQHMcjcCgDd4WHI0CCm', '2017-12-02 10:01:50.134000', '0', '76561198387169533', 'zhouzhou', 'http://steamcommunity.com/profiles/76561198387169533/', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b_full.jpg', '', '2017-12-02 09:58:08.955000', '1', '0', 'https://steamcommunity.com/tradeoffer/new/?partner=426903805&token=1sRlQxa1', '1', '0', '1', '-72.56', '72.56', 'MHDTQUWW', '0');

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
INSERT INTO `social_auth_usersocialauth` VALUES ('1', 'steam', '76561198042231205', '{\"player\": {\"steamid\": \"76561198042231205\", \"primaryclanid\": \"103582791429521408\", \"timecreated\": 1306067183, \"personaname\": \"zhouzhouli\", \"personastate\": 0, \"personastateflags\": 0, \"communityvisibilitystate\": 3, \"loccountrycode\": \"CN\", \"profilestate\": 1, \"profileurl\": \"http://steamcommunity.com/id/zhouzhouli/\", \"loccityid\": 9888, \"avatar\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6.jpg\", \"locstatecode\": \"32\", \"avatarfull\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_full.jpg\", \"avatarmedium\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/d2/d24896e24894cf2b2196fb9dcc21df51ad152dd6_medium.jpg\", \"lastlogoff\": 1511486832}, \"auth_time\": 1512208624}', '1');
INSERT INTO `social_auth_usersocialauth` VALUES ('2', 'steam', '76561198387169533', '{\"player\": {\"steamid\": \"76561198387169533\", \"primaryclanid\": \"103582791429521408\", \"timecreated\": 1494053450, \"personaname\": \"zhouzhou\", \"personastate\": 0, \"personastateflags\": 0, \"communityvisibilitystate\": 3, \"profilestate\": 1, \"profileurl\": \"http://steamcommunity.com/profiles/76561198387169533/\", \"avatar\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b.jpg\", \"avatarfull\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b_full.jpg\", \"avatarmedium\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a9/a998a839a618c812685d23354f7df5e70408c57b_medium.jpg\", \"lastlogoff\": 1512140111}, \"auth_time\": 1512208910}', '2');
