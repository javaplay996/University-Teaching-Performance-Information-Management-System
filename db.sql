/*
SQLyog Ultimate v11.3 (64 bit)
MySQL - 5.7.32-log : Database - gaoxiaojiaoxueguanli
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`gaoxiaojiaoxueguanli` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `gaoxiaojiaoxueguanli`;

/*Table structure for table `config` */

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='配置文件';

/*Data for the table `config` */

insert  into `config`(`id`,`name`,`value`) values (1,'picture1','http://localhost:8080/gongchengcailiao/upload/1614999756013.jpg'),(2,'picture2','http://localhost:8080/gongchengcailiao/upload/1614999769770.jpg'),(3,'picture3','http://localhost:8080/gongchengcailiao/upload/1614999778981.jpg'),(6,'homepage',NULL);

/*Table structure for table `dictionary` */

DROP TABLE IF EXISTS `dictionary`;

CREATE TABLE `dictionary` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dic_code` varchar(200) DEFAULT NULL COMMENT '字段',
  `dic_name` varchar(200) DEFAULT NULL COMMENT '字段名',
  `code_index` tinyint(4) DEFAULT NULL COMMENT '编码',
  `index_name` varchar(200) DEFAULT NULL COMMENT '编码名字',
  `super_id` int(11) DEFAULT NULL COMMENT '父字段id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='字典表';

/*Data for the table `dictionary` */

insert  into `dictionary`(`id`,`dic_code`,`dic_name`,`code_index`,`index_name`,`super_id`,`create_time`) values (1,'sex_types','性别',1,'男',NULL,'2021-02-25 11:41:54'),(2,'sex_types','性别',2,'女',NULL,'2021-02-25 11:41:54'),(3,'jieguo_types','核算结果',1,'正常',NULL,'2021-02-25 11:41:54'),(4,'jieguo_types','核算结果',2,'异常',NULL,'2021-02-25 11:41:54');

/*Table structure for table `gongzuoliang` */

DROP TABLE IF EXISTS `gongzuoliang`;

CREATE TABLE `gongzuoliang` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `yonghu_id` int(11) DEFAULT NULL COMMENT '分配老师',
  `gongzhuo` int(11) DEFAULT NULL COMMENT '工作量 Search111',
  `jilu_time` timestamp NULL DEFAULT NULL COMMENT '发布时间',
  `xiangqing_content` varchar(200) DEFAULT NULL COMMENT '分配内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='工作量';

/*Data for the table `gongzuoliang` */

insert  into `gongzuoliang`(`id`,`yonghu_id`,`gongzhuo`,`jilu_time`,`xiangqing_content`) values (1,2,100,'2021-03-13 00:00:00','分配内容1\r\n'),(2,1,123,'2021-03-11 00:00:00','213321\r\n');

/*Table structure for table `hesuan` */

DROP TABLE IF EXISTS `hesuan`;

CREATE TABLE `hesuan` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) DEFAULT NULL COMMENT '核算名称 Search111',
  `wenjian_file` varchar(200) DEFAULT NULL COMMENT '详情文件',
  `hesuan_time` timestamp NULL DEFAULT NULL COMMENT '核算时间',
  `jieguo_types` int(11) DEFAULT NULL COMMENT '核算结果',
  `xiangqing_content` varchar(200) DEFAULT NULL COMMENT '核算详情',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='核算';

/*Data for the table `hesuan` */

insert  into `hesuan`(`id`,`name`,`wenjian_file`,`hesuan_time`,`jieguo_types`,`xiangqing_content`) values (1,'核算名称1','http://localhost:8080/gaoxiaojiaoxueguanli/file/download?fileName=1616230827476.doc','2021-03-02 00:00:00',1,'核算详情1\r\n'),(2,'核算名称2','http://localhost:8080/gaoxiaojiaoxueguanli/file/download?fileName=1616233551999.doc','2021-03-18 00:00:00',1,'1233212\r\n');

/*Table structure for table `jiaoxueruzi` */

DROP TABLE IF EXISTS `jiaoxueruzi`;

CREATE TABLE `jiaoxueruzi` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) DEFAULT NULL COMMENT '日志名称 Search111',
  `jilu_time` timestamp NULL DEFAULT NULL COMMENT '记录时间',
  `xiangqing_content` varchar(200) DEFAULT NULL COMMENT '日志内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='教学日志';

/*Data for the table `jiaoxueruzi` */

insert  into `jiaoxueruzi`(`id`,`name`,`jilu_time`,`xiangqing_content`) values (1,'日志名称1','2021-03-01 00:00:00','日志内容1\r\n'),(2,'日志名称2','2021-03-02 00:00:00','日志内容2\r\n'),(4,'123','2021-04-01 00:00:00','123\r\n');

/*Table structure for table `shiyanshi` */

DROP TABLE IF EXISTS `shiyanshi`;

CREATE TABLE `shiyanshi` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) DEFAULT NULL COMMENT '核算名称 Search111',
  `wenjian_file` varchar(200) DEFAULT NULL COMMENT '详情文件',
  `hesuan_time` timestamp NULL DEFAULT NULL COMMENT '核算时间',
  `jieguo_types` timestamp NULL DEFAULT NULL COMMENT '核算结果',
  `xiangqing_content` varchar(200) DEFAULT NULL COMMENT '核算详情',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='核算';

/*Data for the table `shiyanshi` */

/*Table structure for table `token` */

DROP TABLE IF EXISTS `token`;

CREATE TABLE `token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='token表';

