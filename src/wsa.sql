/*
Navicat MySQL Data Transfer

Source Server         : wechat_sever
Source Server Version : 50538
Source Host           : 10.10.65.172:3306
Source Database       : wsa

Target Server Type    : MYSQL
Target Server Version : 50538
File Encoding         : 65001

Date: 2016-08-08 14:52:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for crawl_article
-- ----------------------------
DROP TABLE IF EXISTS `crawl_article`;
CREATE TABLE `crawl_article` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `url` varchar(1000) DEFAULT NULL,
  `wx_name` varchar(100) DEFAULT NULL,
  `publish_time` datetime DEFAULT NULL,
  `crawl_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3093 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for temp_data
-- ----------------------------
DROP TABLE IF EXISTS `temp_data`;
CREATE TABLE `temp_data` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `biz` varchar(16) NOT NULL,
  `mid` varchar(16) NOT NULL,
  `idx` int(4) NOT NULL,
  `sn` varchar(32) NOT NULL,
  `read_num` int(8) DEFAULT NULL,
  `like_num` int(8) DEFAULT NULL,
  `real_read_num` int(8) DEFAULT NULL,
  `crawl_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25238 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `official_account` varchar(20) NOT NULL COMMENT '公众号的账号',
  `publish_time` datetime NOT NULL COMMENT '文章发布时间',
  `title` varchar(255) DEFAULT NULL COMMENT '文章标题',
  `summary` varchar(1000) DEFAULT NULL COMMENT '文章摘要',
  `url` varchar(255) DEFAULT NULL COMMENT '文章地址',
  `add_time` datetime DEFAULT NULL COMMENT '文章信息入库时间',
  `ranking` int(11) DEFAULT NULL COMMENT '文章当天推送位置排行，1为头条，其他为位置顺序',
  `source_url` varchar(1000) DEFAULT NULL COMMENT '原文地址',
  `author` varchar(20) DEFAULT NULL COMMENT '微信文章作者',
  `copyright` varchar(10) NOT NULL DEFAULT '3' COMMENT '1原创|2非原创|3未知',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`,`official_account`,`publish_time`),
  UNIQUE KEY `official_account` (`official_account`,`publish_time`,`ranking`),
  KEY `official_account_index` (`official_account`),
  KEY `publish_time_index` (`publish_time`)
) ENGINE=InnoDB AUTO_INCREMENT=136271 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for test_data
-- ----------------------------
DROP TABLE IF EXISTS `test_data`;
CREATE TABLE `test_data` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `article_id` int(8) DEFAULT NULL,
  `read_count` int(11) DEFAULT NULL COMMENT '阅读总数',
  `like_count` int(11) DEFAULT NULL COMMENT '点赞总数',
  `add_time` datetime DEFAULT NULL COMMENT '数据入库时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`),
  KEY `article_id_index` (`article_id`),
  KEY `add_time_index` (`add_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2786 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for test_wsa_article
-- ----------------------------
DROP TABLE IF EXISTS `test_wsa_article`;
CREATE TABLE `test_wsa_article` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `official_account` varchar(20) NOT NULL COMMENT '公众号的账号',
  `publish_time` datetime NOT NULL COMMENT '文章发布时间',
  `title` varchar(255) DEFAULT NULL COMMENT '文章标题',
  `summary` varchar(1000) DEFAULT NULL COMMENT '文章摘要',
  `url` varchar(255) DEFAULT NULL COMMENT '文章地址',
  `add_time` datetime DEFAULT NULL COMMENT '文章信息入库时间',
  `ranking` int(11) DEFAULT NULL COMMENT '文章当天推送位置排行，1为头条，其他为位置顺序',
  `source_url` varchar(1000) DEFAULT NULL COMMENT '原文地址',
  `author` varchar(20) DEFAULT NULL COMMENT '微信文章作者',
  `copyright` varchar(10) NOT NULL DEFAULT '3' COMMENT '1原创|2非原创|3未知',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`,`official_account`,`publish_time`),
  KEY `official_account_index` (`official_account`),
  KEY `publish_time_index` (`publish_time`)
) ENGINE=InnoDB AUTO_INCREMENT=7036 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for test_wsa_article_content
-- ----------------------------
DROP TABLE IF EXISTS `test_wsa_article_content`;
CREATE TABLE `test_wsa_article_content` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `article_id` int(4) DEFAULT NULL,
  `content` longtext,
  `size` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_id` (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=554 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for test_wsa_official_account
-- ----------------------------
DROP TABLE IF EXISTS `test_wsa_official_account`;
CREATE TABLE `test_wsa_official_account` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `official_account` varchar(20) NOT NULL COMMENT '公众号账号',
  `nickname` varchar(50) DEFAULT NULL COMMENT '公众号名字',
  `biz` varchar(16) NOT NULL COMMENT '官方biz，即腾讯对外公布的公众号的唯一标识符',
  `type` int(2) DEFAULT NULL COMMENT '公众号类型',
  `qr_code` varchar(255) DEFAULT NULL COMMENT '公众号二维码地址',
  `description` varchar(255) DEFAULT NULL COMMENT '公众号描述',
  `authentication` varchar(800) DEFAULT NULL COMMENT '是否认证',
  `authentication_info` varchar(800) DEFAULT NULL COMMENT '认证信息',
  `country` varchar(100) DEFAULT NULL COMMENT '公众号国家',
  `province` varchar(50) DEFAULT NULL COMMENT '公众号省份',
  `city` varchar(20) DEFAULT NULL COMMENT '公众号城市',
  `add_time` datetime DEFAULT NULL COMMENT '加入数据库时间',
  `status` int(3) DEFAULT '1' COMMENT '公众号状态',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除,0未删除，1删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `O_UK` (`official_account`) USING BTREE COMMENT '账号名不能重复',
  UNIQUE KEY `B_UK` (`biz`) USING BTREE COMMENT 'biz唯一标示符不可重复'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_article
-- ----------------------------
DROP TABLE IF EXISTS `wsa_article`;
CREATE TABLE `wsa_article` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `official_account` varchar(20) NOT NULL COMMENT '公众号的账号',
  `publish_time` datetime NOT NULL COMMENT '文章发布时间',
  `title` varchar(255) DEFAULT NULL COMMENT '文章标题',
  `summary` varchar(1000) DEFAULT NULL COMMENT '文章摘要',
  `url` varchar(255) DEFAULT NULL COMMENT '文章地址',
  `add_time` datetime DEFAULT NULL COMMENT '文章信息入库时间',
  `ranking` int(11) DEFAULT NULL COMMENT '文章当天推送位置排行，1为头条，其他为位置顺序',
  `source_url` varchar(1000) DEFAULT NULL COMMENT '原文地址',
  `author` varchar(20) DEFAULT NULL COMMENT '微信文章作者',
  `copyright` varchar(10) NOT NULL DEFAULT '3' COMMENT '1原创|2非原创|3未知',
  `delete_time` datetime DEFAULT NULL COMMENT '最后一次修改/删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '文章状态,1删除，0正常，2修改',
  PRIMARY KEY (`id`,`official_account`,`publish_time`),
  UNIQUE KEY `official_account` (`official_account`,`publish_time`,`ranking`),
  KEY `official_account_index` (`official_account`),
  KEY `publish_time_index` (`publish_time`)
) ENGINE=InnoDB AUTO_INCREMENT=156147 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_article_content
-- ----------------------------
DROP TABLE IF EXISTS `wsa_article_content`;
CREATE TABLE `wsa_article_content` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `article_id` int(4) DEFAULT NULL,
  `content` longtext,
  `size` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_id` (`article_id`),
  CONSTRAINT `fk_id` FOREIGN KEY (`article_id`) REFERENCES `wsa_article` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13976 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for wsa_article_stats
-- ----------------------------
DROP TABLE IF EXISTS `wsa_article_stats`;
CREATE TABLE `wsa_article_stats` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `article_id` int(8) DEFAULT NULL,
  `read_count` int(11) DEFAULT NULL COMMENT '阅读总数',
  `like_count` int(11) DEFAULT NULL COMMENT '点赞总数',
  `add_time` datetime DEFAULT NULL COMMENT '数据入库时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`),
  KEY `article_id_index` (`article_id`),
  KEY `add_time_index` (`add_time`)
) ENGINE=InnoDB AUTO_INCREMENT=311339 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_clean
-- ----------------------------
DROP TABLE IF EXISTS `wsa_clean`;
CREATE TABLE `wsa_clean` (
  `wx_name` varchar(100) DEFAULT NULL,
  `wx_nickname` varchar(100) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_daily_statistics
-- ----------------------------
DROP TABLE IF EXISTS `wsa_daily_statistics`;
CREATE TABLE `wsa_daily_statistics` (
  `id` int(11) DEFAULT '1',
  `statistics_id` varchar(20) NOT NULL COMMENT '文章或公众号的id',
  `statistics_type` int(1) NOT NULL COMMENT '2表示文章，1表示公众号',
  `read_count` int(11) DEFAULT NULL COMMENT '（每日）阅读数',
  `like_count` int(11) DEFAULT NULL COMMENT '(每日)点赞数',
  `article_count` int(4) DEFAULT NULL,
  `date` date NOT NULL DEFAULT '1995-01-01' COMMENT '日期，表明是哪一天的数据',
  `delete_time` datetime DEFAULT NULL COMMENT '除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`statistics_id`,`date`),
  KEY `index2` (`statistics_id`),
  KEY `index3` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_group
-- ----------------------------
DROP TABLE IF EXISTS `wsa_group`;
CREATE TABLE `wsa_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '分组名称',
  `description` varchar(255) DEFAULT NULL COMMENT '分组描述',
  `tags` varchar(255) DEFAULT NULL COMMENT '分组标签',
  `official_accounts` text COMMENT '分组内的公众号的ids，以'',''分隔',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_group_copy
-- ----------------------------
DROP TABLE IF EXISTS `wsa_group_copy`;
CREATE TABLE `wsa_group_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '分组名称',
  `description` varchar(255) DEFAULT NULL COMMENT '分组描述',
  `tags` varchar(255) DEFAULT NULL COMMENT '分组标签',
  `official_accounts` text COMMENT '分组内的公众号的ids，以'',''分隔',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_group_stats
-- ----------------------------
DROP TABLE IF EXISTS `wsa_group_stats`;
CREATE TABLE `wsa_group_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL COMMENT '公众号分组',
  `account_count` varchar(30) DEFAULT NULL COMMENT '公众号总数',
  `article_count` varchar(30) DEFAULT NULL COMMENT '文章总数',
  `read_count` varchar(50) DEFAULT NULL COMMENT '阅读总数',
  `like_count` varchar(50) DEFAULT NULL COMMENT '点赞总数',
  `add_time` datetime DEFAULT NULL COMMENT '数据入库时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for wsa_official_account
-- ----------------------------
DROP TABLE IF EXISTS `wsa_official_account`;
CREATE TABLE `wsa_official_account` (
  `id` int(11) NOT NULL,
  `official_account` varchar(20) NOT NULL COMMENT '公众号账号',
  `nickname` varchar(50) DEFAULT NULL COMMENT '公众号名字',
  `biz` varchar(16) NOT NULL COMMENT '官方biz，即腾讯对外公布的公众号的唯一标识符',
  `type` int(2) DEFAULT NULL COMMENT '公众号类型',
  `qr_code` varchar(255) DEFAULT NULL COMMENT '公众号二维码地址',
  `description` varchar(255) DEFAULT NULL COMMENT '公众号描述',
  `authentication` varchar(800) DEFAULT NULL COMMENT '是否认证',
  `authentication_info` varchar(800) DEFAULT NULL COMMENT '认证信息',
  `country` varchar(100) DEFAULT NULL COMMENT '公众号国家',
  `province` varchar(50) DEFAULT NULL COMMENT '公众号省份',
  `city` varchar(20) DEFAULT NULL COMMENT '公众号城市',
  `latest_article_title` varchar(255) DEFAULT NULL COMMENT '最新发布文章标题',
  `latest_article_url` varchar(255) DEFAULT NULL COMMENT '最新发布文章链接',
  `latest_article_publishtime` datetime DEFAULT NULL COMMENT '最新发布文章发布时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_status` int(1) DEFAULT NULL COMMENT '更新状态',
  `status` int(3) DEFAULT '1' COMMENT '公众号状态',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除,0未删除，1删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `O_UK` (`official_account`) USING BTREE COMMENT '账号名不能重复',
  UNIQUE KEY `B_UK` (`biz`) USING BTREE COMMENT 'biz唯一标示符不可重复'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_official_account_copy
-- ----------------------------
DROP TABLE IF EXISTS `wsa_official_account_copy`;
CREATE TABLE `wsa_official_account_copy` (
  `id` int(11) NOT NULL,
  `official_account` varchar(20) NOT NULL COMMENT '公众号账号',
  `nickname` varchar(50) DEFAULT NULL COMMENT '公众号名字',
  `biz` varchar(16) NOT NULL COMMENT '官方biz，即腾讯对外公布的公众号的唯一标识符',
  `type` int(2) DEFAULT NULL COMMENT '公众号类型',
  `qr_code` varchar(255) DEFAULT NULL COMMENT '公众号二维码地址',
  `description` varchar(255) DEFAULT NULL COMMENT '公众号描述',
  `authentication` varchar(800) DEFAULT NULL COMMENT '是否认证',
  `authentication_info` varchar(800) DEFAULT NULL COMMENT '认证信息',
  `country` varchar(100) DEFAULT NULL COMMENT '公众号国家',
  `province` varchar(50) DEFAULT NULL COMMENT '公众号省份',
  `city` varchar(20) DEFAULT NULL COMMENT '公众号城市',
  `latest_article_title` varchar(255) DEFAULT NULL COMMENT '最新发布文章标题',
  `latest_article_url` varchar(255) DEFAULT NULL COMMENT '最新发布文章链接',
  `latest_article_publishtime` datetime DEFAULT NULL COMMENT '最新发布文章发布时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_status` int(1) DEFAULT NULL COMMENT '更新状态',
  `status` int(3) DEFAULT '1' COMMENT '公众号状态',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除,0未删除，1删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `O_UK` (`official_account`) USING BTREE COMMENT '账号名不能重复',
  UNIQUE KEY `B_UK` (`biz`) USING BTREE COMMENT 'biz唯一标示符不可重复'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_other_rank_lists
-- ----------------------------
DROP TABLE IF EXISTS `wsa_other_rank_lists`;
CREATE TABLE `wsa_other_rank_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL COMMENT '文章标题',
  `category` varchar(100) NOT NULL COMMENT '文章分类',
  `url` varchar(200) NOT NULL COMMENT '文章链接',
  `date` date NOT NULL COMMENT '日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2418 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_role
-- ----------------------------
DROP TABLE IF EXISTS `wsa_role`;
CREATE TABLE `wsa_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '角色名称',
  `description` varchar(200) DEFAULT NULL COMMENT '角色描述',
  `rank` int(4) DEFAULT NULL COMMENT '角色等级排名',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT '角色状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_role_priv
-- ----------------------------
DROP TABLE IF EXISTS `wsa_role_priv`;
CREATE TABLE `wsa_role_priv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '角色表中对应的角色id',
  `module` varchar(45) DEFAULT NULL COMMENT '模块名（一般为controller名）',
  `method` varchar(45) DEFAULT NULL COMMENT '方法（页面、按钮等）名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_user
-- ----------------------------
DROP TABLE IF EXISTS `wsa_user`;
CREATE TABLE `wsa_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(20) NOT NULL COMMENT '账号',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `role_id` int(11) NOT NULL COMMENT '权限分组',
  `realname` varchar(30) DEFAULT NULL COMMENT '真实姓名',
  `gender` varchar(1) DEFAULT NULL COMMENT 'f表示女，m表示男',
  `email` varchar(30) DEFAULT NULL COMMENT '邮箱',
  `qq` varchar(20) DEFAULT NULL COMMENT 'ｑｑ号',
  `mobile` varchar(12) DEFAULT NULL COMMENT '手机号码',
  `visits` int(4) DEFAULT NULL COMMENT '登录次数',
  `ip` varchar(30) DEFAULT NULL COMMENT '最后一次登录IP',
  `login_time` datetime DEFAULT NULL COMMENT '最后一次登录时间（时间戳）',
  `fails` int(2) DEFAULT NULL COMMENT '登录失败次数',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `update_time` datetime DEFAULT NULL COMMENT '信息修改时间',
  `locked` datetime DEFAULT NULL COMMENT '账号被锁定时间',
  `verification_code` varchar(8) DEFAULT NULL COMMENT '验证码',
  `verification_code_time` datetime DEFAULT NULL COMMENT '验证码发送时间',
  `status` int(1) DEFAULT NULL COMMENT '账号状态，1为可用，0为禁用',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '1:表示已删除，0表示未删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `A_UK` (`account`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wsa_weekly_statistics
-- ----------------------------
DROP TABLE IF EXISTS `wsa_weekly_statistics`;
CREATE TABLE `wsa_weekly_statistics` (
  `id` int(11) DEFAULT '1',
  `official_account_id` int(11) NOT NULL DEFAULT '0' COMMENT '公众号id',
  `date` date NOT NULL DEFAULT '1995-01-01' COMMENT '日期',
  `push_times` int(2) DEFAULT NULL COMMENT '一周推送次数',
  `top_article_readnum` int(11) DEFAULT NULL COMMENT '头条阅读总数',
  `top_article_readnum_change` int(11) DEFAULT NULL COMMENT '头条阅读总数变化',
  `article_count` int(4) DEFAULT NULL COMMENT '文章总数',
  `article_count_change` int(4) DEFAULT NULL COMMENT '文章总数变化',
  `article_count_10w` int(4) DEFAULT NULL COMMENT '阅读量超过10w的文章数',
  `article_count_10w_change` int(4) DEFAULT NULL COMMENT '阅读量超过10w的文章数的变化',
  `total_readnum` int(11) DEFAULT NULL COMMENT '总阅读量',
  `total_readnum_change` int(11) DEFAULT NULL COMMENT '总阅读量变化',
  `ave_readnum` int(11) DEFAULT NULL COMMENT '平均阅读量',
  `ave_readnum_change` int(11) DEFAULT NULL COMMENT '平均阅读量变化',
  `total_likenum` int(11) DEFAULT NULL COMMENT '总点赞数',
  `total_likenum_change` int(11) DEFAULT NULL COMMENT '总点赞数变化',
  `ave_likenum` int(11) DEFAULT NULL COMMENT '平均点赞数',
  `ave_likenum_change` int(11) DEFAULT NULL COMMENT '平均点赞数变化',
  `max_readnum` int(11) DEFAULT NULL COMMENT '最大阅读数',
  `max_likenum` int(11) DEFAULT NULL COMMENT '最大点赞数',
  `like_rate` double(10,4) DEFAULT NULL COMMENT '点赞率',
  `ranking` int(11) DEFAULT NULL COMMENT '排行名',
  `ranking_change` int(11) DEFAULT NULL COMMENT '排行变化',
  `WCI` double(10,4) DEFAULT NULL,
  `WCI_UP` double(10,4) DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`official_account_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET FOREIGN_KEY_CHECKS=1;
