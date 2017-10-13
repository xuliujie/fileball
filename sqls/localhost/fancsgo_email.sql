/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 100206
Source Host           : localhost:3306
Source Database       : fancsgo

Target Server Type    : MYSQL
Target Server Version : 100206
File Encoding         : 65001

Date: 2017-10-13 16:15:51
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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add group', '2', 'add_group');
INSERT INTO `auth_permission` VALUES ('5', 'Can change group', '2', 'change_group');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete group', '2', 'delete_group');
INSERT INTO `auth_permission` VALUES ('7', 'Can add permission', '3', 'add_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can change permission', '3', 'change_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete permission', '3', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('16', 'Can add site', '6', 'add_site');
INSERT INTO `auth_permission` VALUES ('17', 'Can change site', '6', 'change_site');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete site', '6', 'delete_site');
INSERT INTO `auth_permission` VALUES ('19', 'Can add user profile', '7', 'add_userprofile');
INSERT INTO `auth_permission` VALUES ('20', 'Can change user profile', '7', 'change_userprofile');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete user profile', '7', 'delete_userprofile');
INSERT INTO `auth_permission` VALUES ('22', 'Can add Games', '8', 'add_coinflipgame');
INSERT INTO `auth_permission` VALUES ('23', 'Can change Games', '8', 'change_coinflipgame');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete Games', '8', 'delete_coinflipgame');
INSERT INTO `auth_permission` VALUES ('25', 'Can add Temp Game Hash', '9', 'add_tempgamehash');
INSERT INTO `auth_permission` VALUES ('26', 'Can change Temp Game Hash', '9', 'change_tempgamehash');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete Temp Game Hash', '9', 'delete_tempgamehash');
INSERT INTO `auth_permission` VALUES ('28', 'Can add message', '10', 'add_message');
INSERT INTO `auth_permission` VALUES ('29', 'Can change message', '10', 'change_message');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete message', '10', 'delete_message');
INSERT INTO `auth_permission` VALUES ('31', 'Can add Site Configs', '11', 'add_siteconfig');
INSERT INTO `auth_permission` VALUES ('32', 'Can change Site Configs', '11', 'change_siteconfig');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete Site Configs', '11', 'delete_siteconfig');
INSERT INTO `auth_permission` VALUES ('34', 'Can add User Posts', '12', 'add_userpost');
INSERT INTO `auth_permission` VALUES ('35', 'Can change User Posts', '12', 'change_userpost');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete User Posts', '12', 'delete_userpost');
INSERT INTO `auth_permission` VALUES ('37', 'Can add Betting Bots', '13', 'add_bettingbot');
INSERT INTO `auth_permission` VALUES ('38', 'Can change Betting Bots', '13', 'change_bettingbot');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete Betting Bots', '13', 'delete_bettingbot');
INSERT INTO `auth_permission` VALUES ('40', 'Can add steamrobot api item', '14', 'add_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('41', 'Can change steamrobot api item', '14', 'change_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete steamrobot api item', '14', 'delete_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('43', 'Can add market item', '15', 'add_marketitem');
INSERT INTO `auth_permission` VALUES ('44', 'Can change market item', '15', 'change_marketitem');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete market item', '15', 'delete_marketitem');
INSERT INTO `auth_permission` VALUES ('46', 'Can add room', '16', 'add_room');
INSERT INTO `auth_permission` VALUES ('47', 'Can change room', '16', 'change_room');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete room', '16', 'delete_room');
INSERT INTO `auth_permission` VALUES ('49', 'Can add Give Away', '17', 'add_giveaway');
INSERT INTO `auth_permission` VALUES ('50', 'Can change Give Away', '17', 'change_giveaway');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete Give Away', '17', 'delete_giveaway');
INSERT INTO `auth_permission` VALUES ('52', 'Can add Prop Items', '18', 'add_propitem');
INSERT INTO `auth_permission` VALUES ('53', 'Can change Prop Items', '18', 'change_propitem');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete Prop Items', '18', 'delete_propitem');
INSERT INTO `auth_permission` VALUES ('55', 'Can add Send Records', '19', 'add_sendrecord');
INSERT INTO `auth_permission` VALUES ('56', 'Can change Send Records', '19', 'change_sendrecord');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete Send Records', '19', 'delete_sendrecord');
INSERT INTO `auth_permission` VALUES ('58', 'Can add Deposit', '20', 'add_deposit');
INSERT INTO `auth_permission` VALUES ('59', 'Can change Deposit', '20', 'change_deposit');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete Deposit', '20', 'delete_deposit');
INSERT INTO `auth_permission` VALUES ('61', 'Can add Store Records', '21', 'add_storerecord');
INSERT INTO `auth_permission` VALUES ('62', 'Can change Store Records', '21', 'change_storerecord');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete Store Records', '21', 'delete_storerecord');
INSERT INTO `auth_permission` VALUES ('64', 'Can add Announcements', '22', 'add_announcement');
INSERT INTO `auth_permission` VALUES ('65', 'Can change Announcements', '22', 'change_announcement');
INSERT INTO `auth_permission` VALUES ('66', 'Can delete Announcements', '22', 'delete_announcement');
INSERT INTO `auth_permission` VALUES ('67', 'Can add steam user', '23', 'add_steamuser');
INSERT INTO `auth_permission` VALUES ('68', 'Can change steam user', '23', 'change_steamuser');
INSERT INTO `auth_permission` VALUES ('69', 'Can delete steam user', '23', 'delete_steamuser');
INSERT INTO `auth_permission` VALUES ('70', 'Can add association', '24', 'add_association');
INSERT INTO `auth_permission` VALUES ('71', 'Can change association', '24', 'change_association');
INSERT INTO `auth_permission` VALUES ('72', 'Can delete association', '24', 'delete_association');
INSERT INTO `auth_permission` VALUES ('73', 'Can add user social auth', '25', 'add_usersocialauth');
INSERT INTO `auth_permission` VALUES ('74', 'Can change user social auth', '25', 'change_usersocialauth');
INSERT INTO `auth_permission` VALUES ('75', 'Can delete user social auth', '25', 'delete_usersocialauth');
INSERT INTO `auth_permission` VALUES ('76', 'Can add nonce', '26', 'add_nonce');
INSERT INTO `auth_permission` VALUES ('77', 'Can change nonce', '26', 'change_nonce');
INSERT INTO `auth_permission` VALUES ('78', 'Can delete nonce', '26', 'delete_nonce');
INSERT INTO `auth_permission` VALUES ('79', 'Can add code', '27', 'add_code');
INSERT INTO `auth_permission` VALUES ('80', 'Can change code', '27', 'change_code');
INSERT INTO `auth_permission` VALUES ('81', 'Can delete code', '27', 'delete_code');
INSERT INTO `auth_permission` VALUES ('82', 'Can add partial', '28', 'add_partial');
INSERT INTO `auth_permission` VALUES ('83', 'Can change partial', '28', 'change_partial');
INSERT INTO `auth_permission` VALUES ('84', 'Can delete partial', '28', 'delete_partial');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_coinflipgame
-- ----------------------------
INSERT INTO `betting_coinflipgame` VALUES ('1', '8155f1a1afee11e7a5da3cf8623f349a', '2017-10-13 08:14:16.506000', '2017-10-13 08:14:16.506000', 'a3b0e73cae709cc994d7cf1ab6c8f2e5', 'LUPMCARMWC', '0.672434244223774', '1', null, '0', '0', '0', '0', '2017-10-13 08:14:16.506000', '2', '0');

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
  `g_type` smallint(6) NOT NULL,
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
  `market_hash_name` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `rarity` varchar(128) DEFAULT NULL,
  `rarity_color` varchar(128) DEFAULT NULL,
  `exterior` varchar(128) DEFAULT NULL,
  `assetid` varchar(128) DEFAULT NULL,
  `appid` varchar(128) NOT NULL,
  `classid` varchar(128) NOT NULL,
  `contextid` int(11) NOT NULL,
  `instanceid` varchar(128) DEFAULT NULL,
  `is_locked` tinyint(1) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `betting_propitem_owner_id_d9cecf06_fk_social_auth_steamuser_id` (`owner_id`),
  CONSTRAINT `betting_propitem_owner_id_d9cecf06_fk_social_auth_steamuser_id` FOREIGN KEY (`owner_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_propitem
-- ----------------------------

-- ----------------------------
-- Table structure for betting_propitem_deposit
-- ----------------------------
DROP TABLE IF EXISTS `betting_propitem_deposit`;
CREATE TABLE `betting_propitem_deposit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `propitem_id` int(11) NOT NULL,
  `deposit_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `betting_propitem_deposit_propitem_id_deposit_id_e634cb1e_uniq` (`propitem_id`,`deposit_id`),
  KEY `betting_propitem_dep_deposit_id_0be4c3cc_fk_betting_d` (`deposit_id`),
  CONSTRAINT `betting_propitem_dep_deposit_id_0be4c3cc_fk_betting_d` FOREIGN KEY (`deposit_id`) REFERENCES `betting_deposit` (`id`),
  CONSTRAINT `betting_propitem_dep_propitem_id_a0b4b713_fk_betting_p` FOREIGN KEY (`propitem_id`) REFERENCES `betting_propitem` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_propitem_deposit
-- ----------------------------

-- ----------------------------
-- Table structure for betting_propitem_send_record
-- ----------------------------
DROP TABLE IF EXISTS `betting_propitem_send_record`;
CREATE TABLE `betting_propitem_send_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `propitem_id` int(11) NOT NULL,
  `sendrecord_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `betting_propitem_send_re_propitem_id_sendrecord_i_375a87ad_uniq` (`propitem_id`,`sendrecord_id`),
  KEY `betting_propitem_sen_sendrecord_id_a2f14d21_fk_betting_s` (`sendrecord_id`),
  CONSTRAINT `betting_propitem_sen_propitem_id_ea54f595_fk_betting_p` FOREIGN KEY (`propitem_id`) REFERENCES `betting_propitem` (`id`),
  CONSTRAINT `betting_propitem_sen_sendrecord_id_a2f14d21_fk_betting_s` FOREIGN KEY (`sendrecord_id`) REFERENCES `betting_sendrecord` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_propitem_send_record
-- ----------------------------

-- ----------------------------
-- Table structure for betting_propitem_store_record
-- ----------------------------
DROP TABLE IF EXISTS `betting_propitem_store_record`;
CREATE TABLE `betting_propitem_store_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `propitem_id` int(11) NOT NULL,
  `storerecord_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `betting_propitem_store_r_propitem_id_storerecord__cc3948fc_uniq` (`propitem_id`,`storerecord_id`),
  KEY `betting_propitem_sto_storerecord_id_bcf5f958_fk_betting_s` (`storerecord_id`),
  CONSTRAINT `betting_propitem_sto_propitem_id_95efe0f9_fk_betting_p` FOREIGN KEY (`propitem_id`) REFERENCES `betting_propitem` (`id`),
  CONSTRAINT `betting_propitem_sto_storerecord_id_bcf5f958_fk_betting_s` FOREIGN KEY (`storerecord_id`) REFERENCES `betting_storerecord` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_propitem_store_record
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
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `betting_sendrecord_steamer_id_8a54c2ad_fk_social_au` (`steamer_id`),
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
-- Table structure for betting_storerecord
-- ----------------------------
DROP TABLE IF EXISTS `betting_storerecord`;
CREATE TABLE `betting_storerecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `amount` double NOT NULL,
  `status` int(11) NOT NULL,
  `security_code` varchar(32) DEFAULT NULL,
  `trade_no` varchar(64) DEFAULT NULL,
  `bot_status` int(11) NOT NULL,
  `bot_msg` longtext DEFAULT NULL,
  `trade_ts` datetime(6) NOT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `betting_storerecord_steamer_id_1201c2ad_fk_social_au` (`steamer_id`),
  CONSTRAINT `betting_storerecord_steamer_id_1201c2ad_fk_social_au` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_storerecord
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
-- Table structure for betting_userpost
-- ----------------------------
DROP TABLE IF EXISTS `betting_userpost`;
CREATE TABLE `betting_userpost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `remark` varchar(64) NOT NULL,
  `give_id` int(11) NOT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  UNIQUE KEY `steamer_id` (`steamer_id`),
  KEY `betting_userpost_give_id_90a5af0b_fk_betting_giveaway_id` (`give_id`),
  CONSTRAINT `betting_userpost_give_id_90a5af0b_fk_betting_giveaway_id` FOREIGN KEY (`give_id`) REFERENCES `betting_giveaway` (`id`),
  CONSTRAINT `betting_userpost_steamer_id_33fa2841_fk_social_auth_steamuser_id` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_userpost
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('22', 'betting', 'announcement');
INSERT INTO `django_content_type` VALUES ('13', 'betting', 'bettingbot');
INSERT INTO `django_content_type` VALUES ('8', 'betting', 'coinflipgame');
INSERT INTO `django_content_type` VALUES ('20', 'betting', 'deposit');
INSERT INTO `django_content_type` VALUES ('17', 'betting', 'giveaway');
INSERT INTO `django_content_type` VALUES ('15', 'betting', 'marketitem');
INSERT INTO `django_content_type` VALUES ('10', 'betting', 'message');
INSERT INTO `django_content_type` VALUES ('18', 'betting', 'propitem');
INSERT INTO `django_content_type` VALUES ('16', 'betting', 'room');
INSERT INTO `django_content_type` VALUES ('19', 'betting', 'sendrecord');
INSERT INTO `django_content_type` VALUES ('11', 'betting', 'siteconfig');
INSERT INTO `django_content_type` VALUES ('14', 'betting', 'steamrobotapiitem');
INSERT INTO `django_content_type` VALUES ('21', 'betting', 'storerecord');
INSERT INTO `django_content_type` VALUES ('9', 'betting', 'tempgamehash');
INSERT INTO `django_content_type` VALUES ('12', 'betting', 'userpost');
INSERT INTO `django_content_type` VALUES ('7', 'betting', 'userprofile');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('6', 'sites', 'site');
INSERT INTO `django_content_type` VALUES ('23', 'social_auth', 'steamuser');
INSERT INTO `django_content_type` VALUES ('24', 'social_django', 'association');
INSERT INTO `django_content_type` VALUES ('27', 'social_django', 'code');
INSERT INTO `django_content_type` VALUES ('26', 'social_django', 'nonce');
INSERT INTO `django_content_type` VALUES ('28', 'social_django', 'partial');
INSERT INTO `django_content_type` VALUES ('25', 'social_django', 'usersocialauth');

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2017-10-13 06:42:17.052000');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0002_remove_content_type_name', '2017-10-13 06:42:18.016000');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2017-10-13 06:42:21.270000');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0002_alter_permission_name_max_length', '2017-10-13 06:42:21.889000');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0003_alter_user_email_max_length', '2017-10-13 06:42:21.973000');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0004_alter_user_username_opts', '2017-10-13 06:42:22.030000');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0005_alter_user_last_login_null', '2017-10-13 06:42:22.117000');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0006_require_contenttypes_0002', '2017-10-13 06:42:22.150000');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0007_alter_validators_add_error_messages', '2017-10-13 06:42:22.205000');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0008_alter_user_username_max_length', '2017-10-13 06:42:22.250000');
INSERT INTO `django_migrations` VALUES ('11', 'social_auth', '0001_initial', '2017-10-13 06:42:25.170000');
INSERT INTO `django_migrations` VALUES ('12', 'admin', '0001_initial', '2017-10-13 06:42:26.333000');
INSERT INTO `django_migrations` VALUES ('13', 'admin', '0002_logentry_remove_auto_add', '2017-10-13 06:42:26.371000');
INSERT INTO `django_migrations` VALUES ('14', 'betting', '0001_initial', '2017-10-13 06:42:41.879000');
INSERT INTO `django_migrations` VALUES ('15', 'sessions', '0001_initial', '2017-10-13 06:42:42.420000');
INSERT INTO `django_migrations` VALUES ('16', 'sites', '0001_initial', '2017-10-13 06:42:42.736000');
INSERT INTO `django_migrations` VALUES ('17', 'sites', '0002_alter_domain_unique', '2017-10-13 06:42:43.115000');
INSERT INTO `django_migrations` VALUES ('18', 'social_django', '0001_initial', '2017-10-13 06:42:46.146000');

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
INSERT INTO `django_session` VALUES ('bzpb3zvfdra5o4560ohbwlr2seyiiyc3', 'ZmE0OGQ4NGJlYjQyNTgxNmIzZmY5MGZmMDQwZThjZTVlNDQ4NzQxNTp7InNvY2lhbF9hdXRoX2xhc3RfbG9naW5fYmFja2VuZCI6InN0ZWFtIiwib3BlbmlkIjp7fSwiX2F1dGhfdXNlcl9oYXNoIjoiYzU4ZjgxNDE4MzIyZDQ5NTQyZTNhNGI4YjBmN2U3NTJjYWZlNDdjMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==', '2017-10-27 06:43:32.730000');
INSERT INTO `django_session` VALUES ('chn0527716907e4b37fbf28c735bc37a', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 08:00:18.750000');
INSERT INTO `django_session` VALUES ('chn0584159e1c629adcabf975c7e1710', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:08:37.149000');
INSERT INTO `django_session` VALUES ('chn08ed19a0448e279da727d23eb3db8', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:16:07.137000');
INSERT INTO `django_session` VALUES ('chn1007e8f25bd768c84a1b96b607543', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:19:30.129000');
INSERT INTO `django_session` VALUES ('chn11393ad15bb34021ede7ea45f692f', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 08:14:17.656000');
INSERT INTO `django_session` VALUES ('chn114a3491af37df31e6c8eadbc09c5', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:18:09.126000');
INSERT INTO `django_session` VALUES ('chn1a2657815a295fc27cc36e00454c8', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:09:04.025000');
INSERT INTO `django_session` VALUES ('chn21109af1920edd033af7ef3f95085', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 08:07:31.746000');
INSERT INTO `django_session` VALUES ('chn27dee0ccabdd8b488d744ad1123a1', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:16:17.154000');
INSERT INTO `django_session` VALUES ('chn356aca8cd324aa1ea27180132a29f', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:20:03.029000');
INSERT INTO `django_session` VALUES ('chn4f00f057b2aac3122836e4ff81586', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 06:50:59.438000');
INSERT INTO `django_session` VALUES ('chn543ddff333fcaff973fd63bc9fe09', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 06:56:19.479000');
INSERT INTO `django_session` VALUES ('chn56398b36e89c0a25bab4134d2490e', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:57:10.655000');
INSERT INTO `django_session` VALUES ('chn618190ea1bfcc91fc58ae27341920', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:59:06.666000');
INSERT INTO `django_session` VALUES ('chn64816c54df620d37fc8ac645475bb', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:09:47.114000');
INSERT INTO `django_session` VALUES ('chn656d6a30ac128c8825bfef16262e4', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 06:48:23.830000');
INSERT INTO `django_session` VALUES ('chn6631e2ddb87801a236008322d8fdf', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 08:03:00.667000');
INSERT INTO `django_session` VALUES ('chn67ecddfbc6e15dff43fb670de153d', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 08:03:08.713000');
INSERT INTO `django_session` VALUES ('chn6ecca9565f860fc32c334f6746015', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 08:06:09.672000');
INSERT INTO `django_session` VALUES ('chn711b0c58e76bd9a6fde2d329be2f9', 'ZDkyNzJiMDM0YzljYzRlOGUwZmU1ZTBjMzc1YjY3YTRiNzhhOWEzYzp7InJvb20iOiJjb2luZmxpcCJ9', '2017-10-27 06:43:24.464000');
INSERT INTO `django_session` VALUES ('chn87903a085e0dd065c20469e0e3105', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 08:04:23.638000');
INSERT INTO `django_session` VALUES ('chn8c223aacffa15ecd1220bd06e69bf', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 06:43:33.186000');
INSERT INTO `django_session` VALUES ('chn8d00c300e36be446aac87d44e1d7c', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:02:50.144000');
INSERT INTO `django_session` VALUES ('chn92456fcb48487b10f73042a7ce7fe', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:08:45.066000');
INSERT INTO `django_session` VALUES ('chn9b065d5a2d140138f7058be020ddb', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 08:08:01.705000');
INSERT INTO `django_session` VALUES ('chn9c86bcffa1cad486d77a4467497c3', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:10:10.089000');
INSERT INTO `django_session` VALUES ('chna042d539cfbf375c7b9c138e78ee3', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 08:01:56.658000');
INSERT INTO `django_session` VALUES ('chnaaa29ff2878ad5173f18664725ad0', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:57:13.674000');
INSERT INTO `django_session` VALUES ('chnbcd7662b3181ac001cf3c901a8acb', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 08:07:43.736000');
INSERT INTO `django_session` VALUES ('chncd6d6b931c4a5be43c3bd222d138c', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 06:58:06.072000');
INSERT INTO `django_session` VALUES ('chnd5e48404b9ba73df614ea04fcaef3', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 06:46:05.779000');
INSERT INTO `django_session` VALUES ('chneb935a1ba0a0183d971b480ba898d', 'YjA0NWNmMzQ5NmY2MDg3OTdlOTBkYjQ3ODRkOTBiMzlhNTcwODFiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImM1OGY4MTQxODMyMmQ0OTU0MmUzYTRiOGIwZjdlNzUyY2FmZTQ3YzEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6InNvY2lhbF9jb3JlLmJhY2tlbmRzLnN0ZWFtLlN0ZWFtT3BlbklkIiwicm9vbSI6ImNvaW5mbGlwIn0=', '2017-10-27 07:10:24.152000');

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
  `tradeurl` varchar(300) NOT NULL,
  `level` int(11) NOT NULL,
  `is_cheating` tinyint(1) NOT NULL,
  `can_chat` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `steamid` (`steamid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_auth_steamuser
-- ----------------------------
INSERT INTO `social_auth_steamuser` VALUES ('1', '!JN1xxRPXrIcRuCGyWRaWJohnmH4rqRUoRV62njWs', '2017-10-13 06:43:32.696000', '1', '76561198090809675', 'coodrag', 'http://steamcommunity.com/profiles/76561198090809675/', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a2/a244cb837dda11762dd53b472008a6afad782b46.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a2/a244cb837dda11762dd53b472008a6afad782b46_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a2/a244cb837dda11762dd53b472008a6afad782b46_full.jpg', '', '2017-10-13 06:43:32.408000', '1', '1', '', '1', '0', '1');

-- ----------------------------
-- Table structure for social_auth_steamuser_groups
-- ----------------------------
DROP TABLE IF EXISTS `social_auth_steamuser_groups`;
CREATE TABLE `social_auth_steamuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steamuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_steamuser_groups_steamuser_id_group_id_0d814ed1_uniq` (`steamuser_id`,`group_id`),
  KEY `social_auth_steamuser_groups_group_id_46a84782_fk_auth_group_id` (`group_id`),
  CONSTRAINT `social_auth_steamuse_steamuser_id_b0a270ed_fk_social_au` FOREIGN KEY (`steamuser_id`) REFERENCES `social_auth_steamuser` (`id`),
  CONSTRAINT `social_auth_steamuser_groups_group_id_46a84782_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_steamuser_us_steamuser_id_permission__c92a68c6_uniq` (`steamuser_id`,`permission_id`),
  KEY `social_auth_steamuse_permission_id_5762197e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `social_auth_steamuse_permission_id_5762197e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `social_auth_steamuse_steamuser_id_f96ab383_fk_social_au` FOREIGN KEY (`steamuser_id`) REFERENCES `social_auth_steamuser` (`id`)
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
INSERT INTO `social_auth_usersocialauth` VALUES ('1', 'steam', '76561198090809675', '{\"player\": {\"steamid\": \"76561198090809675\", \"primaryclanid\": \"103582791429521408\", \"realname\": \"\\u8001\\u6768\", \"personaname\": \"coodrag\", \"personastate\": 4, \"personastateflags\": 0, \"communityvisibilitystate\": 3, \"profilestate\": 1, \"profileurl\": \"http://steamcommunity.com/profiles/76561198090809675/\", \"timecreated\": 1367850580, \"avatar\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a2/a244cb837dda11762dd53b472008a6afad782b46.jpg\", \"avatarfull\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a2/a244cb837dda11762dd53b472008a6afad782b46_full.jpg\", \"avatarmedium\": \"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/a2/a244cb837dda11762dd53b472008a6afad782b46_medium.jpg\", \"lastlogoff\": 1507718459}, \"auth_time\": 1507877012}', '1');