/*Data for the table `token` */

insert  into `token`(`id`,`userid`,`username`,`tablename`,`role`,`token`,`addtime`,`expiratedtime`) values (1,11,'用户1','yonghu','用户','3xb9vneup8qpzs62xc009ty4qbk5wavl','2021-02-25 16:04:27','2021-03-08 03:13:30'),(2,1,'abo','users','管理员','uudzrs6hfp4odf458p409i1ovy2639gr','2021-02-25 16:05:48','2021-03-20 18:47:03'),(3,1614241036888,'1','yonghu','用户','w59s1pisbi8g0x8b2ur0mwjdewf0lepf','2021-02-25 16:18:05','2021-02-25 09:22:12'),(4,1,'111','yonghu','用户','99e4ksh6jxwln80nv90kr0dlm5j9mhft','2021-03-20 17:04:10','2021-03-20 18:46:18');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `role` varchar(100) DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`password`,`role`,`addtime`) values (1,'admin','admin','管理员','2021-02-25 15:59:12');

/*Table structure for table `xitonggonggao` */

DROP TABLE IF EXISTS `xitonggonggao`;

CREATE TABLE `xitonggonggao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `biaoti` varchar(200) DEFAULT NULL COMMENT '标题 Search',
  `leixing` varchar(200) DEFAULT NULL COMMENT '类型',
  `neirong` longtext COMMENT '内容',
  `riqi` datetime DEFAULT NULL COMMENT '日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统公告';

/*Data for the table `xitonggonggao` */

insert  into `xitonggonggao`(`id`,`addtime`,`biaoti`,`leixing`,`neirong`,`riqi`) values (1,'2021-02-25 17:35:20','日常公告标题','日常公告','公告信息','2021-02-25 17:35:20'),(2,'2021-02-25 17:35:20','紧急公告标题','紧急公告','公告信息','2021-02-25 17:35:20'),(3,'2021-02-25 17:35:20','其他公告标题','其他公告','公告信息','2021-02-25 17:35:20');

/*Table structure for table `yonghu` */

DROP TABLE IF EXISTS `yonghu`;

CREATE TABLE `yonghu` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) DEFAULT NULL COMMENT '名称  Search111',
  `username` varchar(255) DEFAULT NULL COMMENT '账号',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `img_photo` varchar(255) DEFAULT NULL COMMENT '头像',
  `sex_types` tinyint(4) DEFAULT NULL COMMENT '性别  Search111',
  `phone` varchar(200) DEFAULT NULL COMMENT '手机号',
  `role` varchar(255) DEFAULT NULL COMMENT '身份',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `yonghu` */

insert  into `yonghu`(`id`,`name`,`username`,`password`,`img_photo`,`sex_types`,`phone`,`role`) values (1,'小金','111','111','http://localhost:8080/gaoxiaojiaoxueguanli/file/download?fileName=1616231062248.jpg',1,'17796312333','教师'),(2,'小札','222','222','http://localhost:8080/gaoxiaojiaoxueguanli/file/download?fileName=1616231148960.jpg',2,'12312312333','教师');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
