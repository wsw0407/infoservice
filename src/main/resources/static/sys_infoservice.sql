/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.7.27-log : Database - sys_infoservice
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sys_infoservice` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sys_infoservice`;

/*Table structure for table `sys_account` */

DROP TABLE IF EXISTS `sys_account`;

CREATE TABLE `sys_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL COMMENT '账号',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `pic` varchar(255) DEFAULT NULL COMMENT '图片头像',
  `username` varchar(255) DEFAULT NULL COMMENT '昵称',
  `role` int(11) DEFAULT NULL COMMENT '权限/角色',
  `userid` int(11) DEFAULT NULL COMMENT '关联详细用户信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_user_id` (`userid`),
  KEY `key_account_role_id` (`role`),
  CONSTRAINT `key_account_role_id` FOREIGN KEY (`role`) REFERENCES `sys_role` (`id`),
  CONSTRAINT `key_account_user_id` FOREIGN KEY (`userid`) REFERENCES `sys_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `sys_account` */

insert  into `sys_account`(`id`,`account`,`password`,`pic`,`username`,`role`,`userid`) values (1,'admin','admin123','/img/001_20210505204412393.gif','超级管理员',1,1),(2,'wsw','wsw123','/images/001.gif','wsws',2,3),(3,'dahu','dahu123','/img/0001_20210504220842543.jpg','dahu',2,4),(4,'xiaohuang','123456','/images/001.gif','xiaohuang',2,5),(9,'wsw','ssssss','/images/001.gif','shss',2,12),(15,'wsw','111111','/images/001.gif','ddddddd',2,23),(21,'wsws','ssssss','/images/001.gif','wsws',2,30),(22,'sssssss','wwwwww','/images/001.gif','w',2,31),(23,'sss','123456','/images/001.gif','一个昵称',2,32);

/*Table structure for table `sys_adminclass` */

DROP TABLE IF EXISTS `sys_adminclass`;

CREATE TABLE `sys_adminclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classnum` varchar(255) DEFAULT NULL COMMENT '班级编码',
  `majar_id` int(11) DEFAULT NULL COMMENT '所属专业',
  PRIMARY KEY (`id`),
  KEY `key_class_majar` (`majar_id`),
  CONSTRAINT `key_class_majar` FOREIGN KEY (`majar_id`) REFERENCES `sys_majar` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

/*Data for the table `sys_adminclass` */

insert  into `sys_adminclass`(`id`,`classnum`,`majar_id`) values (1,'B170401',28),(2,'B170402',28),(3,'B170403',28),(4,'B170404',28),(5,'B170405',28),(6,'B170406',29),(7,'B170407',29),(8,'B170408',29),(9,'B170409',29),(10,'B170410',30),(11,'B170411',30),(12,'B170412',31),(13,'B170413',31),(14,'B170101',2),(15,'B170102',2),(16,'B170103',2),(17,'B160103',2),(18,'B180103',2),(19,'B180410',32),(20,'B180410',30),(21,'B180104',2),(29,'B180101',2),(30,'B170104',2),(31,'B180102',2),(32,'B180105',3),(33,'B180106',3),(34,'B170105',3),(35,'B180108',4),(36,'B170106',4),(37,'B170107',4);

/*Table structure for table `sys_classchedule` */

DROP TABLE IF EXISTS `sys_classchedule`;

CREATE TABLE `sys_classchedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inclass` int(255) DEFAULT NULL COMMENT '班级',
  `majarid` int(11) DEFAULT NULL COMMENT '专业',
  `term` int(255) DEFAULT NULL COMMENT '学期',
  PRIMARY KEY (`id`),
  KEY `key_class_inclass` (`inclass`),
  KEY `key_class_majarid` (`majarid`),
  KEY `key_class_term` (`term`),
  CONSTRAINT `key_class_inclass` FOREIGN KEY (`inclass`) REFERENCES `sys_adminclass` (`id`),
  CONSTRAINT `key_class_majarid` FOREIGN KEY (`majarid`) REFERENCES `sys_majar` (`id`),
  CONSTRAINT `key_class_term` FOREIGN KEY (`term`) REFERENCES `sys_term` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

/*Data for the table `sys_classchedule` */

insert  into `sys_classchedule`(`id`,`inclass`,`majarid`,`term`) values (4,4,28,12),(22,3,NULL,12);

/*Table structure for table `sys_classplace` */

DROP TABLE IF EXISTS `sys_classplace`;

CREATE TABLE `sys_classplace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campus` varchar(255) DEFAULT NULL COMMENT ' 校区',
  `classroom` varchar(255) DEFAULT NULL COMMENT ' 教室',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_classplace` */

/*Table structure for table `sys_comment` */

DROP TABLE IF EXISTS `sys_comment`;

CREATE TABLE `sys_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `topic_id` int(11) DEFAULT NULL COMMENT '关联评论的id',
  `from_aid` int(11) DEFAULT NULL COMMENT '回复用户id',
  `to_uid` int(11) DEFAULT NULL COMMENT '回复用户id',
  `creatdate` datetime DEFAULT NULL COMMENT '回复日期',
  PRIMARY KEY (`id`),
  KEY `key_topic_id` (`topic_id`),
  KEY `key_from_actionid` (`from_aid`),
  KEY `key_to_actionid` (`to_uid`),
  CONSTRAINT `key_from_actionid` FOREIGN KEY (`from_aid`) REFERENCES `sys_account` (`id`),
  CONSTRAINT `key_to_actionid` FOREIGN KEY (`to_uid`) REFERENCES `sys_account` (`id`),
  CONSTRAINT `key_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `sys_topics` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `sys_comment` */

insert  into `sys_comment`(`id`,`content`,`topic_id`,`from_aid`,`to_uid`,`creatdate`) values (1,'索尼对科技与艺术的追求才创造出了让人惊喜的作品',1,2,3,'2021-04-15 11:29:13'),(2,'索尼对科技与艺术的追求才创造出了让人惊喜的作品',1,2,9,'2021-04-15 11:29:10'),(8,'A8F沿袭了黑科技“屏幕发声技术”和高清画质，',17,1,3,'2021-04-15 15:57:35'),(9,'。作为A1兄弟款，A8F沿袭了黑科技“屏幕发声技术”和高清画质，色',15,1,15,'2021-04-16 10:35:37'),(10,'。作为A1兄弟款，A8F沿袭了黑科技“屏幕发声技术”和高清画质，色',15,3,4,'2021-04-16 10:35:47'),(12,'sascaca',15,1,4,'2021-04-26 09:57:04'),(13,'sasacsa',15,1,15,'2021-04-26 09:57:33'),(14,'完美诞生。很开心一起参加了A8F的“首映礼”！[鼓掌]正如',23,1,1,'2021-05-04 21:25:59'),(15,'高清画质，色彩的出众表',23,1,1,'2021-05-04 21:26:13');

/*Table structure for table `sys_course` */

DROP TABLE IF EXISTS `sys_course`;

