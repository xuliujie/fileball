/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 100114
Source Host           : localhost:3306
Source Database       : fancsgo

Target Server Type    : MYSQL
Target Server Version : 100114
File Encoding         : 65001

Date: 2017-10-12 09:42:30
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
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;

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
INSERT INTO `auth_permission` VALUES ('28', 'Can add Send Records', '10', 'add_sendrecord');
INSERT INTO `auth_permission` VALUES ('29', 'Can change Send Records', '10', 'change_sendrecord');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete Send Records', '10', 'delete_sendrecord');
INSERT INTO `auth_permission` VALUES ('31', 'Can add Games', '11', 'add_coinflipgame');
INSERT INTO `auth_permission` VALUES ('32', 'Can change Games', '11', 'change_coinflipgame');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete Games', '11', 'delete_coinflipgame');
INSERT INTO `auth_permission` VALUES ('34', 'Can add Temp Game Hash', '12', 'add_tempgamehash');
INSERT INTO `auth_permission` VALUES ('35', 'Can change Temp Game Hash', '12', 'change_tempgamehash');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete Temp Game Hash', '12', 'delete_tempgamehash');
INSERT INTO `auth_permission` VALUES ('37', 'Can add message', '13', 'add_message');
INSERT INTO `auth_permission` VALUES ('38', 'Can change message', '13', 'change_message');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete message', '13', 'delete_message');
INSERT INTO `auth_permission` VALUES ('40', 'Can add Site Configs', '14', 'add_siteconfig');
INSERT INTO `auth_permission` VALUES ('41', 'Can change Site Configs', '14', 'change_siteconfig');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete Site Configs', '14', 'delete_siteconfig');
INSERT INTO `auth_permission` VALUES ('43', 'Can add User Posts', '15', 'add_userpost');
INSERT INTO `auth_permission` VALUES ('44', 'Can change User Posts', '15', 'change_userpost');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete User Posts', '15', 'delete_userpost');
INSERT INTO `auth_permission` VALUES ('46', 'Can add Betting Bots', '16', 'add_bettingbot');
INSERT INTO `auth_permission` VALUES ('47', 'Can change Betting Bots', '16', 'change_bettingbot');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete Betting Bots', '16', 'delete_bettingbot');
INSERT INTO `auth_permission` VALUES ('49', 'Can add steamrobot api item', '17', 'add_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('50', 'Can change steamrobot api item', '17', 'change_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete steamrobot api item', '17', 'delete_steamrobotapiitem');
INSERT INTO `auth_permission` VALUES ('52', 'Can add market item', '18', 'add_marketitem');
INSERT INTO `auth_permission` VALUES ('53', 'Can change market item', '18', 'change_marketitem');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete market item', '18', 'delete_marketitem');
INSERT INTO `auth_permission` VALUES ('55', 'Can add News', '19', 'add_article');
INSERT INTO `auth_permission` VALUES ('56', 'Can change News', '19', 'change_article');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete News', '19', 'delete_article');
INSERT INTO `auth_permission` VALUES ('58', 'Can add room', '20', 'add_room');
INSERT INTO `auth_permission` VALUES ('59', 'Can change room', '20', 'change_room');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete room', '20', 'delete_room');
INSERT INTO `auth_permission` VALUES ('61', 'Can add F coins Records', '21', 'add_fcoinsrecord');
INSERT INTO `auth_permission` VALUES ('62', 'Can change F coins Records', '21', 'change_fcoinsrecord');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete F coins Records', '21', 'delete_fcoinsrecord');
INSERT INTO `auth_permission` VALUES ('64', 'Can add Give Away', '22', 'add_giveaway');
INSERT INTO `auth_permission` VALUES ('65', 'Can change Give Away', '22', 'change_giveaway');
INSERT INTO `auth_permission` VALUES ('66', 'Can delete Give Away', '22', 'delete_giveaway');
INSERT INTO `auth_permission` VALUES ('67', 'Can add affiliate', '23', 'add_affiliate');
INSERT INTO `auth_permission` VALUES ('68', 'Can change affiliate', '23', 'change_affiliate');
INSERT INTO `auth_permission` VALUES ('69', 'Can delete affiliate', '23', 'delete_affiliate');
INSERT INTO `auth_permission` VALUES ('70', 'Can add Carousel', '24', 'add_carousel');
INSERT INTO `auth_permission` VALUES ('71', 'Can change Carousel', '24', 'change_carousel');
INSERT INTO `auth_permission` VALUES ('72', 'Can delete Carousel', '24', 'delete_carousel');
INSERT INTO `auth_permission` VALUES ('73', 'Can add Prop Items', '25', 'add_propitem');
INSERT INTO `auth_permission` VALUES ('74', 'Can change Prop Items', '25', 'change_propitem');
INSERT INTO `auth_permission` VALUES ('75', 'Can delete Prop Items', '25', 'delete_propitem');
INSERT INTO `auth_permission` VALUES ('76', 'Can add Deposit', '26', 'add_deposit');
INSERT INTO `auth_permission` VALUES ('77', 'Can change Deposit', '26', 'change_deposit');
INSERT INTO `auth_permission` VALUES ('78', 'Can delete Deposit', '26', 'delete_deposit');
INSERT INTO `auth_permission` VALUES ('79', 'Can add Store Records', '27', 'add_storerecord');
INSERT INTO `auth_permission` VALUES ('80', 'Can change Store Records', '27', 'change_storerecord');
INSERT INTO `auth_permission` VALUES ('81', 'Can delete Store Records', '27', 'delete_storerecord');
INSERT INTO `auth_permission` VALUES ('82', 'Can add Video', '28', 'add_video');
INSERT INTO `auth_permission` VALUES ('83', 'Can change Video', '28', 'change_video');
INSERT INTO `auth_permission` VALUES ('84', 'Can delete Video', '28', 'delete_video');
INSERT INTO `auth_permission` VALUES ('85', 'Can add Announcements', '29', 'add_announcement');
INSERT INTO `auth_permission` VALUES ('86', 'Can change Announcements', '29', 'change_announcement');
INSERT INTO `auth_permission` VALUES ('87', 'Can delete Announcements', '29', 'delete_announcement');
INSERT INTO `auth_permission` VALUES ('88', 'Can add steam user', '30', 'add_steamuser');
INSERT INTO `auth_permission` VALUES ('89', 'Can change steam user', '30', 'change_steamuser');
INSERT INTO `auth_permission` VALUES ('90', 'Can delete steam user', '30', 'delete_steamuser');
INSERT INTO `auth_permission` VALUES ('91', 'Can add association', '31', 'add_association');
INSERT INTO `auth_permission` VALUES ('92', 'Can change association', '31', 'change_association');
INSERT INTO `auth_permission` VALUES ('93', 'Can delete association', '31', 'delete_association');
INSERT INTO `auth_permission` VALUES ('94', 'Can add user social auth', '32', 'add_usersocialauth');
INSERT INTO `auth_permission` VALUES ('95', 'Can change user social auth', '32', 'change_usersocialauth');
INSERT INTO `auth_permission` VALUES ('96', 'Can delete user social auth', '32', 'delete_usersocialauth');
INSERT INTO `auth_permission` VALUES ('97', 'Can add nonce', '33', 'add_nonce');
INSERT INTO `auth_permission` VALUES ('98', 'Can change nonce', '33', 'change_nonce');
INSERT INTO `auth_permission` VALUES ('99', 'Can delete nonce', '33', 'delete_nonce');
INSERT INTO `auth_permission` VALUES ('100', 'Can add code', '34', 'add_code');
INSERT INTO `auth_permission` VALUES ('101', 'Can change code', '34', 'change_code');
INSERT INTO `auth_permission` VALUES ('102', 'Can delete code', '34', 'delete_code');
INSERT INTO `auth_permission` VALUES ('103', 'Can add partial', '35', 'add_partial');
INSERT INTO `auth_permission` VALUES ('104', 'Can change partial', '35', 'change_partial');
INSERT INTO `auth_permission` VALUES ('105', 'Can delete partial', '35', 'delete_partial');

-- ----------------------------
-- Table structure for betting_affiliate
-- ----------------------------
DROP TABLE IF EXISTS `betting_affiliate`;
CREATE TABLE `betting_affiliate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `f_coins` int(11) NOT NULL,
  `affi_code` varchar(64) DEFAULT NULL,
  `can_buy` tinyint(1) NOT NULL,
  `is_new` tinyint(1) NOT NULL,
  `higher_id` int(11) DEFAULT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `steamer_id` (`steamer_id`),
  KEY `betting_affiliate_higher_id_6fffff6f_fk_social_auth_steamuser_id` (`higher_id`),
  CONSTRAINT `betting_affiliate_higher_id_6fffff6f_fk_social_auth_steamuser_id` FOREIGN KEY (`higher_id`) REFERENCES `social_auth_steamuser` (`id`),
  CONSTRAINT `betting_affiliate_steamer_id_e7563105_fk_social_au` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_affiliate
-- ----------------------------

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
-- Table structure for betting_article
-- ----------------------------
DROP TABLE IF EXISTS `betting_article`;
CREATE TABLE `betting_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(64) NOT NULL,
  `summary` longtext NOT NULL,
  `content_html` longtext NOT NULL,
  `views` int(11) NOT NULL,
  `published_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `pic` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_article
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
-- Table structure for betting_carousel
-- ----------------------------
DROP TABLE IF EXISTS `betting_carousel`;
CREATE TABLE `betting_carousel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `index` int(11) NOT NULL,
  `href` varchar(200) DEFAULT NULL,
  `pic` varchar(100) NOT NULL,
  `description` longtext,
  `remark` varchar(128) NOT NULL,
  `enable` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_carousel
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_coinflipgame
-- ----------------------------

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
-- Table structure for betting_fcoinsrecord
-- ----------------------------
DROP TABLE IF EXISTS `betting_fcoinsrecord`;
CREATE TABLE `betting_fcoinsrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(63) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `amount` double NOT NULL,
  `trade_ts` datetime(6) NOT NULL,
  `steamer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `betting_fcoinsrecord_steamer_id_6a6230f2_fk_social_au` (`steamer_id`),
  CONSTRAINT `betting_fcoinsrecord_steamer_id_6a6230f2_fk_social_au` FOREIGN KEY (`steamer_id`) REFERENCES `social_auth_steamuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_fcoinsrecord
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
  `amount` double NOT NULL,
  `rarity` varchar(128) DEFAULT NULL,
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
-- Table structure for betting_propitem_f_coins_record
-- ----------------------------
DROP TABLE IF EXISTS `betting_propitem_f_coins_record`;
CREATE TABLE `betting_propitem_f_coins_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `propitem_id` int(11) NOT NULL,
  `fcoinsrecord_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `betting_propitem_F_coins_propitem_id_fcoinsrecord_9fd4039e_uniq` (`propitem_id`,`fcoinsrecord_id`),
  KEY `betting_propitem_F_c_fcoinsrecord_id_ed5c206b_fk_betting_f` (`fcoinsrecord_id`),
  CONSTRAINT `betting_propitem_F_c_fcoinsrecord_id_ed5c206b_fk_betting_f` FOREIGN KEY (`fcoinsrecord_id`) REFERENCES `betting_fcoinsrecord` (`id`),
  CONSTRAINT `betting_propitem_F_c_propitem_id_efe385fa_fk_betting_p` FOREIGN KEY (`propitem_id`) REFERENCES `betting_propitem` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_propitem_f_coins_record
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
  `bot_msg` longtext,
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
  `bot_msg` longtext,
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
-- Table structure for betting_video
-- ----------------------------
DROP TABLE IF EXISTS `betting_video`;
CREATE TABLE `betting_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site` int(11) NOT NULL,
  `room` varchar(64) NOT NULL,
  `index` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_video
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('3', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('5', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('23', 'betting', 'affiliate');
INSERT INTO `django_content_type` VALUES ('29', 'betting', 'announcement');
INSERT INTO `django_content_type` VALUES ('19', 'betting', 'article');
INSERT INTO `django_content_type` VALUES ('16', 'betting', 'bettingbot');
INSERT INTO `django_content_type` VALUES ('24', 'betting', 'carousel');
INSERT INTO `django_content_type` VALUES ('11', 'betting', 'coinflipgame');
INSERT INTO `django_content_type` VALUES ('26', 'betting', 'deposit');
INSERT INTO `django_content_type` VALUES ('21', 'betting', 'fcoinsrecord');
INSERT INTO `django_content_type` VALUES ('22', 'betting', 'giveaway');
INSERT INTO `django_content_type` VALUES ('18', 'betting', 'marketitem');
INSERT INTO `django_content_type` VALUES ('13', 'betting', 'message');
INSERT INTO `django_content_type` VALUES ('25', 'betting', 'propitem');
INSERT INTO `django_content_type` VALUES ('20', 'betting', 'room');
INSERT INTO `django_content_type` VALUES ('10', 'betting', 'sendrecord');
INSERT INTO `django_content_type` VALUES ('14', 'betting', 'siteconfig');
INSERT INTO `django_content_type` VALUES ('17', 'betting', 'steamrobotapiitem');
INSERT INTO `django_content_type` VALUES ('27', 'betting', 'storerecord');
INSERT INTO `django_content_type` VALUES ('12', 'betting', 'tempgamehash');
INSERT INTO `django_content_type` VALUES ('15', 'betting', 'userpost');
INSERT INTO `django_content_type` VALUES ('9', 'betting', 'userprofile');
INSERT INTO `django_content_type` VALUES ('28', 'betting', 'video');
INSERT INTO `django_content_type` VALUES ('6', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('2', 'jet', 'bookmark');
INSERT INTO `django_content_type` VALUES ('1', 'jet', 'pinnedapplication');
INSERT INTO `django_content_type` VALUES ('7', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('8', 'sites', 'site');
INSERT INTO `django_content_type` VALUES ('30', 'social_auth', 'steamuser');
INSERT INTO `django_content_type` VALUES ('31', 'social_django', 'association');
INSERT INTO `django_content_type` VALUES ('34', 'social_django', 'code');
INSERT INTO `django_content_type` VALUES ('33', 'social_django', 'nonce');
INSERT INTO `django_content_type` VALUES ('35', 'social_django', 'partial');
INSERT INTO `django_content_type` VALUES ('32', 'social_django', 'usersocialauth');

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
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2017-10-12 01:41:49.776000');
INSERT INTO `django_migrations` VALUES ('2', 'admin', '0001_initial', '2017-10-12 01:41:50.382000');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0002_logentry_remove_auto_add', '2017-10-12 01:41:50.393000');
INSERT INTO `django_migrations` VALUES ('4', 'contenttypes', '0002_remove_content_type_name', '2017-10-12 01:41:50.796000');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0001_initial', '2017-10-12 01:41:52.020000');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2017-10-12 01:41:52.175000');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2017-10-12 01:41:52.195000');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2017-10-12 01:41:52.243000');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2017-10-12 01:41:52.255000');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2017-10-12 01:41:52.258000');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2017-10-12 01:41:52.268000');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0008_alter_user_username_max_length', '2017-10-12 01:41:52.279000');
INSERT INTO `django_migrations` VALUES ('13', 'betting', '0001_initial', '2017-10-12 01:41:57.680000');
INSERT INTO `django_migrations` VALUES ('14', 'jet', '0001_initial', '2017-10-12 01:41:58.089000');
INSERT INTO `django_migrations` VALUES ('15', 'jet', '0002_delete_userdashboardmodule', '2017-10-12 01:41:58.174000');
INSERT INTO `django_migrations` VALUES ('16', 'sessions', '0001_initial', '2017-10-12 01:41:58.351000');
INSERT INTO `django_migrations` VALUES ('17', 'sites', '0001_initial', '2017-10-12 01:41:58.494000');
INSERT INTO `django_migrations` VALUES ('18', 'sites', '0002_alter_domain_unique', '2017-10-12 01:41:58.522000');
INSERT INTO `django_migrations` VALUES ('19', 'default', '0001_initial', '2017-10-12 01:41:59.302000');
INSERT INTO `django_migrations` VALUES ('20', 'social_auth', '0001_initial', '2017-10-12 01:41:59.307000');
INSERT INTO `django_migrations` VALUES ('21', 'default', '0002_add_related_name', '2017-10-12 01:41:59.475000');
INSERT INTO `django_migrations` VALUES ('22', 'social_auth', '0002_add_related_name', '2017-10-12 01:41:59.480000');
INSERT INTO `django_migrations` VALUES ('23', 'default', '0003_alter_email_max_length', '2017-10-12 01:41:59.573000');
INSERT INTO `django_migrations` VALUES ('24', 'social_auth', '0003_alter_email_max_length', '2017-10-12 01:41:59.577000');
INSERT INTO `django_migrations` VALUES ('25', 'default', '0004_auto_20160423_0400', '2017-10-12 01:41:59.609000');
INSERT INTO `django_migrations` VALUES ('26', 'social_auth', '0004_auto_20160423_0400', '2017-10-12 01:41:59.613000');
INSERT INTO `django_migrations` VALUES ('27', 'social_auth', '0005_auto_20160727_2333', '2017-10-12 01:41:59.638000');
INSERT INTO `django_migrations` VALUES ('28', 'social_django', '0006_partial', '2017-10-12 01:41:59.743000');
INSERT INTO `django_migrations` VALUES ('29', 'social_django', '0002_add_related_name', '2017-10-12 01:41:59.751000');
INSERT INTO `django_migrations` VALUES ('30', 'social_django', '0003_alter_email_max_length', '2017-10-12 01:41:59.755000');
INSERT INTO `django_migrations` VALUES ('31', 'social_django', '0001_initial', '2017-10-12 01:41:59.759000');
INSERT INTO `django_migrations` VALUES ('32', 'social_django', '0004_auto_20160423_0400', '2017-10-12 01:41:59.763000');
INSERT INTO `django_migrations` VALUES ('33', 'social_django', '0005_auto_20160727_2333', '2017-10-12 01:41:59.793000');

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
  `date_joined` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `tradeurl` varchar(300) NOT NULL,
  `level` int(11) NOT NULL,
  `is_cheating` tinyint(1) NOT NULL,
  `can_chat` tinyint(1) NOT NULL,
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
