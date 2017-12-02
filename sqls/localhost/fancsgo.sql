/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 100210
Source Host           : localhost:3306
Source Database       : fancsgo

Target Server Type    : MYSQL
Target Server Version : 100210
File Encoding         : 65001

Date: 2017-12-02 17:41:31
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_coinflipgame
-- ----------------------------
INSERT INTO `betting_coinflipgame` VALUES ('1', '94673f8fd74111e78e4bf0795969d36d', '2017-12-02 09:17:12.074000', '2017-12-02 09:17:12.074000', 'd9ffadf196efe8b40f8aca57c53646d7', 'XESGRQMOAR', '61.3615916413337', '1', null, '0', '0', '0', '-1', '2017-12-02 09:17:12.073000', '2', '0');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_deposit
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_promotion
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_propitem
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_room
-- ----------------------------

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
  `item_refer_igxe_steam_price` double DEFAULT NULL,
  `item_refer_igxe_price` double DEFAULT NULL,
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
INSERT INTO `django_session` VALUES ('chn03247c707b72081b7b716e823b2ac', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:32:57.721000');
INSERT INTO `django_session` VALUES ('chn10799582ea4fa4674b7a308981cb5', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:38:12.733000');
INSERT INTO `django_session` VALUES ('chn10e4c52fc509a23a7bcb09183fe18', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:37:37.732000');
INSERT INTO `django_session` VALUES ('chn1348698c635964cfd8a61e3e01b01', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:34:07.737000');
INSERT INTO `django_session` VALUES ('chn16ac7f805019ca6acea52bd6c28a8', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:24:47.722000');
INSERT INTO `django_session` VALUES ('chn18e9444711c779692a5ad2991261f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:28:52.722000');
INSERT INTO `django_session` VALUES ('chn19b6a5ef62a0e73c88fe823334c08', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:39:57.732000');
INSERT INTO `django_session` VALUES ('chn1d493dc7bc079337b88928a23f519', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:27:07.714000');
INSERT INTO `django_session` VALUES ('chn1eda11466bf576dc46838607bb987', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:27:42.726000');
INSERT INTO `django_session` VALUES ('chn2b3dfcf78f7a40998728fe2a4e023', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:18:22.711000');
INSERT INTO `django_session` VALUES ('chn41f0d203757e5e6bc6ff07346606c', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:21:17.718000');
INSERT INTO `django_session` VALUES ('chn45a0994df0229d8fbfc6ee08cced3', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:18:57.717000');
INSERT INTO `django_session` VALUES ('chn4b6e940af83ece240d85ad2fe0855', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:37:02.736000');
INSERT INTO `django_session` VALUES ('chn53186d7149872d80fcfa3970a8fb6', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:20:42.693000');
INSERT INTO `django_session` VALUES ('chn55f32244cbbb711a2dd3c659475b2', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:25:57.725000');
INSERT INTO `django_session` VALUES ('chn623fc368b68574287d63d275fe269', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:31:12.735000');
INSERT INTO `django_session` VALUES ('chn686be04355587a22a88d3bb6a08d3', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:22:27.708000');
INSERT INTO `django_session` VALUES ('chn764eb99d2c02f28951d54feba5442', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:30:37.744000');
INSERT INTO `django_session` VALUES ('chn7ac6573dabe1d46f1eeaf107c29bd', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:26:32.715000');
INSERT INTO `django_session` VALUES ('chn7bc2587b2f99ce0d4c1ce37d0a7ee', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:33:32.739000');
INSERT INTO `django_session` VALUES ('chn7e7970756658340bcc3b42efafea6', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:23:02.712000');
INSERT INTO `django_session` VALUES ('chn833b7bf427d3542dbe45dca4996f6', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:31:47.742000');
INSERT INTO `django_session` VALUES ('chn85b8f771c8494a01b43aab0c69daf', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:34:42.727000');
INSERT INTO `django_session` VALUES ('chn8bc2bd2218851baa21f01bf57da18', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:24:12.698000');
INSERT INTO `django_session` VALUES ('chn9a3b2391ce10e0d2398621355251f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:35:52.741000');
INSERT INTO `django_session` VALUES ('chna04182c240a4fae8a12d5293cb5d4', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:19:32.717000');
INSERT INTO `django_session` VALUES ('chnafcbb95fa7ab7f65344693232db07', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:40:32.732000');
INSERT INTO `django_session` VALUES ('chnb11629778115c9aff042eb6a243c6', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:32:22.728000');
INSERT INTO `django_session` VALUES ('chnb84466498e0a55679d354f93710fe', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:36:27.736000');
INSERT INTO `django_session` VALUES ('chnb8709063f052db8d87259ec98ef45', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:41:07.739000');
INSERT INTO `django_session` VALUES ('chnc6c378d7f81a037355995d88db29f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:30:02.703000');
INSERT INTO `django_session` VALUES ('chnc74c4cefb226a35d1d67c93b5d679', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:38:47.704000');
INSERT INTO `django_session` VALUES ('chnd3f4f506f1394c913919e2e51dc3e', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:23:37.703000');
INSERT INTO `django_session` VALUES ('chne9951c746e74133bf3fde0af5fb78', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:29:27.734000');
INSERT INTO `django_session` VALUES ('chneb67af5c9bbd196a3729c3ca03bfd', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:21:52.722000');
INSERT INTO `django_session` VALUES ('chnef5a1dfcbb990192407cb0f635975', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:28:17.723000');
INSERT INTO `django_session` VALUES ('chnf8a06db89dfff22827b257c3b859f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:35:17.712000');
INSERT INTO `django_session` VALUES ('chnf8e5965fe51b4cc1deb41e931f3a7', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:25:22.720000');
INSERT INTO `django_session` VALUES ('chnfa95b5d1269578c5cb572a3d11e1f', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:17:12.708000');
INSERT INTO `django_session` VALUES ('chnfb4a4a659922ee1013442bfc4614a', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:39:22.727000');
INSERT INTO `django_session` VALUES ('chnff2daf35e477a80a9febbc0dd45d3', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:20:07.719000');
INSERT INTO `django_session` VALUES ('chnff8e85dcb29c218868ccec2e1b2e2', 'ZjJhZTBkNzgxMDg5MWRiNjQ3ZWEyYmQ1M2JiZTdjMWEzMTBkNzZkMzp7fQ==', '2017-12-16 09:17:47.736000');
INSERT INTO `django_session` VALUES ('vpgd5b45ym0i47p1jdtsscs8zmozllte', 'MGZjYmYwNTQ2ODk5ZjU3ODQ1YmRhMjdmYmZhZWJlMTc5ZWQ5OWFhYjp7Im9wZW5pZCI6e319', '2017-12-16 09:22:15.769000');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_steamuser
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_usersocialauth
-- ----------------------------