CREATE TABLE `sys_course` (
  `id` int(11) NOT NULL,
  `subjects` varchar(255) DEFAULT NULL COMMENT '科目',
  `teachers` varchar(255) DEFAULT NULL COMMENT '教师',
  `majarid` varchar(255) DEFAULT NULL COMMENT '课程所属专业',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_course` */

/*Table structure for table `sys_courseschedule` */

DROP TABLE IF EXISTS `sys_courseschedule`;

CREATE TABLE `sys_courseschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `week` varchar(255) DEFAULT NULL COMMENT '周几',
  `section` varchar(255) DEFAULT NULL COMMENT '第几节',
  `courseInfo` text COMMENT '课程信息',
  `classId` int(255) DEFAULT NULL COMMENT '课表所属信息的关联ID',
  PRIMARY KEY (`id`),
  KEY `key_course_class` (`classId`),
  CONSTRAINT `key_course_class` FOREIGN KEY (`classId`) REFERENCES `sys_classchedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;

/*Data for the table `sys_courseschedule` */

insert  into `sys_courseschedule`(`id`,`week`,`section`,`courseInfo`,`classId`) values (127,'monday','一','专业英语.\n(任)学分:1.5\n讲授学时:24\n郭福全\n[1-3, 5,9-0周]\n[1-2节]\nEE401\n',4),(128,'wednesday','一','高分子物理\n(必)常分:4.\n讲授学时:64\n范吉景\n[ 1-a,5,.9-15周]\n[1.-2节]\nES301\n',4),(129,'thursday','一','形势与政策(必).\n学分:2\n讲授学时:16\n其它学时:16\n赵壮道\n[1-5,:单周][.1-2节]\nES302',4),(130,'friday','一','高分子材料结构分析(任)学分:15\n讲授学时:24\n未新军\n[1-3;5单周]\n[1-2节]\nDE104\n',4),(131,'monday','二','高分子物理:\n(必)学分:4:0\n讲授学时64\n范吉昌\n[1-3, 5,.8-15周]\n[3-4节]\nEE301\n',4),(132,'tuesday','二','形势与政策(必).\n学分:2\n讲授学时:16\n其它学时:16\n赵壮道\n[1-5,:单周][.1-2节]\nES302',4),(133,'thursday','二','高分子材料结构分析(任)学分:15\n讲授学时:24\n未新军\n[1-3;5单周]\n[1-2节]\nDE104\n',4),(134,'saturday','二','形势与政策(必).\n学分:2\n讲授学时:16\n其它学时:16\n赵壮道\n[1-5,:单周][.1-2节]\nES302',4),(135,'wednesday','三','专业英语.\n(任)学分:1.5\n讲授学时:24\n郭福全\n[1-3, 5,9-0周]\n[1-2节]\nEE401\n',4),(136,'friday','三','专业英语.\n(任)学分:1.5\n讲授学时:24\n郭福全\n[1-3, 5,9-0周]\n[1-2节]\nEE401\n',4),(137,'tuesday','四','专业英语.\n(任)学分:1.5\n讲授学时:24\n郭福全\n[1-3, 5,9-0周]\n[1-2节]\nEE401',4),(138,'monday','一','专业英语.\n(任)学分:1.5\n讲授学时:24\n郭福全\n[1-3, 5,9-0周]\n[1-2节]\nEE401',22),(139,'wednesday','二','专业英语.\n(任)学分:1.5\n讲授学时:24\n郭福全\n[1-3, 5,9-0周]\n[1-2节]\nEE401',22),(140,'tuesday','四','专业英语.\n(任)学分:1.5\n讲授学时:24\n郭福全\n[1-3, 5,9-0周]\n[1-2节]\nEE401',22);

/*Table structure for table `sys_majar` */

DROP TABLE IF EXISTS `sys_majar`;

CREATE TABLE `sys_majar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `institute` varchar(255) DEFAULT NULL COMMENT '学院',
  `majarname` varchar(255) DEFAULT NULL COMMENT '专业名称',
  `institnum` varchar(255) DEFAULT NULL COMMENT '院系代码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

/*Data for the table `sys_majar` */

insert  into `sys_majar`(`id`,`institute`,`majarname`,`institnum`) values (1,'公共专业','公共专业',NULL),(2,'材料科学与工程学院','无机非金属材料工程','01'),(3,'材料科学与工程学院','材料工程技术','01'),(4,'材料科学与工程学院','高分子材料与工程','01'),(5,'材料科学与工程学院','材料物理','01'),(6,'材料科学与工程学院','无机非金属材料工程（专升本）','01'),(7,'材料科学与工程学院','无机非金属材料工程（卓越）','01'),(8,'材料科学与工程学院','高分子材料与工程（专升本）','01'),(9,'材料科学与工程学院','焊接技术与工程','01'),(10,'材料科学与工程学院','材料成型及控制工程','01'),(11,'机械工程学院','机械设计制造及其自动化','02'),(12,'机械工程学院','机械设计与制造','02'),(13,'机械工程学院','机械设计与制造（中俄合作）','02'),(14,'机械工程学院','机械设计制造及其自动化（专升本）','02'),(15,'机械工程学院','车辆工程','02'),(16,'机械工程学院','机械设计制造及其自动化（卓越）','02'),(17,'机械工程学院','机械电子工程','02'),(18,'机械工程学院','汽车服务工程','02'),(19,'机械工程学院','过程装备与控制工程','02'),(20,'电气工程与自动化学院','电气工程及其自动化','03'),(21,'电气工程与自动化学院','自动化','03'),(22,'电气工程与自动化学院','智能控制技术','03'),(25,'电气工程与自动化学院','自动化（卓越）','03'),(26,'电气工程与自动化学院','电气自动化技术','03'),(27,'电气工程与自动化学院','智能科学与技术','03'),(28,'计算机与信息工程学院','计算机科学与技术','04'),(29,'计算机与信息工程学院','计算机应用技术','04'),(30,'计算机与信息工程学院','大数据技术与应用','04'),(31,'计算机与信息工程学院','计算机科学与技术（专升本)','04'),(32,'计算机与信息工程学院','通信工程','04'),(33,'计算机与信息工程学院','计算机信息管理','04'),(34,'计算机与信息工程学院','物联网工程','04'),(35,'计算机与信息工程学院','计算机科学与技术（双学位)','04'),(36,'计算机与信息工程学院','软件工程','04'),(37,'计算机与信息工程学院','数据科学与大数据技术','04'),(38,'土木工程学院','土木工程','05'),(39,'土木工程学院','建筑工程技术','05'),(40,'土木工程学院','王木工程 （专升本）','05'),(41,'土木工程学院','土木工程（卓越）','05'),(42,'土木工程学院','建筑环境与能源应用工程','05'),(43,'土木工程学院','给排水科学与工程','05'),(44,'土木工程学院','土本工程（中爱合作）','05'),(45,'土木工程学院','工程管理','05'),(46,'土木工程学院','工程管理 (专升本)','05'),(47,'土木工程学院','工程造价','05'),(48,'环境工程与化学学院','环境工程','06'),(49,'环境工程与化学学院','工亚分析技术','06'),(50,'环境工程与化学学院','应用化学','06'),(51,'环境工程与化学学院','环境工程 (专升本)','06'),(52,'环境工程与化学学院','生物技术','06'),(53,'环境工程与化学学院','资源循环科学与工程','06'),(54,'经济与管理学院','工商管理','07'),(55,'经济与管理学院','旅游管理','07'),(56,'经济与管理学院','市场营销','07'),(57,'经济与管理学院','工商管理 (专升本)','07'),(58,'经济与管理学院','国际经济与贸易','07'),(59,'经济与管理学院','酒店管理','07'),(60,'经济与管理学院','工商管理 (双学位','07'),(61,'经济与管理学院','国际经济与贸易 (双学位)','07'),(62,'经济与管理学院','电子商务','07');

/*Table structure for table `sys_news` */

DROP TABLE IF EXISTS `sys_news`;

CREATE TABLE `sys_news` (
  `id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `creat_date` datetime DEFAULT NULL COMMENT '创建日期',
  `url` varchar(255) DEFAULT NULL COMMENT '链接',
  `pic` varchar(255) DEFAULT NULL COMMENT '展示图片'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_news` */

/*Table structure for table `sys_notice` */

DROP TABLE IF EXISTS `sys_notice`;

CREATE TABLE `sys_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '活动公告标题',
  `content` text COMMENT '内容描述',
  `releasetime` datetime DEFAULT NULL COMMENT '发布时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束时间',
  `pic` varchar(255) DEFAULT NULL COMMENT '图片',
  `remark` int(11) DEFAULT NULL COMMENT '标记，活动是否有效',
  `link` varchar(255) DEFAULT NULL COMMENT '活动链接，可以转到网页链接',
  PRIMARY KEY (`id`),
  KEY `key_notice_status` (`remark`),
  CONSTRAINT `key_notice_status` FOREIGN KEY (`remark`) REFERENCES `sys_noticestatus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `sys_notice` */

insert  into `sys_notice`(`id`,`title`,`content`,`releasetime`,`endtime`,`pic`,`remark`,`link`) values (1,'2021年全国大学生英语竞赛','<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\">\r\n<h1 class=\"article-title\" style=\"padding-top: 30px; padding-right: 20px; padding-bottom: 10px; margin: 0px; overflow-wrap: break-word; list-style: none; font-size: 24px; color: #434343; position: relative; text-indent: 0px; text-align: left;\">欢迎参加2021年全国大学生英语竞赛！</h1>\r\n</section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\">2021年全国大学生英语竞赛（NECCS），即第二十三届全国大学生英语竞赛预计将于2021年2月28日--3月30日报名，4&mdash;5月举行全国初决赛。</section>\r\n<p style=\"padding: 0px; margin: 0px; overflow-wrap: break-word; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff;\">&nbsp;</p>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\"></section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\">此项赛事由国际英语外语教师协会中国英语外语教师协会（TEFL　China）和高等学校大学外语教学研究会联合主办，英语辅导报社、考试与评价杂志社承办。全国各省（自治区、直辖市）大学外语教学研究会将成立各省赛区组委会统一参赛。目前竞赛的报名组织工作即将开始，报名截止时间为2021年3月30日。报名程序：参赛学生&rarr;参赛院校（教务处、大英教学部或外语学院、系）&rarr;省（自治区、直辖市）竞赛组委会&rarr;全国竞赛组委会。本届竞赛初赛将于2021年4月24日（周六）在全国各参赛院校统一时间举行，决赛笔试将于2021年5月16日（周日）在各省级赛区组委会全国统一时间举行。</section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\"></section>\r\n<p style=\"padding: 0px; margin: 0px; overflow-wrap: break-word; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff;\">&nbsp;</p>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\">本竞赛分A、B、C、D四个类别：A类适用于研究生参加；B类适用于英语专业本、专科学生参加；C类适用于非英语专业本科生参加；D类适用于体育类和艺术类本科生和非英语专业高职高专类学生参加。竞赛面向全体在校大学生，提倡&ldquo;重在参与&rdquo;的奥林匹克精神，坚持自愿报名参加的原则。各省（自治区、直辖市）竞赛组委会和各参赛高校可以根据实际情况任选几个或全部类别参加竞赛。</section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\"></section>\r\n<p style=\"padding: 0px; margin: 0px; overflow-wrap: break-word; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff;\">&nbsp;</p>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\"></section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\">2021年全国大学生英语竞赛（NECCS）初、决赛均为全国统一命题，初赛和决赛成绩满分（含听力、笔试）均为150分。决赛备有口试题，加设口试地区的分数设置为满分200分（口试50分）。口试方案和题目均为全国统一命制，由各省级竞赛组委会根据具体情况决定是否统一参加口试，并决定口试地点、时间、形式等具体事宜。竞赛试题内容将进一步加强对学生英语基础知识和基本技能的考查力度，并完善听力、书面测试和口语部分，加大语篇层次上对语言运用能力的考查，同时将设计一些考查智力和语言综合运用能力的赛题，以增加赛题的难易区分度。为了鼓励更多大学生参赛，全国竞赛组委会将在初赛期间向每一位参赛学生颁发统一制作的精美参赛证书。</section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\"></section>\r\n<p style=\"padding: 0px; margin: 0px; overflow-wrap: break-word; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff;\">&nbsp;</p>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\"></section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\">2021年全国大学生英语竞赛（NECCS）分初赛、决赛和全国总决赛三个阶段。2021年暑假期间将举办2020年&amp;2021年全国大学生英语竞赛（NECCS）全国总决赛。总决赛参赛者将从2020年和2021年全国大学生英语竞赛特等奖及各参赛院校各类别成绩第一名获得者中择优产生。全国总决赛期间将举办第二十二届全国大学生英语演讲比赛、第二十二届全国大学生英语辩论赛、第十五届全国大学生英语风采大赛等活动，具体时间和地点另行通知。全国总决赛采取特等奖获奖选手及各参赛院校各类别成绩第一名获得者个人申请注册和各省（自治区、直辖市）组委会推荐注册双轨制。</section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\"></section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\">全国大学生英语竞赛（NECCS）是我国目前规模最大、参与人数最多的全国性大学生英语综合能力竞赛，在我国大学英语教学改革不断发展和大学就业日趋严峻的形势下，本竞赛越来越受到各地各高等院校和广大大学生的重视，其参赛成绩和获奖证书已成为高校教育行政部门和教研部门、教师评优、晋升和评职的重要佐证，是学生保送研究生、综合测评、就业落户、出国留学的重要依据。</section>\r\n<p style=\"padding: 0px; margin: 0px; overflow-wrap: break-word; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff;\">&nbsp;</p>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\">为了更好地服务于广大参赛师生，全国大学生英语竞赛组织委员会办公室特开放官方微信公众平台（微信号：NECCS_2015），用以推送最新竞赛相关资讯；刊登竞赛最新样题；分享英语教学资源；提供竞赛交流互动平台，欢迎广大参赛师生及英语爱好者关注我们。</section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\"></section>\r\n<section style=\"padding: 0px; margin: 0px; list-style: none; font-size: 16px; color: #666666; font-family: \'Microsoft YaHei\', STHeiti, \'WenQuanYi Micro Hei\', SimSun, sans-serif; background-color: #ffffff; max-width: 100%; text-indent: 2em; overflow-wrap: break-word !important; box-sizing: border-box !important;\">欢迎广大在校大学生踊跃报名参赛，各学校可面向各省竞赛组委会报名，全国竞赛组委会不接受学校和个人单独报名。广大师生可以致电、函或电子邮件到全国大学生英语竞赛组委会办公室，咨询竞赛相关事宜。</section>\r\n<p>&nbsp;</p>','2021-02-25 23:00:00','2021-04-18 00:00:00','/img/001.jpg',1,'http://www.chinaneccs.cn/detail/509'),(2,'2021年全国大学生电子设计竞赛','<p><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">各赛区组织委员会、各有关高等学校：</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">全国大学生电子设计竞赛（以下简称全国竞赛）组委会在认真总结往届电子设计竞赛经验的基础上，经研究决定，启动2021年全国竞赛组织工作，现将有关事项通知如下：</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">一、竞赛目的</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">全国竞赛是全国性的大学生学科竞赛活动，竞赛按照紧密结合教学实际，着重基础、注重前沿的原则开展，目的在于促进电子信息类专业和课程的建设，引导高等学校在教学中注重培养大学生的创新能力、协作精神；加强学生动手能力和工程实践能力的培养，提高学生针对工程问题进行电子设计、制作的综合能力；吸引、鼓励广大学生踊跃参加课外科技活动，为优秀人才脱颖而出创造条件。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">二、组织领导</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">1. 全国竞赛组委会负责全国范围内竞赛的组织领导、协调与宣传工作。全国竞赛专家组负责竞赛命题、评审工作。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">2. 原则上每个参赛的省（自治区）、直辖市组成一个赛区，各赛区竞赛组委会由省（自治区）教育厅、直辖市教委（局）、高校代表及电子信息类专家及相关人士组成，负责本赛区竞赛的组织领导、协调与宣传工作。各赛区专家组由本赛区的电子信息类专家及相关人士组成，负责本赛区竞赛的评审工作，同时负责组织、遴选本赛区内的征题并向全国专家组推荐。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">3. 暂无条件单独组成赛区的省、自治区的有关高等学校，可根据实际情况就近参与其他赛区的竞赛活动，或直接与全国竞赛组委会联系，由全国竞赛组委会统筹安排。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">三、竞赛题目及要求</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">1. 竞赛题目分为本科生组题目和高职高专学生组题目。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">2. 竞赛题目包括&ldquo;理论设计&rdquo;和&ldquo;实际制作&rdquo;，以电子电路（含模拟和数字电路）设计应用为基础，可以涉及模-数混合电路、单片机、嵌入式系统、DSP、可编程器件、EDA软件、互联网、大数据、人工智能、射频及光电器件等方面技术应用。除题目特殊要求以外，参赛队的个人计算机、移动式存储介质、开发装置或仿真器等不得带入测试现场（实际制作实物中凡需软件编程的芯片必须事先下载脱机工作）。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">3. 竞赛题目应具有实际意义和应用背景，并考虑到目前教学的基本内容和新技术的应用趋势，力求对高校相关专业教学内容和课程体系改革，以及学生今后工作起到一定的引导作用。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">4. 竞赛题目着重考核参赛学生综合运用基础知识进行理论设计的能力、实践创新和独立工作的基本能力、实验综合技能（制作与调试），同时鼓励参赛学生发扬团队协作精神。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">5. 竞赛题目在难易程度上，既要考虑使参赛学生能在规定时间内完成基本要求，又能使优秀学生有充分发挥与创新的余地。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">6. 全国竞赛仍采用广泛征题、全国统一命题方式。请各赛区广泛发动本赛区高校师生、有关企业，组织好今年竞赛的征题工作，按照《2021年全国大学生电子设计竞赛命题原则及征题要求》（附件1），将征题汇总后于4月30日前报全国竞赛组委会秘书处。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">四、竞赛时间与形式</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">1. 报名时间：2021年5月31日截止。各赛区负责本赛区的报名与情况汇总工作，并填写全国统一格式的《2021年全国大学生电子设计竞赛赛区报名汇总表》。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">2. 竞赛时间： 2021年全国竞赛时间为8月4日（周三）8:00至7日（周六）20:00。竞赛以赛区为单位统一组织报名、竞赛、评审和评奖工作，具体时间节点及相关竞赛工作进度安排请按照《2021年全国大学生电子设计竞赛进度安排》（附件2）执行。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">3. 学生采用自愿组合、3人一队的原则组成参赛队，由所在学校统一向赛区竞赛组委会报名。参赛队分本科生组和高职高专学生组，参赛队数由参赛学校自行确定。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">4. 全国竞赛专家组根据命题原则，分别为本科生组和高职高专学生组统一编制若干个竞赛题目，供参赛队选用。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">5. 各赛区竞赛所需场地及仪器设备、元器件或材料原则上由参赛学校提供。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">五、网上发题</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">2021年全国竞赛继续采取网上发题方式。8月4日8:00开赛时，将依托全国大学生电子设计竞赛网站(http://nuedc.xjtu.edu.cn) 、全国大学生电子设计竞赛培训网（http://nuedc-training.com.cn）及其他相关网站发布全国竞赛题目，具体网址赛前公布。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">六、评奖</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">2021年全国竞赛，仍采用&ldquo;一次竞赛，两级评奖&rdquo;方式，竞赛奖励分为&ldquo;赛区奖&rdquo;和&ldquo;全国奖&rdquo;两级。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">1. 各赛区竞赛组委会负责本赛区的评奖工作，赛区奖的奖项设置、评奖等级和比例均由各赛区根据实际情况自行决定。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">2. 赛区评奖结束后，赛区竞赛组委会将本赛区推荐参加全国评审的优秀参赛队设计报告及要求的有关材料报送全国竞赛组委会秘书处（报送的具体内容及报送时间另行通知），赛区报送的优秀参赛队数分别不得超过本赛区本科组和高职高专组实际参赛队总数的10%。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">3. 全国竞赛专家组通过复测、综合测评等评审环节，产生全国竞赛获奖初评结果，报全国竞赛组委会审批。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">4. 全国竞赛设全国一等奖和二等奖，获奖总数原则上不超过全国实际参赛队总数的8%。同一题目、同一所学校获得全国一、二等奖的总队数合计不超过4个，其中一等奖队数不超过2个。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">5. 本科组和高职高专组分别评奖。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">6. 全国竞赛设立&ldquo;赛区优秀组织奖&rdquo;，对竞赛组织中表现出色的赛区竞赛组委会给予表彰奖励；同时设立&ldquo;优秀征题奖&rdquo;，对竞赛征题工作中表现突出的个人给予表彰奖励。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">7.建议各参赛学校结合本地区和本学校的实际，依照教育高教司文件（教高司函〔2003〕165号）精神，对教师-指导全国竞赛活动所付出的辛勤工作予以合理的认可与奖励，以激励更多的教师更积极地参与指导大学生学科竞赛活动。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">七、竞赛规则</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">1. 参赛学生应为普通高等学校具有正式学籍的全日制在校本科或高职高专学生。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">2. 参赛学生必须按统一时间参加竞赛，按时开始和结束竞赛。参赛的本科生只能选本科组题目；高职高专学生原则上选择高职高专组题目，但也可选择本科组题目。只要参赛队中有本科生，该队只能选择本科组题目。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">3. 各赛区竞赛组委会按时收回学生的设计报告和制作实物后，应及时严格封存，贴赛区统一制作的封条，并按赛区竞赛组委会的具体规定交赛区专家组测试评审。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">4. 竞赛期间，参赛学生可以使用各种图书资料和网络资源，但不得以任何方式与队外人员进行讨论交流，教师和其他非参赛队员必须迴避。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">5. 竞赛期间，各赛区竞赛组委会要组织巡视检查，以保证竞赛活动公正进行。建议有条件的赛区，今年增加赛区一级的网络在线监控，赛区组委会可对赛区内各个竞赛场地全景实施实时在线监控，作为对已有巡视检查制度的有效补充。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">6. 全国竞赛初评结果在网上公布，接受社会监督。在竞赛中如发现有教师参与、他人代做、抄袭及被抄袭、队与队之间交流、不按规定时间发题和收交作品等现象，将取消获奖-，并通报批评。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">八、经费</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">各赛区竞赛组委会组织工作经费来源：采用争取政府支持、社会各界赞助，也可以适当收取每个参赛队报名费（由参赛学校支付）。报名费具体数额由各赛区竞赛组委会根据实际情况确定。经费的使用要公开、透明，并接受社会各界监督。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">九、防疫</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">全国竞赛组委会、各赛区竞赛组委会、各有关高等学校均须遵守国家、地方及各自学校对疫情防控的相关要求。全国竞赛组委会将视疫情防控需要适时进行竞赛工作调整。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><strong style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">十、其他</strong><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">1. 有关竞赛组织工作中的具体事项，参照本通知附件和《全国大学生电子设计竞赛章程》执行。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">2. 请各赛区竞赛组委会及有关高等学校在当地教育厅（教委）的领导下，认真筹备、精心组织好今年本赛区的电子设计竞赛，鼓励各校积极参与，并正确理解竞赛的目的，处理好组织竞赛与不影响正常教学秩序之间的关系。</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">3. 全国竞赛组委会秘书处设在西安交通大学，联系方式如下：</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">全国组委会秘书处：</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">符均（电话：18992858095）</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">电子邮件： nuedc@mail.xjtu.edu.cn</span><br style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\" /><span style=\"color: #666666; font-family: 微软雅黑, \'PingFang SC\', Arial, \'Hiragino Sans GB\', \'WenQuanYi Micro Hei\', \'Microsoft Yahei\', sans-serif; font-size: 14px;\">通信地址：陕西省西安市碑林区咸宁西路28号西安交通大学电子与信息学部，符均，710049</span></p>','2021-04-16 21:00:00','2021-04-18 00:00:00','/img/001.jpg',2,'http://nuedc.xjtu.edu.cn/index/index/detail/id/82/catid/6.html'),(3,'2021年上半年全国大学英语四、六级考试','按照《河南省招生办公室关于做好2021年上半年全国大学英语四、六级考试报名工作的通知》（豫招成〔2021〕3号）文件的要求，现将我校2021年上半年全国大学英语四、六级考试报名的有关事项通知如下：\r\n\r\n一、考试科目\r\n\r\n英语四级（CET4）、英语六级（CET6）\r\n\r\n二、考试时间\r\n\r\n2021年6月12日（周六）。英语四级CET4（9:00—11:20）；英语六级CET6（15:00—17:25）。\r\n\r\n三、收费标准\r\n\r\n按豫发改收费函〔2008〕154号规定执行，各科目笔试报名费均为25元/人。\r\n\r\n四、报名资格\r\n\r\n1.本次全国大学英语四、六级考试报名考生为拥有我校正式学籍的在校学生（2020年12月缺考考生限制本次报名资格，无法参加本次考试）。\r\n\r\n2.报名六级的考生，四级考试成绩必须达到425分。\r\n\r\n3.不得越级报名且四六级不能同时报考。\r\n\r\n五、报名方式和报名时间\r\n\r\n1.报名实行网上报名，报名时间：2021年3月25日14:30至4月9日17:00，请按期限进行报名，逾期则视为放弃无法再报名。（即日起至2021年3月25日11:00前请登录系统仔细核对网报系统内本人学籍、照片等信息，并阅读该网站“考生须知”、“报名流程”和“常见问题”栏目）。\r\n\r\n2.按照省招办相关文件要求，由于考场资源有限，依照“先报先得，报满为止”的原则进行报名，请各学院做好报名通知。\r\n\r\n3.学生登陆教育部考试中心的CET考试报名网站（http://cet-bm.neea.edu.cn），注册用户、登陆报名网站、检查确认学籍信息与报考资格、选择报考语言级别、在线缴费（具体步骤请认真查看官方报名流程）。建议浏览器：火狐浏览器、谷歌浏览器、IE9+、360浏览器（选择极速模式）。\r\n\r\n4.学生报名前必须注册ETEST通行证（已经拥有ETEST通行证的学生，不需要重复注册），注册账号请登录ETEST平台，通行证账号只支持使用电子邮箱。账号密码要求：不能小于8位，且必须同时要包含字母、数字和特殊字符（!@#$%^&*_-）3种字符，目前学生可以先注册ETEST通行证，并登录CET报名网站了解网站信息和熟悉报名流程。请务必牢记注册的帐号、密码、邮箱等登录信息。\r\n\r\n5.常见问题请查阅CET考试报名网站相关说明。\r\n\r\n6.网上报名成功后，按照提示网上进行缴费（支付方法见报名网站“报名流程”栏目），窗体底端。一旦缴费成功，不得取消报名。\r\n','2021-03-18 20:00:00','2021-04-09 00:00:00','/img/001.jpg',2,'http://cet-https://www.lit.edu.cn/info/1042/15818.htm'),(4,'2021年洛阳理工学院田径运动会','为贯彻落实国家“广泛开展全民健身活动，加快推进体育强国建设”的精神，积极推动我校“阳光体育活动”深入开展，促进学生训练与竞赛水平不断提高，鼓励学生走下网络、走出宿舍、走向操场，经学校体育运动委员会研究，定于2021年4月14-16日在王城校区田径场举办2021年洛阳理工学院田径运动会。请各有关单位认真做好各项准备工作。2021年田径运动会（学生组）竞赛规程如下：\r\n\r\n一、比赛日期\r\n\r\n2021年4月14-16日\r\n\r\n二、比赛地点\r\n\r\n王城校区\r\n\r\n1.王城校区东田径场（径赛、跳跃）\r\n\r\n2.王城校区西田径场（铅球、实心球及集体娱乐项目）\r\n\r\n三、比赛项目\r\n\r\n1.竞赛项目（男子15项，女子13项，共计28项）\r\n\r\n（1）男子：100米、200米、400米、800米、1500米、3000米、5000米、110米栏、4×100米接力、4×400米接力、铅球、前抛实心球、跳高、跳远、三级跳远。\r\n\r\n（2）女子：100米、200米、400米、800米、1500米、3000米、100米栏、4×100米接力、4×400米接力、前抛实心球、铅球、跳高、跳远。\r\n\r\n2.集体娱乐项目（共9项）\r\n\r\n（1）袋鼠跳迎面接力：男、女各一队，每队人数为10人；\r\n\r\n（2）运转乾坤迎面接力：男、女各一队，每队人数为12人；\r\n\r\n（3）同心击鼓（排球）：男、女各一队，每队人数为10人；\r\n\r\n（4）2分钟绕“∞”跳绳比赛：男、女各一队，每队人数为10人；\r\n\r\n（5）抱篮球绕杆接力：男、女各一队，每队人数为20人；\r\n\r\n（6）抢种抢收（网球）：男、女各一队，每队人数为10人；\r\n\r\n（7）动力火车：男、女各一队，每队人数为20人；\r\n\r\n（8）云梯接力：男、女各一队，每队人数为20人；\r\n\r\n（9）摸石头过河：男、女各一队，每队人数为10人。\r\n\r\n四、参赛资格\r\n\r\n凡我校正式注册学生，并经各学院组织审核后无疾病、身体健康者均可报名参加比赛。\r\n\r\n五、报名办法\r\n\r\n1.报名时间：截止2021年3月29日下午16：00前，请提交纸质版和电子版的报名表及运动员登记表，逾期不再接收。\r\n\r\n2.填写报名表（附件1，Excel文档）。请按男、女报名表分别填写，田径单项每项目限报5人，每人限报2项（不含接力等集体项目）；集体娱乐项目按照规定进行报名；报名表上加盖学院公章，并填报教练、领队各1名，报名后不得以任何理由换人、换项。\r\n\r\n3.运动员汇总表（附件2），请各学院按照登记表的要求认真填写，号码请按照横排格式由小到大的顺序填写。\r\n\r\n4.请各学院将纸质版的学生报名表和学生运动员登记汇总表（附件1和附件2）交到体育教学部（王城校区交给杨旭峰老师，13698821603；开元校区和九都校区交给王传方老师，13698890199）；同时将电子版的报名表和运动员汇总表打包发送到：wchuanfang@163.com，并在邮件主题标注“××学院+2021年田径运动会报名和运动员登记汇总表”字样。\r\n','2021-03-17 17:00:00','2021-04-29 00:00:00','/img/001.jpg',2,'https://www.lit.edu.cn/info/1042/15815.htm'),(5,'洛阳理工学院2021年春季校园招聘活动','为贯彻落实党中央、国务院“稳就业”、“保就业”决策部署，积极响应教育部“2021 届全国普通高校毕业生就业创业促进行动”，服务加快构建以国内大循环为主体、国内国际双循环相互促进的新发展格局，满足各用人单位招才引智需求，在做好疫情防控工作的基础上，诚邀各用人单位来校开展各类招聘活动，选聘优秀人才，现将春季校园招聘活动方案通知如下。\r\n\r\n一、开放时间\r\n\r\n3月9日起，线上招聘活动全面开启。\r\n\r\n二、招聘形式\r\n\r\n采用线上、线下相结合，招聘会、宣讲会相补充的方式进行。\r\n\r\n三、招聘活动安排\r\n\r\n1.3月15日起根据企业申请安排举办线下宣讲会。\r\n\r\n2.拟定于4月8日举办大型春季双选会。\r\n\r\n3.3—6月与地方政府、兄弟高校、人才机构等联合举办专题招聘会或企业组团招聘会。\r\n\r\n4.4月15日-5月20日为“春夏招聘月“，每周四举办一场小型招聘会。\r\n\r\n5.线上招聘活动与线下招聘活动同步开展。\r\n\r\n四、报名方式\r\n\r\n已注册单位可登陆洛阳理工学院就业信息网（http://www.lit.edu.cn/jiuye/）进入“智慧就业平台”提交发布招聘简章，预约“空中宣讲会”、“线下宣讲会”及报名参加各类大中型招聘会。未注册单位请先进行单位注册，待审核通过（1-2个工作日）后方可报名。\r\n\r\n五、进校要求\r\n\r\n1.用人单位须根据疫情防控相关规定，合理选派不超过2名人员来校。来校人员预先签署“疫情防控责任承诺书”（加盖单位公章），并携带身份信息、健康码截图、行程码截图等进行入校申报，经学校审验通过后方可入校。\r\n\r\n2.单位联络人须阅读“用人单位入校须知”，明确防控要求和开展活动的有关规定。\r\n\r\n3.来校人员当日须接受身份核验、体温测量后入校。\r\n\r\n4.进入招聘场地后须接受手部消毒，全程佩戴口罩，不得在场地内饮食。\r\n\r\n六、联系方式\r\n\r\n联 系 人：赵老师 白老师\r\n\r\n联系电话：0379-65928070 0379-65928333\r\n\r\n咨询联系邮箱：lyyy521@163.com jiuye@lit.edu.cn\r\n\r\n感谢您一直以来对洛阳理工学院学生就业工作的关心、支持与帮助！\r\n','2021-04-01 00:00:00','2021-05-30 00:00:00','/img/001.jpg',2,'https://www.lit.edu.cn/info/1042/15763.htm'),(6,'2021年春季国家普通话水平测试报名','广大学生及教职工：\r\n\r\n2021年春季国家普通话水平测试报名工作从即日起开始，现将有关事项通知如下：\r\n\r\n一、报名对象\r\n\r\n本校在校学生及在职教职工。\r\n\r\n二、报名方法\r\n\r\n1.学生请登录普通话测试报名系统（校园网地址：http://172.16.99.4:8080/login.asp,校外网地址：http://120.194.42.205:9020/login.asp)。请使用本人学号登陆报名，为避免他人篡改报名信息，第一次登陆系统必须修改密码（初始密码为学生本人学号），否则无法登陆系统。\r\n\r\n2.登陆后，请先校对本人基本信息是否正确，照片是否为本人，以上信息如有错误请不要报名，请及时联系教学质量管理科孙老师(电话：65928089)。\r\n\r\n3.所有学生的信息均出自学籍平台，不允许修改。\r\n\r\n4. 退出系统，必须点击退出系统或者关闭浏览器窗口，否则报名信息有可能被他人篡改。\r\n\r\n5.网上报名截止时间：3月26日16时，凡不进行网上报名者，过后系统将无法添加。\r\n\r\n6.教职工到王城校区行政办公楼331现场报名，携带个人身份证和1寸证件照电子照片，时间为3月26日。\r\n\r\n7. 国家普通话水平测试我校每年组织2次，望广大师生根据个人情况合理安排报名时间。\r\n\r\n8.根据教育部、国家语委有关文件规定，凡经测试取得的国家普通话水平等级证书终身有效，不存在有效期问题。\r\n\r\n三、收费标准\r\n\r\n教师50元／人，学生30元／人（按照河南省豫发改办【2004】422号文执行）。学生的报名费需以本学院为单位统一于3月29日缴至王城校区行政楼331教学质量管理科(可微信转账）。\r\n\r\n四、测试时间\r\n\r\n测试时间为5月15-16日、5月22-23日。\r\n\r\n','2021-04-01 00:00:00','2021-04-29 00:00:00','/img/001.jpg',2,'https://www.lit.edu.cn/info/1042/15840.htm'),(13,'测试添加dddd','<p>水电费费水电费的浮点数水电费费水电费的浮点数</p>\r\n<p>水电费水电费水电费</p>\r\n<p><span style=\"color: #b96ad9;\">水电费水电费第三方</span></p>\r\n<p>水电费第三方似懂非懂</p>','2021-04-17 12:23:26','2021-04-17 00:00:00','/img/QQ截图20201225191229_20210417172624683.jpg',1,'http://www.baidu.com');

/*Table structure for table `sys_noticelinktype` */

DROP TABLE IF EXISTS `sys_noticelinktype`;

CREATE TABLE `sys_noticelinktype` (
  `noticeid` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  PRIMARY KEY (`noticeid`,`typeid`),
  KEY `key_type_id` (`typeid`),
  CONSTRAINT `key_notice_id` FOREIGN KEY (`noticeid`) REFERENCES `sys_notice` (`id`),
  CONSTRAINT `key_type_id` FOREIGN KEY (`typeid`) REFERENCES `sys_noticetype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_noticelinktype` */

insert  into `sys_noticelinktype`(`noticeid`,`typeid`) values (4,2),(5,2),(13,2),(4,3),(13,3),(1,4),(2,4),(4,4),(1,5),(3,5),(13,8),(2,9),(3,10),(6,10),(5,11),(3,13);

/*Table structure for table `sys_noticestatus` */

DROP TABLE IF EXISTS `sys_noticestatus`;

CREATE TABLE `sys_noticestatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sys_noticestatus` */

insert  into `sys_noticestatus`(`id`,`status`) values (1,'已逾期'),(2,'正在进行');

/*Table structure for table `sys_noticetype` */

DROP TABLE IF EXISTS `sys_noticetype`;

CREATE TABLE `sys_noticetype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `sys_noticetype` */

insert  into `sys_noticetype`(`id`,`typename`) values (1,'社会实践'),(2,'校园活动'),(3,'运动'),(4,'竞赛'),(5,'英语'),(6,'物理'),(7,'数学'),(8,'计算机'),(9,'电工'),(10,'选拔考试'),(11,'其他'),(13,'校园通知'),(15,'测试ddw');

/*Table structure for table `sys_resaccess` */

DROP TABLE IF EXISTS `sys_resaccess`;

CREATE TABLE `sys_resaccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access_way` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sys_resaccess` */

insert  into `sys_resaccess`(`id`,`access_way`) values (1,'本地文件'),(2,'链接下载'),(3,'线下物品');

/*Table structure for table `sys_reslinktype` */

DROP TABLE IF EXISTS `sys_reslinktype`;

CREATE TABLE `sys_reslinktype` (
  `resuorcceid` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  PRIMARY KEY (`resuorcceid`,`typeid`),
  KEY `key_link_type_id` (`typeid`),
  CONSTRAINT `key_link_resource_id` FOREIGN KEY (`resuorcceid`) REFERENCES `sys_resources` (`id`),
  CONSTRAINT `key_link_type_id` FOREIGN KEY (`typeid`) REFERENCES `sys_resourcestype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_reslinktype` */

insert  into `sys_reslinktype`(`resuorcceid`,`typeid`) values (2,1),(3,2),(18,2),(1,3),(1,4),(18,4),(23,4),(2,5),(18,7);

/*Table structure for table `sys_resources` */

DROP TABLE IF EXISTS `sys_resources`;

CREATE TABLE `sys_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `remark` varchar(255) DEFAULT NULL COMMENT '描述',
  `resources_type` int(11) DEFAULT NULL COMMENT '上传资源/类别',
  `uploadtime` datetime DEFAULT NULL COMMENT '上传时间',
  `account_id` int(11) DEFAULT NULL COMMENT '上传账户',
  `content` varchar(255) DEFAULT NULL COMMENT '上传内容',
  `access` int(11) DEFAULT NULL COMMENT '获取方式',
  PRIMARY KEY (`id`),
  KEY `key_res_account` (`account_id`),
  KEY `key_res_access` (`access`),
  CONSTRAINT `key_res_access` FOREIGN KEY (`access`) REFERENCES `sys_resaccess` (`id`),
  CONSTRAINT `key_res_account` FOREIGN KEY (`account_id`) REFERENCES `sys_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*Data for the table `sys_resources` */

insert  into `sys_resources`(`id`,`title`,`remark`,`resources_type`,`uploadtime`,`account_id`,`content`,`access`) values (1,'四级单词书','四级单词书考级已过，送出',NULL,'2021-04-01 20:37:50',2,'sadsaddddd',2),(2,'2020下学期高数期末复习资料','2020下学期高数期末复习资料，已上传',NULL,'2021-04-01 20:40:28',2,'afsdfsddsss',2),(3,'office2007','office2007',NULL,'2021-04-01 20:42:02',3,'url：lllllllllllll',1),(18,'sssffssdddd','sssdsdfds',NULL,'2021-04-11 15:11:41',1,'系统盘转移_20210411175700379.txt',1),(23,'测试','急急急',NULL,'2021-05-17 11:21:50',1,'QQ截图20201225194127_20210417112149827.jpg',1);

/*Table structure for table `sys_resourcestype` */

DROP TABLE IF EXISTS `sys_resourcestype`;

CREATE TABLE `sys_resourcestype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(255) DEFAULT NULL COMMENT '类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `sys_resourcestype` */

insert  into `sys_resourcestype`(`id`,`typename`) values (1,'学习文档'),(2,'软件应用'),(3,'闲置物品'),(4,'英语'),(5,'数学'),(6,'计算机'),(7,'文档'),(8,'其他'),(12,'数据1'),(13,'数据2');

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) NOT NULL COMMENT '权限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`rolename`) values (1,'超级管理员'),(2,'普通用户'),(18,'普通用户'),(19,'普通用户'),(20,'普通用户'),(21,'普通用户'),(22,'超级管理员'),(23,'超级管理员');

/*Table structure for table `sys_sex` */

DROP TABLE IF EXISTS `sys_sex`;

CREATE TABLE `sys_sex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sys_sex` */

insert  into `sys_sex`(`id`,`name`) values (1,'男'),(2,'女');

/*Table structure for table `sys_term` */

DROP TABLE IF EXISTS `sys_term`;

CREATE TABLE `sys_term` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `term` varchar(255) DEFAULT NULL,
  `time` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `sys_term` */

insert  into `sys_term`(`id`,`term`,`time`) values (1,'2015-2016学年第一学期','2015-09-01'),(2,'2015-2016学年第二学期','2016-02-01'),(3,'2016-2017学年第一学期','2016-09-01'),(4,'2016-2017学年第二学期','2017-02-01'),(5,'2017-2018学年第一学期','2017-09-01'),(6,'2017-2018学年第二学期','2018-02-01'),(7,'2018-2019学年第一学期','2018-09-01'),(8,'2018-2019学年第二学期','2019-02-01'),(9,'2019-2020学年第一学期','2019-09-01'),(10,'2019-2020学年第二学期','2020-02-01'),(11,'2020-2021学年第一学期','2020-09-01'),(12,'2020-2021学年第二学期','2021-01-02');

/*Table structure for table `sys_topics` */

DROP TABLE IF EXISTS `sys_topics`;

CREATE TABLE `sys_topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comtent` varchar(255) DEFAULT NULL COMMENT '内容',
  `topic_type` int(255) DEFAULT NULL COMMENT '发布的主题/类别',
  `releasetime` datetime DEFAULT NULL COMMENT '发布时间',
  `account_id` int(11) DEFAULT NULL COMMENT '发布账户',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `key_topic_account` (`account_id`),
  KEY `key_topic_type` (`topic_type`),
  CONSTRAINT `key_topic_account` FOREIGN KEY (`account_id`) REFERENCES `sys_account` (`id`),
  CONSTRAINT `key_topic_type` FOREIGN KEY (`topic_type`) REFERENCES `sys_topictype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `sys_topics` */

insert  into `sys_topics`(`id`,`comtent`,`topic_type`,`releasetime`,`account_id`,`remark`) values (1,'有没有周末玩狼人杀的小伙伴',1,'2021-04-01 20:16:06',2,NULL),(2,'有没有高数学的好的，教教我',2,'2021-04-01 20:21:36',2,NULL),(3,'考研党，有没有一起努力的',2,'2021-04-01 20:22:18',2,NULL),(4,'清明节有没有组团出去踏青的',5,'2021-04-01 20:23:24',3,NULL),(5,'放假回家，有没有安徽亳州的一起回家',5,'2021-04-01 20:25:20',2,NULL),(15,'历经打磨，@索尼中国 再献新作品—OLED电视A8F完美诞生。很开心一起参加了A8F的“首映礼”！[鼓掌]正如我们演员对舞台的热爱，索尼对科技与艺术的追求才创造出了让人惊喜的作品。作为A1兄弟款，A8F沿袭了黑科技“屏幕发声技术”和高清画质，色彩的出众表现和高端音质，让人在体验的时候如同身临其境。A8F，这次的“视帝”要颁发给你！ 索尼官网预售： O网页链接 索尼旗舰店预售：',5,'2021-04-21 22:03:38',15,NULL),(16,'历经打磨，@索尼中国 再献新作品—OLED电视A8F完美诞生。很开心一起参加了A8F的“首映礼”！[鼓掌]正如我们演员对舞台的热爱，索尼对科技与艺术的追求才创造出了让人惊喜的作品。作为A1兄弟款，A8F沿袭了黑科技“屏幕发声技术”和高清画质，色彩的出众表现和高端音质，让人在体验的时候如同身临其境。A8F，这次的“视帝”要颁发给你！ 索尼官网预售： O网页链接 索尼旗舰店预售：',2,'2021-05-06 22:03:38',2,NULL),(17,'历经打磨，@索尼中国 再献新作品—OLED电视A8F完美诞生。很开心一起参加了A8F的“首映礼”！[鼓掌]正如我们演员对舞台的热爱，索尼对科技与艺术的追求才创造出了让人惊喜的作品。作为A1兄弟款，A8F沿袭了黑科技“屏幕发声技术”和高清画质，色彩的出众表现和高端音质，让人在体验的时候如同身临其境。A8F，这次的“视帝”要颁发给你！ 索尼官网预售： O网页链接 索尼旗舰店预售：',5,'2021-05-21 22:03:38',3,NULL),(19,'历经打磨，@索尼中国 再献新作品—OLED电视A8F完美诞生。很开心一起参加了A8F的“首映礼”！[鼓掌]正如我们演员对舞台的热爱，索尼对科技与艺术的追求才创造出了让人惊喜的作品。作为A1兄弟款，A8F沿袭了黑科技“屏幕发声技术”和高清画质，色彩的出众表现和高端音质，让人在体验的时候如同身临其境。A8F，这次的“视帝”要颁发给你！ 索尼官网预售',4,'2021-04-16 08:51:13',1,NULL),(23,'历经打磨，@索尼中国 再献新作品—OLED电视A8F完美诞生。很开心一起参加了A8F的“首映礼”！[鼓掌]正如我们演员对舞台的热爱，索尼对科技与艺术的追求才创造出了让人惊喜的作品。作为A1兄弟款，A8F沿袭了黑科技“屏幕发声技术”和高清画质，色彩的出众表现和高端音质，让人在体验的时候如同身临其境。A8F，这次的“视帝”要颁发给你！',1,'2021-02-16 09:11:50',1,NULL);

/*Table structure for table `sys_topictype` */

DROP TABLE IF EXISTS `sys_topictype`;

CREATE TABLE `sys_topictype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(255) DEFAULT NULL COMMENT '类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `sys_topictype` */

insert  into `sys_topictype`(`id`,`typename`) values (1,'游戏'),(2,'学习'),(3,'运动'),(4,'兴趣'),(5,'出行'),(6,'交友'),(7,'其他'),(8,'数据1');

/*Table structure for table `sys_users` */

DROP TABLE IF EXISTS `sys_users`;

CREATE TABLE `sys_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `realname` varchar(255) DEFAULT NULL COMMENT '真实名',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `sex` int(11) DEFAULT NULL COMMENT '性别',
  `inclass` int(255) DEFAULT NULL COMMENT '班级',
  `majar_id` int(11) DEFAULT NULL COMMENT '专业',
  `address` varchar(255) DEFAULT NULL COMMENT '家庭住址',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `key_user_sex_id` (`sex`),
  KEY `key_user_majar_id` (`majar_id`),
  KEY `key_user_class` (`inclass`),
  CONSTRAINT `key_user_class` FOREIGN KEY (`inclass`) REFERENCES `sys_adminclass` (`id`),
  CONSTRAINT `key_user_majar_id` FOREIGN KEY (`majar_id`) REFERENCES `sys_majar` (`id`),
  CONSTRAINT `key_user_sex_id` FOREIGN KEY (`sex`) REFERENCES `sys_sex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

/*Data for the table `sys_users` */

insert  into `sys_users`(`id`,`realname`,`age`,`sex`,`inclass`,`majar_id`,`address`,`phone`,`email`,`remark`) values (1,'超级管理员',25,1,NULL,NULL,'河南省洛阳市','13656544567','1673677677@qq.com',NULL),(3,'小王',23,1,14,2,'河南省洛阳市','13764566765','1673365663@qq.com',NULL),(4,'大虎',22,1,4,28,'安徽省亳州市','15655466534','1298874665@qq.com',NULL),(5,'小黄',22,2,8,29,'安徽省亳州市','15635362536','1563356666@qq.com',NULL),(12,'wwww',NULL,1,13,31,'安徽省亳州市','13867655789','13902001111@163.com',NULL),(23,'是是是',NULL,2,7,29,'安徽省亳州市','','','管理员'),(30,'完成',12,1,32,3,'安徽省亳州市',NULL,'13902001113@163.com',NULL),(31,'sds',12,1,32,3,'安徽省亳州市',NULL,'13902001114@163.com',NULL),(32,'',NULL,NULL,NULL,NULL,'黑龙江省','18438609053',NULL,NULL);

/*Table structure for table `sys_uservisit` */

DROP TABLE IF EXISTS `sys_uservisit`;

CREATE TABLE `sys_uservisit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_time` varchar(255) DEFAULT NULL,
  `exit_time` varchar(255) DEFAULT NULL,
  `visit_ip` varchar(255) DEFAULT NULL,
  `user_address` varchar(255) DEFAULT NULL,
  `user_from` varchar(255) NOT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `system` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `loginname` varchar(255) DEFAULT NULL,
  `iphone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

/*Data for the table `sys_uservisit` */

insert  into `sys_uservisit`(`id`,`login_time`,`exit_time`,`visit_ip`,`user_address`,`user_from`,`browser`,`system`,`version`,`loginname`,`iphone`) values (1,'2019-02-12 09:13:56','2019-02-12 20:10:21','117.157.184.39','北京 移动','移动端','Chrome','Android','57.0.2987.132','admin','HUAWEIFIG-AL10'),(2,'2019-02-12 09:16:46','2019-02-12 20:10:21','117.157.180.39','北京 移动','PC端','Firefox','Windows','65.0','admin','Windows NT 10.0; Win64; x64'),(3,'2019-02-12 09:17:19','2019-02-12 20:10:21','124.152.216.170','北京 联通','移动端','Mobile Safari','Android','4.0','admin','HUAWEICLT-AL00'),(4,'2020-04-16 15:36:00','2020-04-16 15:38:01','0:0:0:0:0:0:0:1',NULL,'PC端','Chrome','Windows','71.0.3578.98','admin','Windows NT 10.0; Win64'),(5,'2020-04-16 22:19:38','2020-04-16 22:22:08','0:0:0:0:0:0:0:1',NULL,'PC端','Chrome','Windows','71.0.3578.98','admin','Windows NT 10.0; Win64'),(6,'2020-04-17 14:14:25','2020-04-17 14:17:55','0:0:0:0:0:0:0:1',NULL,'PC端','Chrome','Windows','71.0.3578.98','admin','Windows NT 10.0; Win64'),(7,'2020-04-17 14:18:59','2020-04-17 14:19:30','0:0:0:0:0:0:0:1',NULL,'PC端','Chrome','Windows','71.0.3578.98','admin','Windows NT 10.0; Win64'),(8,'2020-04-17 14:19:54','2020-04-17 14:20:27','0:0:0:0:0:0:0:1',NULL,'PC端','Chrome','Windows','71.0.3578.98','admin','Windows NT 10.0; Win64'),(9,'2020-04-17 14:20:36','2020-04-17 14:21:15','0:0:0:0:0:0:0:1',NULL,'PC端','Chrome','Windows','71.0.3578.98','xujie','Windows NT 10.0; Win64'),(11,'2020-06-27 14:06:30','2020-06-27 14:06:40','127.0.0.1',NULL,'PC端','Chrome 8','Windows','83.0.4103.116','zhangsq','Windows NT 10.0; Win64'),(12,'2020-06-27 18:36:44','2020-06-27 18:36:49','127.0.0.1',NULL,'PC端','Chrome 8','Windows','83.0.4103.116','admin','Windows NT 10.0; Win64'),(13,'2020-06-27 18:40:12','2020-06-27 18:40:30','127.0.0.1',NULL,'PC端','Chrome 8','Windows','83.0.4103.116','admin','Windows NT 10.0; Win64'),(14,'2020-06-27 18:45:23','2020-06-27 18:45:39','127.0.0.1',NULL,'PC端','Chrome 8','Windows','83.0.4103.116','admin','Windows NT 10.0; Win64'),(15,'2020-06-27 18:46:21','2020-06-27 18:46:28','127.0.0.1',NULL,'PC端','Chrome 8','Windows','83.0.4103.116','zhangsq','Windows NT 10.0; Win64'),(16,'2020-06-27 18:47:11','2020-06-27 19:25:01','127.0.0.1',NULL,'PC端','Chrome 8','Windows','83.0.4103.116','admin','Windows NT 10.0; Win64'),(17,'2020-06-27 22:27:39','2020-06-27 22:27:43','127.0.0.1',NULL,'PC端','Chrome 8','Windows','83.0.4103.116','admin','Windows NT 10.0; Win64'),(18,'2020-06-27 22:37:05','2020-06-27 22:37:32','127.0.0.1',NULL,'PC端','Chrome 8','Windows','83.0.4103.116','admin','Windows NT 10.0; Win64'),(19,'2020-06-28 16:13:38','2020-06-28 16:14:03','192.168.1.102',NULL,'PC端','Chrome 8','Windows 7','80.0.3987.149','admin','Windows NT 6.1; Win64'),(20,'2020-06-29 14:57:47','2020-06-29 14:57:52','127.0.0.1',NULL,'PC端','Chrome 8','Windows','83.0.4103.116','admin','Windows NT 10.0; Win64'),(37,'2021-04-25 21:21:02','2021-04-25 21:27:52','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(38,'2021-04-25 22:37:02','2021-04-25 22:38:24','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(39,'2021-04-25 22:46:32','2021-04-25 23:11:48','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(40,'2021-04-25 23:11:52','2021-04-25 23:12:51','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(41,'2021-04-25 23:12:56','2021-04-25 23:13:12','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(42,'2021-04-25 23:13:16','2021-04-25 23:13:32','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(43,'2021-04-26 09:55:32','2021-04-26 10:03:26','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(44,'2021-04-26 10:07:36','2021-04-26 10:12:56','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(45,'2021-05-01 17:37:06','2021-05-01 17:37:06','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','sss','Windows NT 10.0; Win64'),(46,'2021-05-01 22:55:29','2021-05-01 22:56:06','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(47,'2021-05-01 22:56:11','2021-05-01 23:13:11','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(48,'2021-05-02 12:56:56','2021-05-02 12:56:56','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(49,'2021-05-04 11:30:47','2021-05-04 11:30:47','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(50,'2021-05-04 16:37:31','2021-05-04 16:37:53','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(51,'2021-05-04 17:11:16','2021-05-04 17:11:16','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(52,'2021-05-04 19:58:29','2021-05-04 19:58:29','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(53,'2021-05-04 20:06:17','2021-05-04 20:33:18','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(54,'2021-05-04 21:25:23','2021-05-04 21:29:08','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(55,'2021-05-04 21:51:14','2021-05-04 21:56:50','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(56,'2021-05-04 21:57:32','2021-05-04 22:05:39','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(57,'2021-05-04 22:05:52','2021-05-04 22:05:52','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(58,'2021-05-04 22:06:13','2021-05-04 22:06:18','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(59,'2021-05-04 22:07:11','2021-05-04 22:07:34','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(60,'2021-05-04 22:07:39','2021-05-04 22:07:54','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(61,'2021-05-04 22:08:20','2021-05-04 22:21:51','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','dahu','Windows NT 10.0; Win64'),(62,'2021-05-04 22:37:36','2021-05-04 22:37:36','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(63,'2021-05-05 14:08:26','2021-05-05 14:08:26','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(64,'2021-05-05 20:17:49','2021-05-05 20:17:49','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64'),(65,'2021-05-05 20:42:38','2021-05-05 20:42:38','0:0:0:0:0:0:0:1','','PC端','Chrome 8','Windows 10','89.0.4389.114','admin','Windows NT 10.0; Win64');

/* Function  structure for function  `RAND_STR` */

/*!50003 DROP FUNCTION IF EXISTS `RAND_STR` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `RAND_STR`(n INT) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE chars_str CHAR(62) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFJHIJKLMNOPQRSTUVWXYZ0123456789';
    DECLARE return_str VARCHAR(1024) DEFAULT '';
    DECLARE i INT DEFAULT 0;
    WHILE i < n DO
        SET return_str = concat(return_str,substring(chars_str , FLOOR(1 + RAND()*62),1));
        SET i = i +1;
    END WHILE;
    RETURN return_str;
END */$$
DELIMITER ;

/* Function  structure for function  `RAND_STR1` */

/*!50003 DROP FUNCTION IF EXISTS `RAND_STR1` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `RAND_STR1`(n INT) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE chars_str CHAR(62) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFJHIJKLMNOPQRSTUVWXYZ0123456789';
    DECLARE return_str VARCHAR(1024) DEFAULT '';
    DECLARE i INT DEFAULT 0;
    WHILE i < n DO
        SET return_str = concat(return_str,substring(chars_str , FLOOR(1 + RAND()*62),1));
        SET i = i +1;
    END WHILE;
    RETURN return_str;
END */$$
DELIMITER ;

/* Function  structure for function  `rs` */

/*!50003 DROP FUNCTION IF EXISTS `rs` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `rs`(n int) RETURNS varchar(1024) CHARSET utf8
begin
declare chars char(62) default 'abcdefghijklmnopqrstuvwxyzABCDEFJHIJKLMNOPQRSTUVWXYZ0123456789';
declare res varchar(1024) default '';
declare i int default 0;
repeat
set i = i + 1;
set res = concat(res,substring(chars,floor(1+rand()*62),1));
until i=n end repeat;
return res;
end */$$
DELIMITER ;

/* Function  structure for function  `rss` */

/*!50003 DROP FUNCTION IF EXISTS `rss` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `rss`(n int) RETURNS varchar(1024) CHARSET utf8
begin
declare chars char(62) default 'abcdefghijklmnopqrstuvwxyzABCDEFJHIJKLMNOPQRSTUVWXYZ0123456789';
declare res varchar(1024) default '';
declare i int default 0;
repeat
set i = i + 1;
set res = concat(res,substring(chars,floor(1+rand()*62),1));
until i=n end repeat;
return res;
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
