/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.44 : Database - mall
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mall` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_croatian_ci */;

USE `mall`;

/*Table structure for table `cms_help` */

DROP TABLE IF EXISTS `cms_help`;

CREATE TABLE `cms_help` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) DEFAULT NULL,
  `icon` varchar(500) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `show_status` int(1) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `read_count` int(1) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='帮助表';

/*Data for the table `cms_help` */

/*Table structure for table `cms_help_category` */

DROP TABLE IF EXISTS `cms_help_category`;

CREATE TABLE `cms_help_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `icon` varchar(500) DEFAULT NULL COMMENT '分类图标',
  `help_count` int(11) DEFAULT NULL COMMENT '专题数量',
  `show_status` int(2) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='帮助分类表';

/*Data for the table `cms_help_category` */

/*Table structure for table `cms_member_report` */

DROP TABLE IF EXISTS `cms_member_report`;

CREATE TABLE `cms_member_report` (
  `id` bigint(20) DEFAULT NULL,
  `report_type` int(1) DEFAULT NULL COMMENT '举报类型：0->商品评价；1->话题内容；2->用户评论',
  `report_member_name` varchar(100) DEFAULT NULL COMMENT '举报人',
  `create_time` datetime DEFAULT NULL,
  `report_object` varchar(100) DEFAULT NULL,
  `report_status` int(1) DEFAULT NULL COMMENT '举报状态：0->未处理；1->已处理',
  `handle_status` int(1) DEFAULT NULL COMMENT '处理结果：0->无效；1->有效；2->恶意',
  `note` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户举报表';

/*Data for the table `cms_member_report` */

/*Table structure for table `cms_prefrence_area` */

DROP TABLE IF EXISTS `cms_prefrence_area`;

CREATE TABLE `cms_prefrence_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `pic` varbinary(500) DEFAULT NULL COMMENT '展示图片',
  `sort` int(11) DEFAULT NULL,
  `show_status` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='优选专区';

/*Data for the table `cms_prefrence_area` */

insert  into `cms_prefrence_area`(`id`,`name`,`sub_title`,`pic`,`sort`,`show_status`) values (1,'让音质更出众','音质不打折 完美现场感',NULL,NULL,1),(2,'让音质更出众22','让音质更出众22',NULL,NULL,NULL),(3,'让音质更出众33',NULL,NULL,NULL,NULL),(4,'让音质更出众44',NULL,NULL,NULL,NULL);

/*Table structure for table `cms_prefrence_area_product_relation` */

DROP TABLE IF EXISTS `cms_prefrence_area_product_relation`;

CREATE TABLE `cms_prefrence_area_product_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prefrence_area_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='优选专区和产品关系表';

/*Data for the table `cms_prefrence_area_product_relation` */

insert  into `cms_prefrence_area_product_relation`(`id`,`prefrence_area_id`,`product_id`) values (1,1,12),(2,1,13),(3,1,14),(4,1,18),(5,1,7),(6,2,7),(7,1,22),(24,1,23),(32,1,40),(51,1,26),(52,2,26),(53,3,26),(54,4,26);

/*Table structure for table `cms_subject` */

DROP TABLE IF EXISTS `cms_subject`;

CREATE TABLE `cms_subject` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `pic` varchar(500) DEFAULT NULL COMMENT '专题主图',
  `product_count` int(11) DEFAULT NULL COMMENT '关联产品数量',
  `recommend_status` int(1) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `collect_count` int(11) DEFAULT NULL,
  `read_count` int(11) DEFAULT NULL,
  `comment_count` int(11) DEFAULT NULL,
  `album_pics` varchar(1000) DEFAULT NULL COMMENT '画册图片用逗号分割',
  `description` varchar(1000) DEFAULT NULL,
  `show_status` int(1) DEFAULT NULL COMMENT '显示状态：0->不显示；1->显示',
  `content` text,
  `forward_count` int(11) DEFAULT NULL COMMENT '转发数',
  `category_name` varchar(200) DEFAULT NULL COMMENT '专题分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='专题表';

/*Data for the table `cms_subject` */

insert  into `cms_subject`(`id`,`category_id`,`title`,`pic`,`product_count`,`recommend_status`,`create_time`,`collect_count`,`read_count`,`comment_count`,`album_pics`,`description`,`show_status`,`content`,`forward_count`,`category_name`) values (1,1,'polo衬衫的也时尚',NULL,NULL,NULL,'2018-11-11 13:26:55',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'服装专题'),(2,2,'大牌手机低价秒',NULL,NULL,NULL,'2018-11-12 13:27:00',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'手机专题'),(3,2,'晓龙845新品上市',NULL,NULL,NULL,'2018-11-13 13:27:05',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'手机专题'),(4,1,'夏天应该穿什么',NULL,NULL,NULL,'2018-11-01 13:27:09',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'服装专题'),(5,1,'夏季精选',NULL,NULL,NULL,'2018-11-06 13:27:18',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'服装专题'),(6,2,'品牌手机降价',NULL,NULL,NULL,'2018-11-07 13:27:21',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'手机专题'),(7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL);

/*Table structure for table `cms_subject_category` */

DROP TABLE IF EXISTS `cms_subject_category`;

CREATE TABLE `cms_subject_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `icon` varchar(500) DEFAULT NULL COMMENT '分类图标',
  `subject_count` int(11) DEFAULT NULL COMMENT '专题数量',
  `show_status` int(2) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='专题分类表';

/*Data for the table `cms_subject_category` */

insert  into `cms_subject_category`(`id`,`name`,`icon`,`subject_count`,`show_status`,`sort`) values (1,'服装专题',NULL,NULL,NULL,NULL),(2,'手机专题',NULL,NULL,NULL,NULL);

/*Table structure for table `cms_subject_comment` */

DROP TABLE IF EXISTS `cms_subject_comment`;

CREATE TABLE `cms_subject_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subject_id` bigint(20) DEFAULT NULL,
  `member_nick_name` varchar(255) DEFAULT NULL,
  `member_icon` varchar(255) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `show_status` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='专题评论表';

/*Data for the table `cms_subject_comment` */

/*Table structure for table `cms_subject_product_relation` */

DROP TABLE IF EXISTS `cms_subject_product_relation`;

CREATE TABLE `cms_subject_product_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subject_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='专题商品关系表';

/*Data for the table `cms_subject_product_relation` */

insert  into `cms_subject_product_relation`(`id`,`subject_id`,`product_id`) values (1,1,12),(2,1,13),(3,1,14),(4,1,18),(5,1,7),(6,2,7),(7,1,22),(29,1,23),(30,4,23),(31,5,23),(90,1,40);

/*Table structure for table `cms_topic` */

DROP TABLE IF EXISTS `cms_topic`;

CREATE TABLE `cms_topic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `attend_count` int(11) DEFAULT NULL COMMENT '参与人数',
  `attention_count` int(11) DEFAULT NULL COMMENT '关注人数',
  `read_count` int(11) DEFAULT NULL,
  `award_name` varchar(100) DEFAULT NULL COMMENT '奖品名称',
  `attend_type` varchar(100) DEFAULT NULL COMMENT '参与方式',
  `content` text COMMENT '话题内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='话题表';

/*Data for the table `cms_topic` */

/*Table structure for table `cms_topic_category` */

DROP TABLE IF EXISTS `cms_topic_category`;

CREATE TABLE `cms_topic_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `icon` varchar(500) DEFAULT NULL COMMENT '分类图标',
  `subject_count` int(11) DEFAULT NULL COMMENT '专题数量',
  `show_status` int(2) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='话题分类表';

/*Data for the table `cms_topic_category` */

/*Table structure for table `cms_topic_comment` */

DROP TABLE IF EXISTS `cms_topic_comment`;

CREATE TABLE `cms_topic_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_nick_name` varchar(255) DEFAULT NULL,
  `topic_id` bigint(20) DEFAULT NULL,
  `member_icon` varchar(255) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `show_status` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='专题评论表';

/*Data for the table `cms_topic_comment` */

/*Table structure for table `oms_cart_item` */

DROP TABLE IF EXISTS `oms_cart_item`;

CREATE TABLE `oms_cart_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `product_sku_id` bigint(20) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL COMMENT '购买数量',
  `price` decimal(10,2) DEFAULT NULL COMMENT '添加到购物车的价格',
  `product_pic` varchar(1000) DEFAULT NULL COMMENT '商品主图',
  `product_name` varchar(500) DEFAULT NULL COMMENT '商品名称',
  `product_sub_title` varchar(500) DEFAULT NULL COMMENT '商品副标题（卖点）',
  `product_sku_code` varchar(200) DEFAULT NULL COMMENT '商品sku条码',
  `member_nickname` varchar(500) DEFAULT NULL COMMENT '会员昵称',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_date` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_status` int(1) DEFAULT '0' COMMENT '是否删除',
  `product_category_id` bigint(20) DEFAULT NULL COMMENT '商品分类',
  `product_brand` varchar(200) DEFAULT NULL,
  `product_sn` varchar(200) DEFAULT NULL,
  `product_attr` varchar(500) DEFAULT NULL COMMENT '商品销售属性:[{"key":"颜色","value":"颜色"},{"key":"容量","value":"4G"}]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='购物车表';

/*Data for the table `oms_cart_item` */

insert  into `oms_cart_item`(`id`,`product_id`,`product_sku_id`,`member_id`,`quantity`,`price`,`product_pic`,`product_name`,`product_sub_title`,`product_sku_code`,`member_nickname`,`create_date`,`modify_date`,`delete_status`,`product_category_id`,`product_brand`,`product_sn`,`product_attr`) values (144,28,NULL,14,1,'649.00','http://154.92.22.163:9000/mall/20240703/selling-products13.jpg','Half Sleeve T-Shirt','Half Sleeve T-Shirt',NULL,NULL,'2024-07-11 17:29:13',NULL,1,19,'小米','7437789','[]'),(145,27,NULL,14,3,'2699.00','http://154.92.22.163:9000/mall/20240703/product-item4.jpg','Long Belly Grey Pant','Long Belly Grey Pant',NULL,NULL,'2024-07-16 16:11:56',NULL,0,19,'小米','7437788','[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.8\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"3000ml\"}]'),(146,33,NULL,14,1,'2499.00','http://154.92.22.163:9000/mall/20240703/post-img4.jpg','Stylish Grey T-Shirtee','Stylish Grey T-Shirtee',NULL,NULL,'2024-07-16 16:13:11',NULL,0,35,'小米','4609652','[{\"key\":\"商品编号\",\"value\":\"4609652\"},{\"key\":\"商品毛重\",\"value\":\"28.6kg\"},{\"key\":\"商品产地\",\"value\":\"中国大陆\"},{\"key\":\"电视类型\",\"value\":\"大屏\"}]'),(147,31,NULL,1,1,'98.00','http://154.92.22.163:9000/mall/20240703/selling-products15.jpg','Stylish Grey T-Shirt34','Stylish Grey T-Shirt345',NULL,'test','2024-07-22 14:12:04',NULL,1,8,'海澜之家','HNTBJ2E080A','[{\"key\":\"颜色\",\"value\":\"浅灰色\"},{\"key\":\"商品编号\",\"value\":\"HNTBJ2E080A\"},{\"key\":\"适用季节\",\"value\":\"夏季\"},{\"key\":\"适用人群\",\"value\":\"青年\"},{\"key\":\"上市时间\",\"value\":\"2018年夏\"},{\"key\":\"袖长\",\"value\":\"短袖\"}]'),(148,43,NULL,1,3,'1799.00','http://154.92.22.163:9000/mall/20240703/product-item1.jpg','Full Sleeve Cover Shirt','Full Sleeve Cover Shirt',NULL,'test','2024-07-22 15:23:27',NULL,1,39,'万和','10044060351752','[{\"key\":\"系列\",\"value\":\"JSQ25-565W13【13升】【恒温旗舰款】\"},{\"key\":\"上市时间\",\"value\":\"2021-05\"},{\"key\":\"毛重\",\"value\":\"15.5kg\"},{\"key\":\"额定功率\",\"value\":\"30w\"}]'),(149,28,NULL,1,1,'649.00','http://154.92.22.163:9000/mall/20240703/selling-products13.jpg','Half Sleeve T-Shirt','Half Sleeve T-Shirt',NULL,'test','2024-07-23 17:29:39',NULL,1,19,'小米','7437789','[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.0\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"2800ml\"}]'),(150,28,NULL,1,1,'649.00','http://154.92.22.163:9000/mall/20240703/selling-products13.jpg','Half Sleeve T-Shirt','Half Sleeve T-Shirt',NULL,'test','2024-07-25 08:32:52',NULL,1,19,'小米','7437789','[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.0\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"2800ml\"}]'),(151,30,NULL,1,1,'98.00','http://154.92.22.163:9000/mall/20240703/review-image1.jpg','Stylish Grey T-Shirt23','2018夏季新品微弹舒适新款短T男生 6月6日-6月20日，满300减30，参与互动赢百元礼券，立即分享赢大奖',NULL,'test','2024-07-25 09:03:02',NULL,1,8,'海澜之家','HNTBJ2E042A','[{\"key\":\"颜色\",\"value\":\"白色\"},{\"key\":\"商品编号\",\"value\":\"HNTBJ2E042A\"},{\"key\":\"适用季节\",\"value\":\"夏季\"},{\"key\":\"适用人群\",\"value\":\"青年\"},{\"key\":\"上市时间\",\"value\":\"2018年夏\"},{\"key\":\"袖长\",\"value\":\"短袖\"}]'),(152,28,NULL,1,1,'649.00','http://154.92.22.163:9000/mall/20240703/selling-products13.jpg','Half Sleeve T-Shirt','Half Sleeve T-Shirt',NULL,'test','2024-07-25 09:07:18',NULL,1,19,'小米','7437789','[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.0\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"2800ml\"}]'),(153,28,NULL,1,1,'649.00','http://154.92.22.163:9000/mall/20240703/selling-products13.jpg','Half Sleeve T-Shirt','Half Sleeve T-Shirt',NULL,'test','2024-07-25 09:16:00',NULL,1,19,'小米','7437789','[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.0\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"2800ml\"}]'),(154,27,NULL,1,1,'2699.00','http://154.92.22.163:9000/mall/20240703/product-item4.jpg','Long Belly Grey Pant','Long Belly Grey Pant',NULL,'test','2024-07-25 09:20:23',NULL,1,19,'小米','7437788','[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.8\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"3000ml\"}]'),(155,29,NULL,1,1,'5499.00','http://154.92.22.163:9000/mall/20240703/selling-products5.jpg','Stylish Grey T-Shirt','【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。',NULL,'test','2024-07-25 09:26:33',NULL,1,19,'苹果','7437799','[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]'),(156,29,NULL,1,1,'5499.00','http://154.92.22.163:9000/mall/20240703/selling-products5.jpg','Stylish Grey T-Shirt','【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。',NULL,'test','2024-07-25 09:29:04',NULL,1,19,'苹果','7437799','[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]'),(157,37,NULL,1,1,'5999.00','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg','Apple iPhone 14 (A2884) 128GB 支持移动联通电信5G 双卡双待手机','【11.11大爱超大爱】指定iPhone14产品限时限量领券立减601元！！！部分iPhone产品现货抢购确认收货即送原厂手机壳10元优惠券！！！猛戳 ',NULL,'test','2024-07-25 09:56:12',NULL,1,19,'苹果','100038005189','[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"6.1英寸\"},{\"key\":\"网络\",\"value\":\"5G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"3000毫安\"}]'),(158,40,NULL,1,2,'2999.00','http://154.92.22.163:9000/mall/20240703/product-item2.jpg','Volunteer Half Blue','Volunteer Half Blue',NULL,'test','2024-07-25 10:14:32',NULL,1,19,'小米','100027789721','[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"6.73英寸\"},{\"key\":\"网络\",\"value\":\"5G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"5160mAh\"}]'),(159,31,NULL,1,1,'98.00','http://154.92.22.163:9000/mall/20240703/selling-products15.jpg','Stylish Grey T-Shirt34','Stylish Grey T-Shirt345',NULL,'test','2024-07-25 10:25:59',NULL,1,8,'海澜之家','HNTBJ2E080A','[{\"key\":\"颜色\",\"value\":\"深灰色\"},{\"key\":\"商品编号\",\"value\":\"HNTBJ2E080A\"},{\"key\":\"适用季节\",\"value\":\"夏季\"},{\"key\":\"适用人群\",\"value\":\"青年\"},{\"key\":\"上市时间\",\"value\":\"2018年夏\"},{\"key\":\"袖长\",\"value\":\"短袖\"}]'),(160,36,NULL,1,1,'499.00','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg','耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码','耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码',NULL,'test','2024-07-25 13:46:45',NULL,1,29,'NIKE','6799345','[]'),(161,34,NULL,1,1,'3999.00','http://154.92.22.163:9000/mall/20240703/selling-products18.jpg','Stylish Grey T-Shirt45','Stylish Grey T-Shirt45',NULL,'test','2024-07-25 14:04:40',NULL,1,35,'小米','4609660','[{\"key\":\"商品编号\",\"value\":\"4609660\"},{\"key\":\"商品毛重\",\"value\":\"30.8kg\"},{\"key\":\"商品产地\",\"value\":\"中国大陆\"},{\"key\":\"电视类型\",\"value\":\"4K超清\"}]'),(162,27,NULL,1,1,'2699.00','http://154.92.22.163:9000/mall/20240703/product-item4.jpg','Long Belly Grey Pant','Long Belly Grey Pant',NULL,'test','2024-07-25 14:05:10',NULL,1,19,'小米','7437788','[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.8\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"3000ml\"}]'),(163,40,NULL,1,1,'2999.00','http://154.92.22.163:9000/mall/20240703/product-item2.jpg','Volunteer Half Blue','Volunteer Half Blue',NULL,'test','2024-07-25 16:34:42',NULL,1,19,'小米','100027789721','[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"6.73英寸\"},{\"key\":\"网络\",\"value\":\"5G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"5160mAh\"}]'),(164,40,NULL,1,1,'2999.00','http://154.92.22.163:9000/mall/20240703/product-item2.jpg','Volunteer Half Blue','Volunteer Half Blue',NULL,'test','2024-07-25 16:41:36',NULL,1,19,'小米','100027789721','[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"6.73英寸\"},{\"key\":\"网络\",\"value\":\"5G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"5160mAh\"}]'),(165,27,NULL,1,1,'2699.00','http://154.92.22.163:9000/mall/20240703/product-item4.jpg','Long Belly Grey Pant','Long Belly Grey Pant',NULL,'test','2024-07-25 16:45:02',NULL,1,19,'小米','7437788','[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.8\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"3000ml\"}]'),(166,29,NULL,1,1,'5499.00','http://154.92.22.163:9000/mall/20240703/selling-products5.jpg','Stylish Grey T-Shirt','【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。',NULL,'test','2024-07-25 16:48:37',NULL,1,19,'苹果','7437799','[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]');

/*Table structure for table `oms_company_address` */

DROP TABLE IF EXISTS `oms_company_address`;

CREATE TABLE `oms_company_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address_name` varchar(200) DEFAULT NULL COMMENT '地址名称',
  `send_status` int(1) DEFAULT NULL COMMENT '默认发货地址：0->否；1->是',
  `receive_status` int(1) DEFAULT NULL COMMENT '是否默认收货地址：0->否；1->是',
  `name` varchar(64) DEFAULT NULL COMMENT '收发货人姓名',
  `phone` varchar(64) DEFAULT NULL COMMENT '收货人电话',
  `province` varchar(64) DEFAULT NULL COMMENT '省/直辖市',
  `city` varchar(64) DEFAULT NULL COMMENT '市',
  `region` varchar(64) DEFAULT NULL COMMENT '区',
  `detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公司收发货地址表';

/*Data for the table `oms_company_address` */

insert  into `oms_company_address`(`id`,`address_name`,`send_status`,`receive_status`,`name`,`phone`,`province`,`city`,`region`,`detail_address`) values (1,'深圳发货点',1,1,'大梨','18000000000','广东省','深圳市','南山区','科兴科学园'),(2,'北京发货点',0,0,'大梨','18000000000','北京市',NULL,'南山区','科兴科学园'),(3,'南京发货点',0,0,'大梨','18000000000','江苏省','南京市','南山区','科兴科学园');

/*Table structure for table `oms_order` */

DROP TABLE IF EXISTS `oms_order`;

CREATE TABLE `oms_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `member_id` bigint(20) NOT NULL,
  `coupon_id` bigint(20) DEFAULT NULL,
  `order_sn` varchar(64) DEFAULT NULL COMMENT '订单编号',
  `create_time` datetime DEFAULT NULL COMMENT '提交时间',
  `member_username` varchar(64) DEFAULT NULL COMMENT '用户帐号',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '订单总金额',
  `pay_amount` decimal(10,2) DEFAULT NULL COMMENT '应付金额（实际支付金额）',
  `freight_amount` decimal(10,2) DEFAULT NULL COMMENT '运费金额',
  `promotion_amount` decimal(10,2) DEFAULT NULL COMMENT '促销优化金额（促销价、满减、阶梯价）',
  `integration_amount` decimal(10,2) DEFAULT NULL COMMENT '积分抵扣金额',
  `coupon_amount` decimal(10,2) DEFAULT NULL COMMENT '优惠券抵扣金额',
  `discount_amount` decimal(10,2) DEFAULT NULL COMMENT '管理员后台调整订单使用的折扣金额',
  `pay_type` int(1) DEFAULT NULL COMMENT '支付方式：0->未支付；1->支付宝；2->微信',
  `source_type` int(1) DEFAULT NULL COMMENT '订单来源：0->PC订单；1->app订单',
  `status` int(1) DEFAULT NULL COMMENT '订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单',
  `order_type` int(1) DEFAULT NULL COMMENT '订单类型：0->正常订单；1->秒杀订单',
  `delivery_company` varchar(64) DEFAULT NULL COMMENT '物流公司(配送方式)',
  `delivery_sn` varchar(64) DEFAULT NULL COMMENT '物流单号',
  `auto_confirm_day` int(11) DEFAULT NULL COMMENT '自动确认时间（天）',
  `integration` int(11) DEFAULT NULL COMMENT '可以获得的积分',
  `growth` int(11) DEFAULT NULL COMMENT '可以活动的成长值',
  `promotion_info` varchar(100) DEFAULT NULL COMMENT '活动信息',
  `bill_type` int(1) DEFAULT NULL COMMENT '发票类型：0->不开发票；1->电子发票；2->纸质发票',
  `bill_header` varchar(200) DEFAULT NULL COMMENT '发票抬头',
  `bill_content` varchar(200) DEFAULT NULL COMMENT '发票内容',
  `bill_receiver_phone` varchar(32) DEFAULT NULL COMMENT '收票人电话',
  `bill_receiver_email` varchar(64) DEFAULT NULL COMMENT '收票人邮箱',
  `receiver_first_name` varchar(50) DEFAULT NULL,
  `receiver_name` varchar(100) NOT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(32) NOT NULL COMMENT '收货人电话',
  `receiver_post_code` varchar(32) DEFAULT NULL COMMENT '收货人邮编',
  `receiver_province` varchar(32) DEFAULT NULL COMMENT '省份/直辖市',
  `receiver_city` varchar(32) DEFAULT NULL COMMENT '城市',
  `receiver_region` varchar(32) DEFAULT NULL COMMENT '区',
  `receiver_detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `note` varchar(500) DEFAULT NULL COMMENT '订单备注',
  `confirm_status` int(1) DEFAULT NULL COMMENT '确认收货状态：0->未确认；1->已确认',
  `delete_status` int(1) NOT NULL DEFAULT '0' COMMENT '删除状态：0->未删除；1->已删除',
  `use_integration` int(11) DEFAULT NULL COMMENT '下单时使用的积分',
  `payment_time` datetime DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime DEFAULT NULL COMMENT '确认收货时间',
  `comment_time` datetime DEFAULT NULL COMMENT '评价时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `street_address` varchar(200) DEFAULT NULL COMMENT '街道地址',
  `country` varchar(50) DEFAULT NULL COMMENT '国家',
  `company` varchar(100) DEFAULT NULL COMMENT '公司',
  `paypal_payment_id` varchar(200) DEFAULT NULL COMMENT 'paypal支付订单Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单表';

/*Data for the table `oms_order` */

insert  into `oms_order`(`id`,`member_id`,`coupon_id`,`order_sn`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`order_type`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`promotion_info`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_first_name`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`,`email`,`street_address`,`country`,`company`,`paypal_payment_id`) values (12,1,2,'201809150101000001','2018-09-15 12:24:27','test','18732.00','16377.75','20.00','2344.25','0.00','10.00','10.00',0,1,4,0,'','',15,13284,13284,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','江苏省','常州市','天宁区','东晓街道','111',0,1,NULL,NULL,NULL,NULL,NULL,'2019-11-09 16:50:28',NULL,NULL,NULL,NULL,NULL),(13,1,2,'201809150102000002','2018-09-15 14:24:29','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',1,1,3,0,'顺丰快递','dfdfdfdfdfdfdfdf',15,13284,13284,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,1000,'2018-10-11 14:04:19','2024-07-17 10:34:30','2024-07-17 16:01:23',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,1,2,'201809130101000001','2018-09-13 16:57:40','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',2,1,3,0,'顺丰快递','201707196398345',15,13284,13284,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2018-10-13 13:44:04','2018-10-16 13:43:41','2022-11-11 16:19:34',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,1,2,'201809130102000002','2018-09-13 17:03:00','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',1,1,3,0,'顺丰快递','201707196398346',15,13284,13284,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,1,NULL,'2018-10-13 13:44:54','2018-10-16 13:45:01','2018-10-18 14:05:31',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,1,2,'201809140101000001','2018-09-14 16:16:16','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',2,1,4,0,NULL,NULL,15,13284,13284,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,1,2,'201809150101000003','2018-09-15 12:24:27','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',0,1,4,0,'顺丰快递','201707196398345',15,NULL,NULL,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,'2018-10-12 14:01:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,1,2,'201809150102000004','2018-09-15 14:24:29','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',1,1,1,0,'圆通快递','xx',15,NULL,NULL,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,1000,NULL,'2018-10-16 14:42:17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,1,2,'201809130101000003','2018-09-13 16:57:40','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',2,1,2,0,NULL,NULL,15,NULL,NULL,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,1,2,'201809130102000004','2018-09-13 17:03:00','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',1,1,3,0,NULL,NULL,15,NULL,NULL,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,1,2,'201809140101000002','2018-09-14 16:16:16','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',2,1,4,0,NULL,NULL,15,18682,18682,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,1,2,'201809150101000005','2018-09-15 12:24:27','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',0,1,4,0,'顺丰快递','201707196398345',15,0,0,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,'2018-10-12 14:01:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,1,2,'201809150102000006','2018-09-15 14:24:29','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',1,1,1,0,'顺丰快递','xxx',15,0,0,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,1000,NULL,'2018-10-16 14:41:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,1,2,'201809130101000005','2018-09-13 16:57:40','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',2,1,2,0,NULL,NULL,15,18682,18682,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,1,2,'201809130102000006','2018-09-13 17:03:00','test','18732.00','16377.75','10.00','2344.25','0.00','10.00','5.00',1,1,4,0,NULL,NULL,15,18682,18682,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨22','18033441849','518000','北京市','北京城区','东城区','东城街道','xxx',0,1,NULL,NULL,NULL,NULL,NULL,'2018-10-30 15:08:31',NULL,NULL,NULL,NULL,NULL),(26,1,2,'201809140101000003','2018-09-14 16:16:16','test','18732.00','16377.75','0.00','2344.25','0.00','10.00','0.00',2,1,4,0,NULL,NULL,15,18682,18682,'单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,1,NULL,'202002250100000001','2020-02-25 15:59:20','test','540.00','540.00','0.00','0.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,NULL,0,0,'无优惠,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,1,NULL,'202002250100000002','2020-02-25 16:05:47','test','540.00','540.00','0.00','0.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,NULL,0,0,'无优惠,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,1,NULL,'202002250100000003','2020-02-25 16:07:58','test','540.00','540.00','0.00','0.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,NULL,0,0,'无优惠,无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,1,NULL,'202002250100000004','2020-02-25 16:50:13','test','240.00','240.00','20.00','0.00','0.00','0.00','10.00',0,1,3,0,'顺丰快递','12333333',NULL,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,1,0,NULL,'2020-02-25 16:53:29','2020-02-25 16:54:03','2020-05-17 19:38:15',NULL,'2020-02-25 16:52:51',NULL,NULL,NULL,NULL,NULL),(31,1,26,'202005160100000001','2020-05-16 15:16:54','test','13623.00','11842.40','0.00','1629.60','1.00','150.00','0.00',0,1,4,0,NULL,NULL,15,13623,13623,'满减优惠：满5000.00元，减500.00元;打折优惠：满2件，打8.00折;满减优惠：满500.00元，减50.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,1,NULL,'202005170100000001','2020-05-17 15:00:38','test','6487.00','6187.00','0.00','300.00','0.00','0.00','0.00',1,1,1,0,NULL,NULL,15,6487,6487,'满减优惠：满3000.00元，减300.00元;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2020-05-17 15:33:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,1,NULL,'202005170100000002','2020-05-17 15:14:18','test','3788.00','3488.00','0.00','300.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,3788,3788,'满减优惠：满3000.00元，减300.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,1,NULL,'202005170100000003','2020-05-17 15:20:10','test','3788.00','3488.00','0.00','300.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,3788,3788,'满减优惠：满3000.00元，减300.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,1,NULL,'202005170100000004','2020-05-17 15:22:03','test','3788.00','3488.00','0.00','300.00','0.00','0.00','0.00',2,1,3,0,'顺丰快递','123',15,3788,3788,'满减优惠：满3000.00元，减300.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2020-05-17 15:29:07','2020-05-17 15:30:24','2020-05-17 15:41:45',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(36,1,NULL,'202005170100000005','2020-05-17 16:59:26','test','10275.00','9775.00','0.00','500.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,10275,10275,'满减优惠：满5000.00元，减500.00元;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,1,NULL,'202005170100000006','2020-05-17 19:33:48','test','6487.00','6187.00','0.00','300.00','0.00','0.00','0.00',1,1,3,0,'顺丰快递','aadd',15,6487,6487,'满减优惠：满3000.00元，减300.00元;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2020-05-17 19:33:59','2020-05-17 19:34:59','2020-05-17 19:35:50',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,1,NULL,'202005170100000007','2020-05-17 19:39:10','test','3788.00','3488.00','0.00','300.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,3788,3788,'满减优惠：满3000.00元，减300.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(39,1,NULL,'202005170100000008','2020-05-17 19:41:30','test','3788.00','3488.00','0.00','300.00','0.00','0.00','0.00',1,1,3,0,'顺丰快递','sdf',15,3788,3788,'满减优惠：满3000.00元，减300.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,1,NULL,'2020-05-17 19:41:41','2020-05-17 19:42:07','2020-05-17 19:42:36',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,1,NULL,'202005180100000001','2020-05-18 16:50:03','test','3788.00','3488.00','0.00','300.00','0.00','0.00','0.00',2,1,1,0,NULL,NULL,15,3788,3788,'满减优惠：满3000.00元，减300.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2020-05-18 16:50:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,1,26,'202005180100000002','2020-05-18 20:22:24','test','6487.00','6037.00','0.00','300.00','0.00','150.00','0.00',1,1,3,0,'顺丰快递','12313',15,6487,6487,'满减优惠：满3000.00元，减300.00元;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','清水河街道',NULL,1,0,NULL,'2020-05-18 20:22:29','2020-05-18 20:23:03','2020-05-18 20:23:20',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,1,NULL,'202005230100000001','2020-05-23 16:21:27','test','5398.00','4318.40','0.00','1079.60','0.00','0.00','0.00',2,1,1,0,NULL,NULL,15,5398,5398,'打折优惠：满2件，打8.00折',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','清水河街道',NULL,0,0,NULL,'2020-05-23 16:21:30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,1,NULL,'202005230100000002','2020-05-23 17:01:33','test','5398.00','4318.40','0.00','1079.60','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,5398,5398,'打折优惠：满2件，打8.00折',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(44,1,NULL,'202005240100000001','2020-05-24 09:37:07','test','7576.00','7076.00','0.00','500.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,7576,7576,'满减优惠：满5000.00元，减500.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(45,1,25,'202006070100000001','2020-06-07 17:02:04','test','10275.00','9674.90','0.00','500.00','0.00','100.10','0.00',1,1,1,0,NULL,NULL,15,10275,10275,'满减优惠：满5000.00元，减500.00元;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','清水河街道',NULL,0,0,NULL,'2020-06-07 17:02:17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(46,1,24,'202006210100000001','2020-06-21 14:27:34','test','9186.00','7796.40','0.00','1379.60','0.00','10.00','0.00',2,1,1,0,NULL,NULL,15,9186,9186,'满减优惠：满3000.00元，减300.00元;打折优惠：满2件，打8.00折',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2020-06-21 14:27:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,1,NULL,'202006210100000002','2020-06-21 15:13:06','test','6487.00','6187.00','0.00','300.00','0.00','0.00','0.00',1,1,3,0,'顺丰快递','123131',15,6487,6487,'满减优惠：满3000.00元，减300.00元;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','清水河街道',NULL,1,0,NULL,'2020-06-21 15:13:12','2020-06-21 15:13:44','2020-06-21 15:13:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(48,1,26,'202006210100000003','2020-06-21 15:15:18','test','3788.00','3338.00','0.00','300.00','0.00','150.00','0.00',2,1,3,0,'圆通快递','12313',15,3788,3788,'满减优惠：满3000.00元，减300.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2020-06-21 15:15:20','2020-06-21 15:15:48','2020-06-21 15:15:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(49,1,NULL,'202006270100000001','2020-06-27 10:27:56','test','2699.00','2699.00','0.00','0.00','0.00','0.00','0.00',2,1,1,0,NULL,NULL,15,2699,2699,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','清水河街道',NULL,0,0,NULL,'2020-06-27 10:27:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(50,1,NULL,'202210280100000001','2022-10-28 14:50:58','test','2699.00','2699.00','0.00','0.00','0.00','0.00','0.00',2,1,1,0,NULL,NULL,15,2699,2699,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','清水河街道',NULL,0,0,NULL,'2022-10-28 14:51:02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,1,NULL,'202210280100000002','2022-10-28 15:27:41','test','5999.00','5999.00','0.00','0.00','0.00','0.00','0.00',2,1,1,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2022-10-28 15:27:44',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,1,30,'202211090100000001','2022-11-09 15:14:58','test','2999.00','2799.00','0.00','0.00','0.00','200.00','0.00',2,1,3,0,'顺丰快递','1233',15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2022-11-09 15:15:00','2022-11-09 15:16:12','2022-11-09 15:16:31',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(53,1,27,'202211090100000002','2022-11-09 15:25:38','test','3599.00','3589.00','0.00','0.00','0.00','10.00','0.00',2,1,1,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2022-11-09 15:25:41',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,1,29,'202211090100000003','2022-11-09 15:26:11','test','5999.00','5399.00','0.00','0.00','0.00','600.00','0.00',2,1,1,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2022-11-09 15:26:13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,1,NULL,'202211100100000001','2022-11-10 16:57:59','test','11998.00','11998.00','0.00','0.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(56,1,28,'202211110100000001','2022-11-11 16:12:42','test','2999.00','2899.00','0.00','0.00','0.00','100.00','0.00',2,1,1,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2022-11-11 16:12:48',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(57,1,NULL,'202211110100000002','2022-11-11 16:13:14','test','2999.00','2999.00','0.00','0.00','0.00','0.00','0.00',2,1,1,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2022-11-11 16:13:21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(58,1,NULL,'202211110100000003','2022-11-11 16:15:08','test','5999.00','5999.00','0.00','0.00','0.00','0.00','0.00',2,1,1,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2022-11-11 16:17:46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(59,1,NULL,'202211110100000004','2022-11-11 16:21:12','test','649.00','599.00','0.00','50.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,649,649,'满减优惠：满500.00元，减50.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(60,1,NULL,'202211160100000001','2022-11-16 10:36:08','test','11097.00','11097.00','0.00','0.00','0.00','0.00','0.00',2,1,3,0,'顺丰快递','1234555',15,0,0,'无优惠;无优惠;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2022-11-16 10:37:25','2022-11-16 10:42:50','2022-11-16 10:44:40',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(61,1,NULL,'202212210100000001','2022-12-21 15:49:08','test','2999.00','2999.00','0.00','0.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(62,1,NULL,'202212210100000002','2022-12-21 15:49:57','test','8098.00','8098.00','0.00','0.00','0.00','0.00','0.00',2,1,3,0,'顺丰快递','SDFERR7845',15,0,0,'无优惠;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2022-12-21 15:50:00','2022-12-21 15:50:23','2022-12-21 15:50:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(63,1,NULL,'202212210100000003','2022-12-21 15:51:09','test','2999.00','2999.00','0.00','0.00','0.00','0.00','0.00',2,1,3,0,'顺丰快递','112',15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2022-12-21 15:51:11','2023-01-10 10:14:12','2024-07-17 15:59:02',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(64,1,NULL,'202212210100000004','2022-12-21 15:51:35','test','2099.00','2099.00','0.00','0.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(65,1,28,'202212210100000005','2022-12-21 16:53:07','test','5098.00','4788.00','0.00','200.00','10.00','100.00','0.00',2,1,3,0,'圆通快递','115',15,0,0,'满减优惠：满2000.00元，减200.00元;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2022-12-21 16:53:58','2023-01-10 10:14:12','2024-07-17 16:01:09',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(66,1,NULL,'202301100100000001','2023-01-10 15:34:59','test','5998.00','5798.00','0.00','200.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,0,0,'满减优惠：满2000.00元，减200.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(67,1,NULL,'202301100100000002','2023-01-10 15:39:07','test','3788.00','3488.00','0.00','300.00','0.00','0.00','0.00',2,1,1,0,NULL,NULL,15,3788,3788,'满减优惠：满3000.00元，减300.00元',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2023-01-10 15:39:16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(68,1,NULL,'202301100100000003','2023-01-10 16:58:19','test','3999.00','3899.00','0.00','100.00','0.00','0.00','0.00',2,1,1,0,NULL,NULL,15,3788,3788,'单品促销',NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2023-01-10 16:58:21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(69,11,30,'202305110100000001','2023-05-11 15:28:56','member','5098.00','4698.00','0.00','200.00','0.00','200.00','0.00',2,1,3,0,'顺丰快递','1231313',15,0,0,'满减优惠：满2000.00元，减200.00元;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'小李','18961511111','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2023-05-11 15:28:59','2023-05-11 15:30:08','2023-05-11 15:30:16',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(70,11,NULL,'202305110100000002','2023-05-11 15:30:36','member','3599.00','3599.00','0.00','0.00','0.00','0.00','0.00',2,1,3,0,'顺丰快递','232342',15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'小李','18961511111','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2023-05-11 15:30:40','2023-05-11 15:31:22','2023-05-11 15:31:30',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(71,11,NULL,'202305110100000003','2023-05-11 15:31:55','member','5999.00','5999.00','0.00','0.00','0.00','0.00','0.00',0,1,4,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'小李','18961511111','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(72,11,NULL,'202305110100000004','2023-05-11 15:33:13','member','5368.00','5368.00','0.00','0.00','0.00','0.00','0.00',2,1,2,0,'圆通快递','1231434',15,0,0,'无优惠;无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'小李','18961511111','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2023-05-11 15:33:21','2023-05-11 15:33:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(73,11,NULL,'202305110100000005','2023-05-11 15:34:39','member','5999.00','5999.00','0.00','0.00','0.00','0.00','0.00',0,1,0,0,NULL,NULL,15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'小李','18961511111','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(74,11,NULL,'202305110100000006','2023-05-11 15:35:05','member','2999.00','2799.00','0.00','200.00','0.00','0.00','0.00',2,1,2,0,'顺丰快递','123131',15,0,0,'满减优惠：满2000.00元，减200.00元',NULL,NULL,NULL,NULL,NULL,NULL,'小李','18961511111','518000','广东省','深圳市','福田区','东晓街道',NULL,0,0,NULL,'2023-05-11 15:35:08','2023-05-11 15:36:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(75,11,NULL,'202305110100000007','2023-05-11 15:35:24','member','2099.00','2099.00','0.00','0.00','0.00','0.00','0.00',2,1,3,0,'顺丰快递','123131311',15,0,0,'无优惠',NULL,NULL,NULL,NULL,NULL,NULL,'小李','18961511111','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2023-05-11 15:35:26','2023-05-11 15:36:11','2023-05-11 15:36:34',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(76,11,28,'202305110100000008','2023-05-11 15:37:16','member','8998.00','8698.00','0.00','200.00','0.00','100.00','0.00',2,1,3,0,'顺丰快递','1231313',15,0,0,'无优惠;满减优惠：满2000.00元，减200.00元',NULL,NULL,NULL,NULL,NULL,NULL,'小李','18961511111','518000','广东省','深圳市','福田区','东晓街道',NULL,1,0,NULL,'2023-05-11 15:37:18','2023-05-11 15:37:33','2023-05-11 15:37:48',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(77,1,NULL,'202407220100000001','2024-07-22 14:59:54','test','98.00','98.00','0.00',NULL,NULL,NULL,'0.00',0,1,4,0,NULL,NULL,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','United States','ican',NULL),(78,1,NULL,'202407220100000002','2024-07-22 15:24:12','test','5397.00','5397.00','0.00',NULL,NULL,NULL,'0.00',0,1,4,0,NULL,NULL,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','United States','ican',NULL),(79,1,NULL,'202407230100000001','2024-07-23 17:30:14','test','649.00','649.00','0.00',NULL,NULL,NULL,'500.00',3,1,1,0,NULL,NULL,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,'2024-07-25 14:47:09',NULL,NULL,NULL,'2024-07-24 09:38:52','test@gmaill.com','dfdf','United States','ican','PAYID-M2Q7JZY01U67277UD340205S'),(80,1,NULL,'2024072501null000001','2024-07-25 08:59:33','test','649.00','649.00','0.00',NULL,NULL,NULL,'0.00',NULL,1,4,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'abel','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican',NULL),(81,1,NULL,'2024072501null000002','2024-07-25 09:03:25','test','98.00','98.00','0.00',NULL,NULL,NULL,'0.00',NULL,1,4,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'abel','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican',NULL),(82,1,NULL,'2024072501null000003','2024-07-25 09:08:28','test','649.00','649.00','0.00',NULL,NULL,NULL,'0.00',NULL,1,4,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'abel','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican',NULL),(86,1,NULL,'2024072501null000007','2024-07-25 09:17:01','test','649.00','649.00','0.00',NULL,NULL,NULL,'0.00',NULL,1,4,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'abel','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican',NULL),(89,1,NULL,'2024072501null000010','2024-07-25 09:20:59','test','2699.00','2699.00','0.00',NULL,NULL,NULL,'0.00',NULL,1,4,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'abel','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican','PAYID-M2Q2REI2E863415095108746'),(90,1,NULL,'2024072501null000011','2024-07-25 09:26:50','test','5499.00','5499.00','0.00',NULL,NULL,NULL,'0.00',NULL,1,4,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'abel','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican',NULL),(92,1,NULL,'2024072501null000013','2024-07-25 09:29:31','test','5499.00','5499.00','0.00',NULL,NULL,NULL,'0.00',NULL,1,4,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'abel','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican',NULL),(94,1,NULL,'2024072501null000015','2024-07-25 09:56:25','test','5999.00','5999.00','0.00',NULL,NULL,NULL,'0.00',NULL,1,4,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'abel','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican',NULL),(95,1,NULL,'202407250100000016','2024-07-25 11:44:48','test','6096.00','6096.00','0.00',NULL,NULL,NULL,'0.00',0,1,4,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1111','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican','PAYID-M2Q4UPI0AC47400FC943942B'),(96,1,NULL,'202407250100000017','2024-07-25 13:47:36','test','499.00','499.00','0.00',NULL,NULL,NULL,'0.00',3,1,1,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1111','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,'2024-07-25 14:43:31',NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican','PAYID-M2Q7ICY74X63406F0471744P'),(97,1,NULL,'202407250100000018','2024-07-25 14:05:33','test','6698.00','6698.00','0.00',NULL,NULL,NULL,'0.00',3,1,1,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1111','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,'2024-07-25 14:32:05',NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican','PAYID-M2Q672A47X02690HR568382N'),(98,1,NULL,'202407250100000019','2024-07-25 16:34:58','test','2999.00','2999.00','0.00',NULL,NULL,NULL,'0.00',3,1,1,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1111','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,'2024-07-25 16:40:19',NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican','PAYID-M2RA4NY5Y1586485D106850W'),(99,1,NULL,'202407250100000020','2024-07-25 16:41:53','test','2999.00','2999.00','0.00',NULL,NULL,NULL,'0.00',3,1,1,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1111','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,'2024-07-25 16:42:10',NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican','PAYID-M2RA7VI4D069804KP2864526'),(100,1,NULL,'202407250100000021','2024-07-25 16:45:11','test','2699.00','2699.00','0.00',NULL,NULL,NULL,'0.00',3,1,1,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1111','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,'2024-07-25 16:46:30',NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican','PAYID-M2RBBHI6NB63049P9257740G'),(101,1,NULL,'202407250100000022','2024-07-25 16:48:47','test','5499.00','5499.00','0.00',NULL,NULL,NULL,'0.00',3,1,1,0,NULL,NULL,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1111','大梨','18033441849','518000','广东省','深圳市','南山区','科兴科学园',NULL,0,0,NULL,'2024-07-25 16:50:09',NULL,NULL,NULL,NULL,'test@gmaill.com','dfdf','USA','ican','PAYID-M2RBC4Y2ET97176MP2611008');

/*Table structure for table `oms_order_item` */

DROP TABLE IF EXISTS `oms_order_item`;

CREATE TABLE `oms_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `order_sn` varchar(64) DEFAULT NULL COMMENT '订单编号',
  `product_id` bigint(20) DEFAULT NULL,
  `product_pic` varchar(500) DEFAULT NULL,
  `product_name` varchar(200) DEFAULT NULL,
  `product_brand` varchar(200) DEFAULT NULL,
  `product_sn` varchar(64) DEFAULT NULL,
  `product_price` decimal(10,2) DEFAULT NULL COMMENT '销售价格',
  `product_quantity` int(11) DEFAULT NULL COMMENT '购买数量',
  `product_sku_id` bigint(20) DEFAULT NULL COMMENT '商品sku编号',
  `product_sku_code` varchar(50) DEFAULT NULL COMMENT '商品sku条码',
  `product_category_id` bigint(20) DEFAULT NULL COMMENT '商品分类id',
  `promotion_name` varchar(200) DEFAULT NULL COMMENT '商品促销名称',
  `promotion_amount` decimal(10,2) DEFAULT NULL COMMENT '商品促销分解金额',
  `coupon_amount` decimal(10,2) DEFAULT NULL COMMENT '优惠券优惠分解金额',
  `integration_amount` decimal(10,2) DEFAULT NULL COMMENT '积分优惠分解金额',
  `real_amount` decimal(10,2) DEFAULT NULL COMMENT '该商品经过优惠后的分解金额',
  `gift_integration` int(11) DEFAULT '0',
  `gift_growth` int(11) DEFAULT '0',
  `product_attr` varchar(500) DEFAULT NULL COMMENT '商品销售属性:[{"key":"颜色","value":"颜色"},{"key":"容量","value":"4G"}]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单中所包含的商品';

/*Data for the table `oms_order_item` */

insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`product_id`,`product_pic`,`product_name`,`product_brand`,`product_sn`,`product_price`,`product_quantity`,`product_sku_id`,`product_sku_code`,`product_category_id`,`promotion_name`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`,`product_attr`) values (21,12,'201809150101000001',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','6946605','3788.00',1,90,'201806070026001',19,'单品促销','200.00','2.02','0.00','3585.98',3788,3788,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(22,12,'201809150101000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','7437788','2699.00',3,98,'201808270027001',19,'打折优惠：满3件，打7.50折','674.75','1.44','0.00','2022.81',2699,2699,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(23,12,'201809150101000001',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','7437789','649.00',1,102,'201808270028001',19,'满减优惠：满1000.00元，减120.00元','57.60','0.35','0.00','591.05',649,649,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(24,12,'201809150101000001',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','7437789','699.00',1,103,'201808270028001',19,'满减优惠：满1000.00元，减120.00元','62.40','0.37','0.00','636.23',649,649,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(25,12,'201809150101000001',29,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg','Apple iPhone 8 Plus','苹果','7437799','5499.00',1,106,'201808270029001',19,'无优惠','0.00','2.94','0.00','5496.06',5499,5499,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(26,13,'201809150102000002',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','6946605','3788.00',1,90,'201806070026001',19,'单品促销','200.00','2.02','0.00','3585.98',3788,3788,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(27,13,'201809150102000002',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','7437788','2699.00',3,98,'201808270027001',19,'打折优惠：满3件，打7.50折','674.75','1.44','0.00','2022.81',2699,2699,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(28,13,'201809150102000002',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','7437789','649.00',1,102,'201808270028001',19,'满减优惠：满1000.00元，减120.00元','57.60','0.35','0.00','591.05',649,649,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(29,13,'201809150102000002',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','7437789','699.00',1,103,'201808270028001',19,'满减优惠：满1000.00元，减120.00元','62.40','0.37','0.00','636.23',649,649,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(30,13,'201809150102000002',29,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg','Apple iPhone 8 Plus','苹果','7437799','5499.00',1,106,'201808270029001',19,'无优惠','0.00','2.94','0.00','5496.06',5499,5499,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(31,14,'201809130101000001',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','6946605','3788.00',1,90,'201806070026001',19,'单品促销','200.00','2.02','0.00','3585.98',3788,3788,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(32,14,'201809130101000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','7437788','2699.00',3,98,'201808270027001',19,'打折优惠：满3件，打7.50折','674.75','1.44','0.00','2022.81',2699,2699,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(33,14,'201809130101000001',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','7437789','649.00',1,102,'201808270028001',19,'满减优惠：满1000.00元，减120.00元','57.60','0.35','0.00','591.05',649,649,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(34,14,'201809130101000001',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','7437789','699.00',1,103,'201808270028001',19,'满减优惠：满1000.00元，减120.00元','62.40','0.37','0.00','636.23',649,649,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(35,14,'201809130101000001',29,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg','Apple iPhone 8 Plus','苹果','7437799','5499.00',1,106,'201808270029001',19,'无优惠','0.00','2.94','0.00','5496.06',5499,5499,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(36,15,'201809130101000001',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','6946605','3788.00',1,90,'201806070026001',19,'单品促销','200.00','2.02','0.00','3585.98',3788,3788,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(37,15,'201809130101000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','7437788','2699.00',3,98,'201808270027001',19,'打折优惠：满3件，打7.50折','674.75','1.44','0.00','2022.81',2699,2699,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(38,15,'201809130101000001',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','7437789','649.00',1,102,'201808270028001',19,'满减优惠：满1000.00元，减120.00元','57.60','0.35','0.00','591.05',649,649,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(39,15,'201809130101000001',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','7437789','699.00',1,103,'201808270028001',19,'满减优惠：满1000.00元，减120.00元','62.40','0.37','0.00','636.23',649,649,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(40,15,'201809130101000001',29,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg','Apple iPhone 8 Plus','苹果','7437799','5499.00',1,106,'201808270029001',19,'无优惠','0.00','2.94','0.00','5496.06',5499,5499,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(41,16,'201809140101000001',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','6946605','3788.00',1,90,'201806070026001',19,'单品促销','200.00','2.02','0.00','3585.98',3788,3788,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(42,16,'201809140101000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','7437788','2699.00',3,98,'201808270027001',19,'打折优惠：满3件，打7.50折','674.75','1.44','0.00','2022.81',2699,2699,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(43,16,'201809140101000001',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','7437789','649.00',1,102,'201808270028001',19,'满减优惠：满1000.00元，减120.00元','57.60','0.35','0.00','591.05',649,649,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(44,16,'201809140101000001',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','7437789','699.00',1,103,'201808270028001',19,'满减优惠：满1000.00元，减120.00元','62.40','0.37','0.00','636.23',649,649,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(45,16,'201809140101000001',29,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg','Apple iPhone 8 Plus','苹果','7437799','5499.00',1,106,'201808270029001',19,'无优惠','0.00','2.94','0.00','5496.06',5499,5499,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(46,27,'202002250100000001',36,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg','耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码','NIKE','6799345','100.00',3,163,'202002210036001',29,'无优惠','0.00','0.00','0.00','100.00',0,0,NULL),(47,27,'202002250100000001',36,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg','耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码','NIKE','6799345','120.00',2,164,'202002210036001',29,'无优惠','0.00','0.00','0.00','120.00',0,0,NULL),(48,28,'202002250100000002',36,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg','耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码','NIKE','6799345','100.00',3,163,'202002210036001',29,'无优惠','0.00','0.00','0.00','100.00',0,0,NULL),(49,28,'202002250100000002',36,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg','耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码','NIKE','6799345','120.00',2,164,'202002210036001',29,'无优惠','0.00','0.00','0.00','120.00',0,0,NULL),(50,29,'202002250100000003',36,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg','耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码','NIKE','6799345','100.00',3,163,'202002210036001',29,'无优惠','0.00','0.00','0.00','100.00',0,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"秋季\"}]'),(51,29,'202002250100000003',36,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg','耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码','NIKE','6799345','120.00',2,164,'202002210036001',29,'无优惠','0.00','0.00','0.00','120.00',0,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),(52,30,'202002250100000004',36,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg','耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码','NIKE','6799345','120.00',2,164,'202002210036001',29,'无优惠','0.00','0.00','0.00','120.00',0,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),(53,31,'202005160100000001',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',2,110,'201806070026001',19,'满减优惠：满5000.00元，减500.00元','250.00','75.00','0.28','3462.72',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(54,31,'202005160100000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',2,98,'201808270027001',19,'打折优惠：满2件，打8.00折','539.80','0.00','0.20','2159.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(55,31,'202005160100000001',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','小米 红米5A 全网通版 3GB+32GB 香槟金 移动联通电信4G手机 双卡双待','小米','7437789','649.00',1,102,'201808270028001',19,'满减优惠：满500.00元，减50.00元','50.00','0.00','0.05','598.95',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(56,32,'202005170100000001',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','0.00','0.00','3488.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(57,32,'202005170100000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',1,98,'201808270027001',19,'无优惠','0.00','0.00','0.00','2699.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(58,33,'202005170100000002',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','0.00','0.00','3488.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(59,34,'202005170100000003',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','0.00','0.00','3488.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(60,35,'202005170100000004',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','0.00','0.00','3488.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(61,36,'202005170100000005',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',2,110,'201806070026001',19,'满减优惠：满5000.00元，减500.00元','250.00','0.00','0.00','3538.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(62,36,'202005170100000005',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',1,98,'201808270027001',19,'无优惠','0.00','0.00','0.00','2699.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(63,37,'202005170100000006',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','0.00','0.00','3488.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(64,37,'202005170100000006',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',1,98,'201808270027001',19,'无优惠','0.00','0.00','0.00','2699.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(65,38,'202005170100000007',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','0.00','0.00','3488.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(66,39,'202005170100000008',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','0.00','0.00','3488.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(67,40,'202005180100000001',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','0.00','0.00','3488.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(68,41,'202005180100000002',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','150.00','0.00','3338.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(69,41,'202005180100000002',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',1,98,'201808270027001',19,'无优惠','0.00','0.00','0.00','2699.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(70,42,'202005230100000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',2,98,'201808270027001',19,'打折优惠：满2件，打8.00折','539.80','0.00','0.00','2159.20',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(71,43,'202005230100000002',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',2,98,'201808270027001',19,'打折优惠：满2件，打8.00折','539.80','0.00','0.00','2159.20',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(72,44,'202005240100000001',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',2,110,'201806070026001',19,'满减优惠：满5000.00元，减500.00元','250.00','0.00','0.00','3538.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(73,45,'202006070100000001',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',2,110,'201806070026001',19,'满减优惠：满5000.00元，减500.00元','250.00','36.90','0.00','3501.10',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(74,45,'202006070100000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',1,98,'201808270027001',19,'无优惠','0.00','26.30','0.00','2672.70',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(75,46,'202006210100000001',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','4.12','0.00','3483.88',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(76,46,'202006210100000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',2,98,'201808270027001',19,'打折优惠：满2件，打8.00折','539.80','2.94','0.00','2156.26',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(77,47,'202006210100000002',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','0.00','0.00','3488.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(78,47,'202006210100000002',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',1,98,'201808270027001',19,'无优惠','0.00','0.00','0.00','2699.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(79,48,'202006210100000003',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','150.00','0.00','3338.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(80,49,'202006270100000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',1,98,'201808270027001',19,'无优惠','0.00','0.00','0.00','2699.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(81,50,'202210280100000001',27,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','小米','7437788','2699.00',1,98,'201808270027001',19,'无优惠','0.00','0.00','0.00','2699.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(82,51,'202210280100000002',37,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg','Apple iPhone 14 (A2884) 128GB 紫色 支持移动联通电信5G 双卡双待手机','苹果','100038005189','5999.00',1,201,'202210280037001',19,'无优惠','0.00','0.00','0.00','5999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"午夜色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(83,52,'202211090100000001',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充 12GB+256GB 黑色 5G手机','小米','100027789721','2999.00',1,221,'202211040040001',19,'无优惠','0.00','200.00','0.00','2799.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(84,53,'202211090100000002',38,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/ipad_001.jpg','Apple iPad 10.9英寸平板电脑 2022年款（64GB WLAN版/A14芯片/1200万像素/iPadOS MPQ03CH/A ）','苹果','100044025833','3599.00',1,213,'202210280038001',53,'无优惠','0.00','10.00','0.00','3589.00',0,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"容量\",\"value\":\"64G\"}]'),(85,54,'202211090100000003',37,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg','Apple iPhone 14 (A2884) 128GB 支持移动联通电信5G 双卡双待手机','苹果','100038005189','5999.00',1,201,'202210280037001',19,'无优惠','0.00','600.00','0.00','5399.00',0,0,'[{\"key\":\"颜色\",\"value\":\"午夜色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(86,55,'202211100100000001',37,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg','Apple iPhone 14 (A2884) 128GB 支持移动联通电信5G 双卡双待手机','苹果','100038005189','5999.00',2,201,'202210280037001',19,'无优惠','0.00','0.00','0.00','5999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"午夜色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(87,56,'202211110100000001',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充 12GB+256GB 黑色 5G手机','小米','100027789721','2999.00',1,221,'202211040040001',19,'无优惠','0.00','100.00','0.00','2899.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(88,57,'202211110100000002',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充 12GB+256GB 黑色 5G手机','小米','100027789721','2999.00',1,221,'202211040040001',19,'无优惠','0.00','0.00','0.00','2999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(89,58,'202211110100000003',37,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg','Apple iPhone 14 (A2884) 128GB 支持移动联通电信5G 双卡双待手机','苹果','100038005189','5999.00',1,201,'202210280037001',19,'无优惠','0.00','0.00','0.00','5999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"午夜色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(90,59,'202211110100000004',28,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','小米 红米5A 全网通版 3GB+32GB 香槟金 移动联通电信4G手机 双卡双待','小米','7437789','649.00',1,102,'201808270028001',19,'满减优惠：满500.00元，减50.00元','50.00','0.00','0.00','599.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(91,60,'202211160100000001',37,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg','Apple iPhone 14 (A2884) 128GB 支持移动联通电信5G 双卡双待手机','苹果','100038005189','5999.00',1,201,'202210280037001',19,'无优惠','0.00','0.00','0.00','5999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"午夜色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(92,60,'202211160100000001',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充','小米','100027789721','2999.00',1,221,'202211040040001',19,'无优惠','0.00','0.00','0.00','2999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(93,60,'202211160100000001',41,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_01.jpg','Redmi K50 天玑8100 2K柔性直屏 OIS光学防抖 67W快充 5500mAh大电量','小米','100035246702','2099.00',1,225,'202211040041001',19,'无优惠','0.00','0.00','0.00','2099.00',0,0,'[{\"key\":\"颜色\",\"value\":\"墨羽\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(94,61,'202212210100000001',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充','小米','100027789721','2999.00',1,221,'202211040040001',19,'无优惠','0.00','0.00','0.00','2999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(95,62,'202212210100000002',37,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg','Apple iPhone 14 (A2884) 128GB 支持移动联通电信5G 双卡双待手机','苹果','100038005189','5999.00',1,201,'202210280037001',19,'无优惠','0.00','0.00','0.00','5999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"午夜色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(96,62,'202212210100000002',41,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_01.jpg','Redmi K50 天玑8100 2K柔性直屏 OIS光学防抖 67W快充 5500mAh大电量','小米','100035246702','2099.00',1,225,'202211040041001',19,'无优惠','0.00','0.00','0.00','2099.00',0,0,'[{\"key\":\"颜色\",\"value\":\"墨羽\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(97,63,'202212210100000003',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充','小米','100027789721','2999.00',1,221,'202211040040001',19,'无优惠','0.00','0.00','0.00','2999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(98,64,'202212210100000004',41,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_01.jpg','Redmi K50 天玑8100 2K柔性直屏 OIS光学防抖 67W快充 5500mAh大电量','小米','100035246702','2099.00',1,225,'202211040041001',19,'无优惠','0.00','0.00','0.00','2099.00',0,0,'[{\"key\":\"颜色\",\"value\":\"墨羽\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(99,65,'202212210100000005',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充','小米','100027789721','2999.00',1,221,'202211040040001',19,'满减优惠：满2000.00元，减200.00元','200.00','58.80','5.88','2734.32',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(100,65,'202212210100000005',41,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_01.jpg','Redmi K50 天玑8100 2K柔性直屏 OIS光学防抖 67W快充 5500mAh大电量','小米','100035246702','2099.00',1,225,'202211040041001',19,'无优惠','0.00','41.20','4.12','2053.68',0,0,'[{\"key\":\"颜色\",\"value\":\"墨羽\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(101,66,'202301100100000001',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充','小米','100027789721','2999.00',2,221,'202211040040001',19,'满减优惠：满2000.00元，减200.00元','100.00','0.00','0.00','2899.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(102,67,'202301100100000002',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3788.00',1,110,'201806070026001',19,'满减优惠：满3000.00元，减300.00元','300.00','0.00','0.00','3488.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(103,68,'202301100100000003',26,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20 ','华为','6946605','3999.00',1,111,'201806070026002',19,'单品促销','100.00','0.00','0.00','3899.00',0,0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(104,69,'202305110100000001',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充','小米','100027789721','2999.00',1,221,'202211040040001',19,'满减优惠：满2000.00元，减200.00元','200.00','117.60','0.00','2681.40',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(105,69,'202305110100000001',41,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_01.jpg','Redmi K50 天玑8100 2K柔性直屏 OIS光学防抖 67W快充 5500mAh大电量','小米','100035246702','2099.00',1,225,'202211040041001',19,'无优惠','0.00','82.40','0.00','2016.60',0,0,'[{\"key\":\"颜色\",\"value\":\"墨羽\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(106,70,'202305110100000002',38,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/ipad_001.jpg','Apple iPad 10.9英寸平板电脑 2022年款','苹果','100044025833','3599.00',1,213,'202210280038001',53,'无优惠','0.00','0.00','0.00','3599.00',0,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"容量\",\"value\":\"64G\"}]'),(107,71,'202305110100000003',39,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/xiaomi_computer_001.jpg','小米 Xiaomi Book Pro 14 2022 锐龙版 2.8K超清大师屏 高端轻薄笔记本电脑','小米','100023207945','5999.00',1,217,'202210280039001',54,'无优惠','0.00','0.00','0.00','5999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"新小米Pro 14英寸 2.8K屏\"},{\"key\":\"版本\",\"value\":\"R7 16G 512\"}]'),(108,72,'202305110100000004',42,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/huawei_mate50_01.jpg','HUAWEI Mate 50 直屏旗舰 超光变XMAGE影像 北斗卫星消息','华为','100035295081','4999.00',1,229,'202211040042001',19,'无优惠','0.00','0.00','0.00','4999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"曜金黑\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(109,72,'202305110100000004',44,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/sanxing_ssd_02.jpg','三星（SAMSUNG）500GB SSD固态硬盘 M.2接口(NVMe协议)','三星','100018768480','369.00',1,235,'202211080044001',55,'无优惠','0.00','0.00','0.00','369.00',0,0,'[{\"key\":\"颜色\",\"value\":\"新品980｜NVMe PCIe3.0*4\"},{\"key\":\"版本\",\"value\":\"512GB\"}]'),(110,73,'202305110100000005',37,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg','Apple iPhone 14 (A2884) 128GB 支持移动联通电信5G 双卡双待手机','苹果','100038005189','5999.00',1,201,'202210280037001',19,'无优惠','0.00','0.00','0.00','5999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"午夜色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(111,74,'202305110100000006',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充','小米','100027789721','2999.00',1,221,'202211040040001',19,'满减优惠：满2000.00元，减200.00元','200.00','0.00','0.00','2799.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(112,75,'202305110100000007',41,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_01.jpg','Redmi K50 天玑8100 2K柔性直屏 OIS光学防抖 67W快充 5500mAh大电量','小米','100035246702','2099.00',1,225,'202211040041001',19,'无优惠','0.00','0.00','0.00','2099.00',0,0,'[{\"key\":\"颜色\",\"value\":\"墨羽\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(113,76,'202305110100000008',39,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/xiaomi_computer_001.jpg','小米 Xiaomi Book Pro 14 2022 锐龙版 2.8K超清大师屏 高端轻薄笔记本电脑','小米','100023207945','5999.00',1,217,'202210280039001',54,'无优惠','0.00','0.00','0.00','5999.00',0,0,'[{\"key\":\"颜色\",\"value\":\"新小米Pro 14英寸 2.8K屏\"},{\"key\":\"版本\",\"value\":\"R7 16G 512\"}]'),(114,76,'202305110100000008',40,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_01.jpg','小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充','小米','100027789721','2999.00',1,221,'202211040040001',19,'满减优惠：满2000.00元，减200.00元','200.00','100.00','0.00','2699.00',0,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(115,77,'202407220100000001',31,'http://154.92.22.163:9000/mall/20240703/selling-products15.jpg','Stylish Grey T-Shirt34','海澜之家','HNTBJ2E080A','98.00',1,NULL,NULL,8,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"浅灰色\"},{\"key\":\"商品编号\",\"value\":\"HNTBJ2E080A\"},{\"key\":\"适用季节\",\"value\":\"夏季\"},{\"key\":\"适用人群\",\"value\":\"青年\"},{\"key\":\"上市时间\",\"value\":\"2018年夏\"},{\"key\":\"袖长\",\"value\":\"短袖\"}]'),(116,78,'202407220100000002',43,'http://154.92.22.163:9000/mall/20240703/product-item1.jpg','Full Sleeve Cover Shirt','万和','10044060351752','1799.00',3,NULL,NULL,39,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"系列\",\"value\":\"JSQ25-565W13【13升】【恒温旗舰款】\"},{\"key\":\"上市时间\",\"value\":\"2021-05\"},{\"key\":\"毛重\",\"value\":\"15.5kg\"},{\"key\":\"额定功率\",\"value\":\"30w\"}]'),(117,79,'202407230100000001',28,'http://154.92.22.163:9000/mall/20240703/selling-products13.jpg','Half Sleeve T-Shirt','小米','7437789','649.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.0\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"2800ml\"}]'),(118,80,'2024072501null000001',28,'http://154.92.22.163:9000/mall/20240703/selling-products13.jpg','Half Sleeve T-Shirt','小米','7437789','649.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.0\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"2800ml\"}]'),(119,81,'2024072501null000002',30,'http://154.92.22.163:9000/mall/20240703/review-image1.jpg','Stylish Grey T-Shirt23','海澜之家','HNTBJ2E042A','98.00',1,NULL,NULL,8,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"白色\"},{\"key\":\"商品编号\",\"value\":\"HNTBJ2E042A\"},{\"key\":\"适用季节\",\"value\":\"夏季\"},{\"key\":\"适用人群\",\"value\":\"青年\"},{\"key\":\"上市时间\",\"value\":\"2018年夏\"},{\"key\":\"袖长\",\"value\":\"短袖\"}]'),(120,82,'2024072501null000003',28,'http://154.92.22.163:9000/mall/20240703/selling-products13.jpg','Half Sleeve T-Shirt','小米','7437789','649.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.0\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"2800ml\"}]'),(121,86,'2024072501null000007',28,'http://154.92.22.163:9000/mall/20240703/selling-products13.jpg','Half Sleeve T-Shirt','小米','7437789','649.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.0\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"2800ml\"}]'),(122,89,'2024072501null000010',27,'http://154.92.22.163:9000/mall/20240703/product-item4.jpg','Long Belly Grey Pant','小米','7437788','2699.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.8\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"3000ml\"}]'),(123,90,'2024072501null000011',29,'http://154.92.22.163:9000/mall/20240703/selling-products5.jpg','Stylish Grey T-Shirt','苹果','7437799','5499.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]'),(124,92,'2024072501null000013',29,'http://154.92.22.163:9000/mall/20240703/selling-products5.jpg','Stylish Grey T-Shirt','苹果','7437799','5499.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]'),(125,94,'2024072501null000015',37,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg','Apple iPhone 14 (A2884) 128GB 支持移动联通电信5G 双卡双待手机','苹果','100038005189','5999.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"6.1英寸\"},{\"key\":\"网络\",\"value\":\"5G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"3000毫安\"}]'),(126,95,'202407250100000016',31,'http://154.92.22.163:9000/mall/20240703/selling-products15.jpg','Stylish Grey T-Shirt34','海澜之家','HNTBJ2E080A','98.00',1,NULL,NULL,8,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"深灰色\"},{\"key\":\"商品编号\",\"value\":\"HNTBJ2E080A\"},{\"key\":\"适用季节\",\"value\":\"夏季\"},{\"key\":\"适用人群\",\"value\":\"青年\"},{\"key\":\"上市时间\",\"value\":\"2018年夏\"},{\"key\":\"袖长\",\"value\":\"短袖\"}]'),(127,95,'202407250100000016',40,'http://154.92.22.163:9000/mall/20240703/product-item2.jpg','Volunteer Half Blue','小米','100027789721','2999.00',2,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"6.73英寸\"},{\"key\":\"网络\",\"value\":\"5G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"5160mAh\"}]'),(128,96,'202407250100000017',36,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg','耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码','NIKE','6799345','499.00',1,NULL,NULL,29,'无优惠','0.00','0.00','0.00',NULL,0,0,'[]'),(129,97,'202407250100000018',27,'http://154.92.22.163:9000/mall/20240703/product-item4.jpg','Long Belly Grey Pant','小米','7437788','2699.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.8\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"3000ml\"}]'),(130,97,'202407250100000018',34,'http://154.92.22.163:9000/mall/20240703/selling-products18.jpg','Stylish Grey T-Shirt45','小米','4609660','3999.00',1,NULL,NULL,35,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"商品编号\",\"value\":\"4609660\"},{\"key\":\"商品毛重\",\"value\":\"30.8kg\"},{\"key\":\"商品产地\",\"value\":\"中国大陆\"},{\"key\":\"电视类型\",\"value\":\"4K超清\"}]'),(131,98,'202407250100000019',40,'http://154.92.22.163:9000/mall/20240703/product-item2.jpg','Volunteer Half Blue','小米','100027789721','2999.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"6.73英寸\"},{\"key\":\"网络\",\"value\":\"5G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"5160mAh\"}]'),(132,99,'202407250100000020',40,'http://154.92.22.163:9000/mall/20240703/product-item2.jpg','Volunteer Half Blue','小米','100027789721','2999.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"6.73英寸\"},{\"key\":\"网络\",\"value\":\"5G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"5160mAh\"}]'),(133,100,'202407250100000021',27,'http://154.92.22.163:9000/mall/20240703/product-item4.jpg','Long Belly Grey Pant','小米','7437788','2699.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"屏幕尺寸\",\"value\":\"5.8\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"Android\"},{\"key\":\"电池容量\",\"value\":\"3000ml\"}]'),(134,101,'202407250100000022',29,'http://154.92.22.163:9000/mall/20240703/selling-products5.jpg','Stylish Grey T-Shirt','苹果','7437799','5499.00',1,NULL,NULL,19,'无优惠','0.00','0.00','0.00',NULL,0,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]');

/*Table structure for table `oms_order_operate_history` */

DROP TABLE IF EXISTS `oms_order_operate_history`;

CREATE TABLE `oms_order_operate_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `operate_man` varchar(100) DEFAULT NULL COMMENT '操作人：用户；系统；后台管理员',
  `create_time` datetime DEFAULT NULL COMMENT '操作时间',
  `order_status` int(1) DEFAULT NULL COMMENT '订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单',
  `note` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单操作历史记录';

/*Data for the table `oms_order_operate_history` */

insert  into `oms_order_operate_history`(`id`,`order_id`,`operate_man`,`create_time`,`order_status`,`note`) values (5,12,'后台管理员','2018-10-12 14:01:29',2,'完成发货'),(6,13,'后台管理员','2018-10-12 14:01:29',2,'完成发货'),(7,12,'后台管理员','2018-10-12 14:13:10',4,'订单关闭:买家退货'),(8,13,'后台管理员','2018-10-12 14:13:10',4,'订单关闭:买家退货'),(9,22,'后台管理员','2018-10-15 16:31:48',4,'订单关闭:xxx'),(10,22,'后台管理员','2018-10-15 16:35:08',4,'订单关闭:xxx'),(11,22,'后台管理员','2018-10-15 16:35:59',4,'订单关闭:xxx'),(12,17,'后台管理员','2018-10-15 16:43:40',4,'订单关闭:xxx'),(13,25,'后台管理员','2018-10-15 16:52:14',4,'订单关闭:xxx'),(14,26,'后台管理员','2018-10-15 16:52:14',4,'订单关闭:xxx'),(15,23,'后台管理员','2018-10-16 14:41:28',2,'完成发货'),(16,13,'后台管理员','2018-10-16 14:42:17',2,'完成发货'),(17,18,'后台管理员','2018-10-16 14:42:17',2,'完成发货'),(18,26,'后台管理员','2018-10-30 14:37:44',4,'订单关闭:关闭订单'),(19,25,'后台管理员','2018-10-30 15:07:01',0,'修改收货人信息'),(20,25,'后台管理员','2018-10-30 15:08:13',0,'修改费用信息'),(21,25,'后台管理员','2018-10-30 15:08:31',0,'修改备注信息：xxx'),(22,25,'后台管理员','2018-10-30 15:08:39',4,'订单关闭:2222'),(23,12,'后台管理员','2019-11-09 16:50:28',4,'修改备注信息：111'),(24,30,'后台管理员','2020-02-25 16:52:37',0,'修改费用信息'),(25,30,'后台管理员','2020-02-25 16:52:51',0,'修改费用信息'),(26,30,'后台管理员','2020-02-25 16:54:03',2,'完成发货'),(27,35,'后台管理员','2020-05-17 15:30:24',2,'完成发货'),(28,37,'后台管理员','2020-05-17 19:35:00',2,'完成发货'),(29,39,'后台管理员','2020-05-17 19:42:08',2,'完成发货'),(30,41,'后台管理员','2020-05-18 20:23:04',2,'完成发货'),(31,47,'后台管理员','2020-06-21 15:13:44',2,'完成发货'),(32,48,'后台管理员','2020-06-21 15:15:49',2,'完成发货'),(33,52,'后台管理员','2022-11-09 15:16:13',2,'完成发货'),(34,60,'后台管理员','2022-11-16 10:42:50',2,'完成发货'),(35,62,'后台管理员','2022-12-21 15:50:24',2,'完成发货'),(36,63,'后台管理员','2023-01-10 10:08:34',2,'完成发货'),(37,65,'后台管理员','2023-01-10 10:08:34',2,'完成发货'),(38,69,'后台管理员','2023-05-11 15:30:08',2,'完成发货'),(39,70,'后台管理员','2023-05-11 15:31:22',2,'完成发货'),(40,72,'后台管理员','2023-05-11 15:33:43',2,'完成发货'),(41,74,'后台管理员','2023-05-11 15:36:00',2,'完成发货'),(42,75,'后台管理员','2023-05-11 15:36:11',2,'完成发货'),(43,76,'后台管理员','2023-05-11 15:37:34',2,'完成发货'),(44,13,'后台管理员','2024-07-17 10:34:31',2,'完成发货'),(45,79,'后台管理员','2024-07-24 09:38:52',0,'修改费用信息');

/*Table structure for table `oms_order_return_apply` */

DROP TABLE IF EXISTS `oms_order_return_apply`;

CREATE TABLE `oms_order_return_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `company_address_id` bigint(20) DEFAULT NULL COMMENT '收货地址表id',
  `product_id` bigint(20) DEFAULT NULL COMMENT '退货商品id',
  `order_sn` varchar(64) DEFAULT NULL COMMENT '订单编号',
  `create_time` datetime DEFAULT NULL COMMENT '申请时间',
  `member_username` varchar(64) DEFAULT NULL COMMENT '会员用户名',
  `return_amount` decimal(10,2) DEFAULT NULL COMMENT '退款金额',
  `return_name` varchar(100) DEFAULT NULL COMMENT '退货人姓名',
  `return_phone` varchar(100) DEFAULT NULL COMMENT '退货人电话',
  `status` int(1) DEFAULT NULL COMMENT '申请状态：0->待处理；1->退货中；2->已完成；3->已拒绝',
  `handle_time` datetime DEFAULT NULL COMMENT '处理时间',
  `product_pic` varchar(500) DEFAULT NULL COMMENT '商品图片',
  `product_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `product_brand` varchar(200) DEFAULT NULL COMMENT '商品品牌',
  `product_attr` varchar(500) DEFAULT NULL COMMENT '商品销售属性：颜色：红色；尺码：xl;',
  `product_count` int(11) DEFAULT NULL COMMENT '退货数量',
  `product_price` decimal(10,2) DEFAULT NULL COMMENT '商品单价',
  `product_real_price` decimal(10,2) DEFAULT NULL COMMENT '商品实际支付单价',
  `reason` varchar(200) DEFAULT NULL COMMENT '原因',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `proof_pics` varchar(1000) DEFAULT NULL COMMENT '凭证图片，以逗号隔开',
  `handle_note` varchar(500) DEFAULT NULL COMMENT '处理备注',
  `handle_man` varchar(100) DEFAULT NULL COMMENT '处理人员',
  `receive_man` varchar(100) DEFAULT NULL COMMENT '收货人',
  `receive_time` datetime DEFAULT NULL COMMENT '收货时间',
  `receive_note` varchar(500) DEFAULT NULL COMMENT '收货备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单退货申请';

/*Data for the table `oms_order_return_apply` */

insert  into `oms_order_return_apply`(`id`,`order_id`,`company_address_id`,`product_id`,`order_sn`,`create_time`,`member_username`,`return_amount`,`return_name`,`return_phone`,`status`,`handle_time`,`product_pic`,`product_name`,`product_brand`,`product_attr`,`product_count`,`product_price`,`product_real_price`,`reason`,`description`,`proof_pics`,`handle_note`,`handle_man`,`receive_man`,`receive_time`,`receive_note`) values (3,12,1,26,'201809150101000001','2018-10-17 14:34:57','test','0.00','大梨','18000000000',2,'2022-11-11 10:16:18','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','颜色：金色;内存：16G',1,'3788.00','3585.98','质量问题','老是卡','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg,http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','111','admin','admin','2022-11-11 10:16:26',NULL),(4,12,2,27,'201809150101000001','2018-10-17 14:40:21','test','3585.98','大梨','18000000000',1,'2018-10-18 13:54:10','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','颜色：黑色;内存：32G',1,'2699.00','2022.81','质量问题','不够高端','','已经处理了','admin',NULL,NULL,NULL),(5,12,3,28,'201809150101000001','2018-10-17 14:44:18','test','3585.98','大梨','18000000000',2,'2018-10-18 13:55:28','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','颜色：金色;内存：16G',1,'649.00','591.05','质量问题','颜色太土','','已经处理了','admin','admin','2018-10-18 13:55:58','已经处理了'),(8,13,NULL,28,'201809150102000002','2018-10-17 14:44:18','test',NULL,'大梨','18000000000',3,'2018-10-18 13:57:12','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','颜色：金色;内存：16G',1,'649.00','591.05','质量问题','颜色太土','','理由不够充分','admin',NULL,NULL,NULL),(9,14,2,26,'201809130101000001','2018-10-17 14:34:57','test','3500.00','大梨','18000000000',2,'2018-10-24 15:44:56','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','颜色：金色;内存：16G',1,'3788.00','3585.98','质量问题','老是卡','','呵呵','admin','admin','2018-10-24 15:46:35','收货了'),(10,14,NULL,27,'201809130101000001','2018-10-17 14:40:21','test',NULL,'大梨','18000000000',3,'2018-10-24 15:46:57','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','颜色：黑色;内存：32G',1,'2699.00','2022.81','质量问题','不够高端','','就是不退','admin',NULL,NULL,NULL),(11,14,2,28,'201809130101000001','2018-10-17 14:44:18','test','591.05','大梨','18000000000',1,'2018-10-24 17:09:04','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','颜色：金色;内存：16G',1,'649.00','591.05','质量问题','颜色太土','','可以退款','admin',NULL,NULL,NULL),(12,15,3,26,'201809130102000002','2018-10-17 14:34:57','test','3500.00','大梨','18000000000',2,'2018-10-24 17:22:54','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','颜色：金色;内存：16G',1,'3788.00','3585.98','质量问题','老是卡','','退货了','admin','admin','2018-10-24 17:23:06','收货了'),(13,15,NULL,27,'201809130102000002','2018-10-17 14:40:21','test',NULL,'大梨','18000000000',3,'2018-10-24 17:23:30','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','颜色：黑色;内存：32G',1,'2699.00','2022.81','质量问题','不够高端','','无法退货','admin',NULL,NULL,NULL),(15,16,NULL,26,'201809140101000001','2018-10-17 14:34:57','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','颜色：金色;内存：16G',1,'3788.00','3585.98','质量问题','老是卡','',NULL,NULL,NULL,NULL,NULL),(16,16,NULL,27,'201809140101000001','2018-10-17 14:40:21','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','颜色：黑色;内存：32G',1,'2699.00','2022.81','质量问题','不够高端','',NULL,NULL,NULL,NULL,NULL),(17,16,NULL,28,'201809140101000001','2018-10-17 14:44:18','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','颜色：金色;内存：16G',1,'649.00','591.05','质量问题','颜色太土','',NULL,NULL,NULL,NULL,NULL),(18,17,NULL,26,'201809150101000003','2018-10-17 14:34:57','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','颜色：金色;内存：16G',1,'3788.00','3585.98','质量问题','老是卡','',NULL,NULL,NULL,NULL,NULL),(19,17,NULL,27,'201809150101000003','2018-10-17 14:40:21','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','颜色：黑色;内存：32G',1,'2699.00','2022.81','质量问题','不够高端','',NULL,NULL,NULL,NULL,NULL),(20,17,NULL,28,'201809150101000003','2018-10-17 14:44:18','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','颜色：金色;内存：16G',1,'649.00','591.05','质量问题','颜色太土','',NULL,NULL,NULL,NULL,NULL),(21,18,NULL,26,'201809150102000004','2018-10-17 14:34:57','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','颜色：金色;内存：16G',1,'3788.00','3585.98','质量问题','老是卡','',NULL,NULL,NULL,NULL,NULL),(22,18,NULL,27,'201809150102000004','2018-10-17 14:40:21','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','颜色：黑色;内存：32G',1,'2699.00','2022.81','质量问题','不够高端','',NULL,NULL,NULL,NULL,NULL),(23,18,NULL,28,'201809150102000004','2018-10-17 14:44:18','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','颜色：金色;内存：16G',1,'649.00','591.05','质量问题','颜色太土','',NULL,NULL,NULL,NULL,NULL),(24,19,NULL,26,'201809130101000003','2018-10-17 14:34:57','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg','华为 HUAWEI P20','华为','颜色：金色;内存：16G',1,'3788.00','3585.98','质量问题','老是卡','',NULL,NULL,NULL,NULL,NULL),(25,19,NULL,27,'201809130101000003','2018-10-17 14:40:21','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg','小米8','小米','颜色：黑色;内存：32G',1,'2699.00','2022.81','质量问题','不够高端','',NULL,NULL,NULL,NULL,NULL),(26,19,NULL,28,'201809130101000003','2018-10-17 14:44:18','test',NULL,'大梨','18000000000',0,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg','红米5A','小米','颜色：金色;内存：16G',1,'649.00','591.05','质量问题','颜色太土','',NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `oms_order_return_reason` */

DROP TABLE IF EXISTS `oms_order_return_reason`;

CREATE TABLE `oms_order_return_reason` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '退货类型',
  `sort` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT NULL COMMENT '状态：0->不启用；1->启用',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='退货原因表';

/*Data for the table `oms_order_return_reason` */

insert  into `oms_order_return_reason`(`id`,`name`,`sort`,`status`,`create_time`) values (1,'质量问题',1,1,'2018-10-17 10:00:45'),(2,'尺码太大',1,1,'2018-10-17 10:01:03'),(3,'颜色不喜欢',1,1,'2018-10-17 10:01:13'),(4,'7天无理由退货',1,1,'2018-10-17 10:01:47'),(5,'价格问题',1,0,'2018-10-17 10:01:57'),(12,'发票问题',0,1,'2018-10-19 16:28:36'),(13,'其他问题',0,1,'2018-10-19 16:28:51'),(14,'物流问题',0,1,'2018-10-19 16:29:01'),(15,'售后问题',0,1,'2018-10-19 16:29:11');

/*Table structure for table `oms_order_setting` */

DROP TABLE IF EXISTS `oms_order_setting`;

CREATE TABLE `oms_order_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flash_order_overtime` int(11) DEFAULT NULL COMMENT '秒杀订单超时关闭时间(分)',
  `normal_order_overtime` int(11) DEFAULT NULL COMMENT '正常订单超时时间(分)',
  `confirm_overtime` int(11) DEFAULT NULL COMMENT '发货后自动确认收货时间（天）',
  `finish_overtime` int(11) DEFAULT NULL COMMENT '自动完成交易时间，不能申请售后（天）',
  `comment_overtime` int(11) DEFAULT NULL COMMENT '订单完成后自动好评时间（天）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单设置表';

/*Data for the table `oms_order_setting` */

insert  into `oms_order_setting`(`id`,`flash_order_overtime`,`normal_order_overtime`,`confirm_overtime`,`finish_overtime`,`comment_overtime`) values (1,60,120,30,7,7);

/*Table structure for table `pms_album` */

DROP TABLE IF EXISTS `pms_album`;

CREATE TABLE `pms_album` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `cover_pic` varchar(1000) DEFAULT NULL,
  `pic_count` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='相册表';

/*Data for the table `pms_album` */

/*Table structure for table `pms_album_pic` */

DROP TABLE IF EXISTS `pms_album_pic`;

CREATE TABLE `pms_album_pic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) DEFAULT NULL,
  `pic` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='画册图片表';

/*Data for the table `pms_album_pic` */

/*Table structure for table `pms_brand` */

DROP TABLE IF EXISTS `pms_brand`;

CREATE TABLE `pms_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `first_letter` varchar(8) DEFAULT NULL COMMENT '首字母',
  `sort` int(11) DEFAULT NULL,
  `factory_status` int(1) DEFAULT NULL COMMENT '是否为品牌制造商：0->不是；1->是',
  `show_status` int(1) DEFAULT NULL,
  `product_count` int(11) DEFAULT NULL COMMENT '产品数量',
  `product_comment_count` int(11) DEFAULT NULL COMMENT '产品评论数量',
  `logo` varchar(255) DEFAULT NULL COMMENT '品牌logo',
  `big_pic` varchar(255) DEFAULT NULL COMMENT '专区大图',
  `brand_story` text COMMENT '品牌故事',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='品牌表';

/*Data for the table `pms_brand` */

insert  into `pms_brand`(`id`,`name`,`first_letter`,`sort`,`factory_status`,`show_status`,`product_count`,`product_comment_count`,`logo`,`big_pic`,`brand_story`) values (1,'万和','W',0,1,1,100,100,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5b07ca8aN4e127d2f.jpg','http://img13.360buyimg.com/cms/jfs/t1/121860/35/2430/187800/5ec4e294E22f3ffcc/1e233b65b94ba192.jpg','万和成立于1993年8月，总部位于广东顺德国家级高新技术开发区内，是国内生产规模最大的燃气具专业制造企业，也是中国燃气具发展战略的首倡者和推动者、中国五金制品协会燃气用具分会第三届理事长单位。'),(2,'三星','S',100,1,1,100,100,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/57201b47N7bf15715.jpg','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/sanxing_banner_01.png','三星集团（英文：SAMSUNG、韩文：삼성）是韩国最大的跨国企业集团，三星集团包括众多的国际下属企业，旗下子公司有：三星电子、三星物产、三星人寿保险等，业务涉及电子、金融、机械、化学等众多领域。'),(3,'华为','H',100,1,1,100,100,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5abf6f26N31658aa2.jpg','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/huawei_banner_01.png','荣耀品牌成立于2013年,是华为旗下手机双品牌之一。荣耀以“创新、品质、服务”为核心战略,为全球年轻人提供潮酷的全场景智能化体验,打造年轻人向往的先锋文化和潮流生活方式'),(4,'格力','G',30,1,1,100,100,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (3).jpg',NULL,'Victoria\'s Secret的故事'),(5,'方太','F',20,1,1,100,100,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (4).jpg',NULL,'Victoria\'s Secret的故事'),(6,'小米','M',500,1,1,100,100,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5565f5a2N0b8169ae.jpg','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/xiaomi_banner_01.png','小米公司正式成立于2010年4月，是一家专注于高端智能手机、互联网电视自主研发的创新型科技企业。主要由前谷歌、微软、摩托、金山等知名公司的顶尖人才组建。'),(21,'OPPO','O',0,1,1,88,500,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(6).jpg','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/oppo_banner_01.png','OPPO于2008年推出第一款“笑脸手机”，由此开启探索和引领至美科技之旅。今天，OPPO凭借以Find和R系列手机为核心的智能终端产品，以及OPPO+等互联网服务，让全球消费者尽享至美科技。'),(49,'七匹狼','S',200,1,1,77,400,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190525/qipilang.png',NULL,'BOOB的故事'),(50,'海澜之家','H',200,1,1,66,300,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a5c69b9N5d6c5696.jpg','http://img10.360buyimg.com/cms/jfs/t1/133148/4/1605/470028/5edaf5ccEd7a687a9/e0a007631361ff75.jpg','“海澜之家”（英文缩写：HLA）是海澜之家股份有限公司旗下的服装品牌，总部位于中国江苏省无锡市江阴市，主要采用连锁零售的模式，销售男性服装、配饰与相关产品。'),(51,'苹果','A',200,1,1,55,200,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/49b30bb0377030d1.jpg','http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/apple_banner_01.png','苹果公司(Apple Inc. )是美国的一家高科技公司。 由史蒂夫·乔布斯、斯蒂夫·沃兹尼亚克和罗·韦恩(Ron Wayne)等人于1976年4月1日创立,并命名为美国苹果电脑公司(Apple Computer Inc. ),2007年1月9日更名为苹果公司,总部位于加利福尼亚州的...'),(58,'NIKE','N',0,1,0,33,100,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/timg (51).jpg','','NIKE的故事'),(59,'测试品牌','C',0,0,0,NULL,NULL,'http://localhost:9000/mall/20220609/Snipaste_2022-06-08_14-35-53.png','http://localhost:9000/mall/20220609/biji_05.jpg','12345');

/*Table structure for table `pms_comment` */

DROP TABLE IF EXISTS `pms_comment`;

CREATE TABLE `pms_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `member_nick_name` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `star` int(3) DEFAULT NULL COMMENT '评价星数：0->5',
  `member_ip` varchar(64) DEFAULT NULL COMMENT '评价的ip',
  `create_time` datetime DEFAULT NULL,
  `show_status` int(1) DEFAULT NULL,
  `product_attribute` varchar(255) DEFAULT NULL COMMENT '购买时的商品属性',
  `collect_couont` int(11) DEFAULT NULL,
  `read_count` int(11) DEFAULT NULL,
  `content` text,
  `pics` varchar(1000) DEFAULT NULL COMMENT '上传图片地址，以逗号隔开',
  `member_icon` varchar(255) DEFAULT NULL COMMENT '评论用户头像',
  `replay_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品评价表';

/*Data for the table `pms_comment` */

/*Table structure for table `pms_comment_replay` */

DROP TABLE IF EXISTS `pms_comment_replay`;

CREATE TABLE `pms_comment_replay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) DEFAULT NULL,
  `member_nick_name` varchar(255) DEFAULT NULL,
  `member_icon` varchar(255) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `type` int(1) DEFAULT NULL COMMENT '评论人员类型；0->会员；1->管理员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='产品评价回复表';

/*Data for the table `pms_comment_replay` */

/*Table structure for table `pms_feight_template` */

DROP TABLE IF EXISTS `pms_feight_template`;

CREATE TABLE `pms_feight_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `charge_type` int(1) DEFAULT NULL COMMENT '计费类型:0->按重量；1->按件数',
  `first_weight` decimal(10,2) DEFAULT NULL COMMENT '首重kg',
  `first_fee` decimal(10,2) DEFAULT NULL COMMENT '首费（元）',
  `continue_weight` decimal(10,2) DEFAULT NULL,
  `continme_fee` decimal(10,2) DEFAULT NULL,
  `dest` varchar(255) DEFAULT NULL COMMENT '目的地（省、市）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='运费模版';

/*Data for the table `pms_feight_template` */

/*Table structure for table `pms_member_price` */

DROP TABLE IF EXISTS `pms_member_price`;

CREATE TABLE `pms_member_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `member_level_id` bigint(20) DEFAULT NULL,
  `member_price` decimal(10,2) DEFAULT NULL COMMENT '会员价格',
  `member_level_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=591 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品会员价格表';

/*Data for the table `pms_member_price` */

insert  into `pms_member_price`(`id`,`product_id`,`member_level_id`,`member_price`,`member_level_name`) values (26,7,1,'500.00',NULL),(27,8,1,'500.00',NULL),(28,9,1,'500.00',NULL),(29,10,1,'500.00',NULL),(30,11,1,'500.00',NULL),(31,12,1,'500.00',NULL),(32,13,1,'500.00',NULL),(33,14,1,'500.00',NULL),(37,18,1,'500.00',NULL),(44,7,2,'480.00',NULL),(45,7,3,'450.00',NULL),(52,22,1,NULL,NULL),(53,22,2,NULL,NULL),(54,22,3,NULL,NULL),(58,24,1,NULL,NULL),(59,24,2,NULL,NULL),(60,24,3,NULL,NULL),(112,23,1,'88.00','黄金会员'),(113,23,2,'88.00','白金会员'),(114,23,3,'66.00','钻石会员'),(390,42,1,NULL,'黄金会员'),(391,42,2,NULL,'白金会员'),(392,42,3,NULL,'钻石会员'),(396,44,1,NULL,'黄金会员'),(397,44,2,NULL,'白金会员'),(398,44,3,NULL,'钻石会员'),(453,43,1,NULL,'黄金会员'),(454,43,2,NULL,'白金会员'),(455,43,3,NULL,'钻石会员'),(498,28,1,NULL,'黄金会员'),(499,28,2,NULL,'白金会员'),(500,28,3,NULL,'钻石会员'),(501,29,1,NULL,'黄金会员'),(502,29,2,NULL,'白金会员'),(503,29,3,NULL,'钻石会员'),(507,31,1,NULL,'黄金会员'),(508,31,2,NULL,'白金会员'),(509,31,3,NULL,'钻石会员'),(510,32,1,NULL,'黄金会员'),(511,32,2,NULL,'白金会员'),(512,32,3,NULL,'钻石会员'),(513,33,1,NULL,'黄金会员'),(514,33,2,NULL,'白金会员'),(515,33,3,NULL,'钻石会员'),(516,34,1,NULL,'黄金会员'),(517,34,2,NULL,'白金会员'),(518,34,3,NULL,'钻石会员'),(519,35,1,NULL,'黄金会员'),(520,35,2,NULL,'白金会员'),(521,35,3,NULL,'钻石会员'),(522,36,1,NULL,'黄金会员'),(523,36,2,NULL,'白金会员'),(524,36,3,NULL,'钻石会员'),(525,37,1,NULL,'黄金会员'),(526,37,2,NULL,'白金会员'),(527,37,3,NULL,'钻石会员'),(528,38,1,NULL,'黄金会员'),(529,38,2,NULL,'白金会员'),(530,38,3,NULL,'钻石会员'),(531,39,1,NULL,'黄金会员'),(532,39,2,NULL,'白金会员'),(533,39,3,NULL,'钻石会员'),(534,40,1,NULL,'黄金会员'),(535,40,2,NULL,'白金会员'),(536,40,3,NULL,'钻石会员'),(537,45,1,NULL,'黄金会员'),(538,45,2,NULL,'白金会员'),(539,45,3,NULL,'钻石会员'),(549,30,1,NULL,'黄金会员'),(550,30,2,NULL,'白金会员'),(551,30,3,NULL,'钻石会员'),(564,27,1,NULL,'黄金会员'),(565,27,2,NULL,'白金会员'),(566,27,3,NULL,'钻石会员'),(570,41,1,NULL,'黄金会员'),(571,41,2,NULL,'白金会员'),(572,41,3,NULL,'钻石会员'),(585,26,1,NULL,'黄金会员'),(586,26,2,NULL,'白金会员'),(587,26,3,NULL,'钻石会员'),(588,46,1,NULL,'黄金会员'),(589,46,2,NULL,'白金会员'),(590,46,3,NULL,'钻石会员');

/*Table structure for table `pms_product` */

DROP TABLE IF EXISTS `pms_product`;

CREATE TABLE `pms_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `brand_id` bigint(20) DEFAULT NULL,
  `product_category_id` bigint(20) DEFAULT NULL,
  `feight_template_id` bigint(20) DEFAULT NULL,
  `product_attribute_category_id` bigint(20) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `product_sn` varchar(64) NOT NULL COMMENT '货号',
  `delete_status` int(1) DEFAULT NULL COMMENT '删除状态：0->未删除；1->已删除',
  `publish_status` int(1) DEFAULT NULL COMMENT '上架状态：0->下架；1->上架',
  `new_status` int(1) DEFAULT NULL COMMENT '新品状态:0->不是新品；1->新品',
  `recommand_status` int(1) DEFAULT NULL COMMENT '推荐状态；0->不推荐；1->推荐',
  `verify_status` int(1) DEFAULT NULL COMMENT '审核状态：0->未审核；1->审核通过',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `sale` int(11) DEFAULT NULL COMMENT '销量',
  `price` decimal(10,2) DEFAULT NULL,
  `promotion_price` decimal(10,2) DEFAULT NULL COMMENT '促销价格',
  `gift_growth` int(11) DEFAULT '0' COMMENT '赠送的成长值',
  `gift_point` int(11) DEFAULT '0' COMMENT '赠送的积分',
  `use_point_limit` int(11) DEFAULT NULL COMMENT '限制使用的积分数',
  `sub_title` varchar(255) DEFAULT NULL COMMENT '副标题',
  `description` text COMMENT '商品描述',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '市场价',
  `stock` int(11) DEFAULT NULL COMMENT '库存',
  `low_stock` int(11) DEFAULT NULL COMMENT '库存预警值',
  `unit` varchar(16) DEFAULT NULL COMMENT '单位',
  `weight` decimal(10,2) DEFAULT NULL COMMENT '商品重量，默认为克',
  `preview_status` int(1) DEFAULT NULL COMMENT '是否为预告商品：0->不是；1->是',
  `service_ids` varchar(64) DEFAULT NULL COMMENT '以逗号分割的产品服务：1->无忧退货；2->快速退款；3->免费包邮',
  `keywords` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `album_pics` varchar(255) DEFAULT NULL COMMENT '画册图片，连产品图片限制为5张，以逗号分割',
  `detail_title` varchar(255) DEFAULT NULL,
  `detail_desc` text,
  `detail_html` text COMMENT '产品详情网页内容',
  `detail_mobile_html` text COMMENT '移动端网页详情',
  `promotion_start_time` datetime DEFAULT NULL COMMENT '促销开始时间',
  `promotion_end_time` datetime DEFAULT NULL COMMENT '促销结束时间',
  `promotion_per_limit` int(11) DEFAULT NULL COMMENT '活动限购数量',
  `promotion_type` int(1) DEFAULT NULL COMMENT '促销类型：0->没有促销使用原价;1->使用促销价；2->使用会员价；3->使用阶梯价格；4->使用满减价格；5->限时购',
  `brand_name` varchar(255) DEFAULT NULL COMMENT '品牌名称',
  `product_category_name` varchar(255) DEFAULT NULL COMMENT '商品分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品信息';

/*Data for the table `pms_product` */

insert  into `pms_product`(`id`,`brand_id`,`product_category_id`,`feight_template_id`,`product_attribute_category_id`,`name`,`pic`,`product_sn`,`delete_status`,`publish_status`,`new_status`,`recommand_status`,`verify_status`,`sort`,`sale`,`price`,`promotion_price`,`gift_growth`,`gift_point`,`use_point_limit`,`sub_title`,`description`,`original_price`,`stock`,`low_stock`,`unit`,`weight`,`preview_status`,`service_ids`,`keywords`,`note`,`album_pics`,`detail_title`,`detail_desc`,`detail_html`,`detail_mobile_html`,`promotion_start_time`,`promotion_end_time`,`promotion_per_limit`,`promotion_type`,`brand_name`,`product_category_name`) values (1,49,1,0,0,'银色星芒刺绣网纱底裤','http://localhost:9000/mall/20241112/p-17.jpg','No86577',1,1,1,1,1,100,0,'888.00',NULL,0,100,NULL,'111','111','999.00',100,20,'件','1000.00',0,NULL,'银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤',NULL,NULL,NULL,0,'七匹狼','外套'),(2,49,1,0,0,'银色星芒刺绣网纱底裤2','http://localhost:9000/mall/20241112/p-02.jpg','No86578',1,1,1,1,1,1,0,'888.00',NULL,0,100,NULL,'111','111','999.00',100,20,'件','1000.00',0,NULL,'银色星芒刺绣网纱底裤2','银色星芒刺绣网纱底裤','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','<p>银色星芒刺绣网纱底裤</p>','<p>银色星芒刺绣网纱底裤</p>',NULL,NULL,NULL,0,'七匹狼','外套'),(3,1,1,0,0,'银色星芒刺绣网纱底裤3','http://localhost:9000/mall/20241112/p-03.jpg','No86579',1,1,1,1,1,1,0,'888.00',NULL,0,100,NULL,'111','111','999.00',100,20,'件','1000.00',0,NULL,'银色星芒刺绣网纱底裤3','银色星芒刺绣网纱底裤','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤',NULL,NULL,NULL,0,'万和','外套'),(4,1,1,0,0,'银色星芒刺绣网纱底裤4','http://localhost:9000/mall/20241112/p-04.jpg','No86580',1,1,1,1,1,1,0,'888.00',NULL,0,100,NULL,'111','111','999.00',100,20,'件','1000.00',0,NULL,'银色星芒刺绣网纱底裤4','银色星芒刺绣网纱底裤','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤',NULL,NULL,NULL,0,'万和','外套'),(5,1,2,0,0,'银色星芒刺绣网纱底裤5','http://localhost:9000/mall/20241112/p-17.jpg','No86581',1,1,1,1,1,1,0,'888.00',NULL,0,100,NULL,'111','111','999.00',100,20,'件','1000.00',0,NULL,'银色星芒刺绣网纱底裤5','银色星芒刺绣网纱底裤','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤',NULL,NULL,NULL,0,'万和','外套'),(6,1,2,0,0,'银色星芒刺绣网纱底裤6','http://localhost:9000/mall/20241112/p-04.jpg','No86582',1,1,1,1,1,1,0,'888.00',NULL,0,100,NULL,'111','111','999.00',100,20,'件','1000.00',0,NULL,'银色星芒刺绣网纱底裤6','银色星芒刺绣网纱底裤','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤','银色星芒刺绣网纱底裤',NULL,NULL,NULL,0,'万和','外套'),(7,1,2,0,1,'女式超柔软拉毛运动开衫','http://localhost:9000/mall/20241112/p-07.jpg','No86577',1,1,0,0,0,0,0,'888.00','0.00',0,100,0,'匠心剪裁，垂感质地','匠心剪裁，垂感质地','999.00',100,0,'件','0.00',0,'string','女式超柔软拉毛运动开衫','string','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','string','string','string','string','2018-04-26 10:41:03','2018-04-26 10:41:03',0,0,'万和','外套'),(8,1,2,0,1,'女式超柔软拉毛运动开衫1','http://localhost:9000/mall/20241112/p-09.jpg','No86577',1,1,0,0,0,0,0,'888.00','0.00',0,100,0,'匠心剪裁，垂感质地','匠心剪裁，垂感质地','999.00',100,0,'件','0.00',0,'string','女式超柔软拉毛运动开衫','string','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','string','string','string','string','2018-04-26 10:41:03','2018-04-26 10:41:03',0,0,'万和','外套'),(9,1,2,0,1,'Stylish Grey T-Shirt','http://localhost:9000/mall/20241112/p-17.jpg','No86577',1,1,0,0,0,0,0,'888.00','0.00',0,100,0,'匠心剪裁，垂感质地','匠心剪裁，垂感质地','999.00',100,0,'件','0.00',0,'string','女式超柔软拉毛运动开衫','string','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','string','string','string','string','2018-04-26 10:41:03','2018-04-26 10:41:03',0,0,'万和','外套'),(10,1,2,0,1,'Stylish Grey T-Shirt','http://localhost:9000/mall/20241112/p-17.jpg','No86577',1,1,0,1,0,0,0,'888.00','0.00',0,100,0,'匠心剪裁，垂感质地','匠心剪裁，垂感质地','999.00',100,0,'件','0.00',0,'string','女式超柔软拉毛运动开衫','string','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','string','string','string','string','2018-04-26 10:41:03','2018-04-26 10:41:03',0,0,'万和','外套'),(11,1,2,0,1,'Stylish Grey T-Shirt','http://localhost:9000/mall/20241112/p-17.jpg','No86577',1,1,0,1,0,0,0,'888.00','0.00',0,100,0,'匠心剪裁，垂感质地','匠心剪裁，垂感质地','999.00',100,0,'件','0.00',0,'string','女式超柔软拉毛运动开衫','string','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','string','string','string','string','2018-04-26 10:41:03','2018-04-26 10:41:03',0,0,'万和','外套'),(12,1,7,0,1,'Stylish Grey T-Shirt','http://localhost:9000/mall/20241112/p-17.jpg','No86577',1,1,0,1,0,0,0,'888.00','0.00',0,100,0,'匠心剪裁，垂感质地','匠心剪裁，垂感质地','999.00',100,0,'件','0.00',0,'string','女式超柔软拉毛运动开衫','string','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','string','string','string','string','2018-04-26 10:41:03','2018-04-26 10:41:03',0,0,'万和','外套'),(13,1,7,0,1,'Stylish Grey T-Shirt','http://localhost:9000/mall/20241112/p-17.jpg','No86577',1,1,0,1,0,0,0,'888.00','0.00',0,100,0,'匠心剪裁，垂感质地','匠心剪裁，垂感质地','999.00',100,0,'件','0.00',0,'string','女式超柔软拉毛运动开衫','string','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','string','string','string','string','2018-04-26 10:41:03','2018-04-26 10:41:03',0,0,'万和','外套'),(14,1,7,0,1,'Stylish Grey T-Shirt','http://localhost:9000/mall/20241112/p-17.jpg','No86577',1,1,0,1,0,0,0,'888.00','0.00',0,100,0,'匠心剪裁，垂感质地','匠心剪裁，垂感质地','999.00',100,0,'件','0.00',0,'string','女式超柔软拉毛运动开衫','string','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','string','string','string','string','2018-04-26 10:41:03','2018-04-26 10:41:03',0,0,'万和','外套'),(18,1,7,0,1,'Stylish Grey T-Shirt','http://localhost:9000/mall/20241112/p-18.jpg','No86577',1,1,0,1,0,0,0,'888.00','0.00',0,100,0,'匠心剪裁，垂感质地','匠心剪裁，垂感质地','999.00',100,0,'件','0.00',0,'string','女式超柔软拉毛运动开衫','string','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','string','string','string','string','2018-04-26 10:41:03','2018-04-26 10:41:03',0,0,'万和','外套'),(22,6,7,0,1,'test','http://localhost:9000/mall/20241112/p-19.jpg','',1,1,0,0,0,0,0,'888.00',NULL,0,0,0,'test','There are many variations of passages of Lorem Ipsum available,but the majority have suffered alteration in some form,','999.00',100,0,'','0.00',1,'1,2','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','There are many variations of passages of Lorem      Ipsum available,but the majority have suffered alteration in some form,','There are many variations of passages of Lorem      Ipsum available,but the majority have suffered alteration in some form,','','',NULL,NULL,0,0,'小米','外套'),(23,6,19,0,1,'毛衫测试','http://localhost:9000/mall/20241112/p-21.jpg','NO.1098',1,1,1,1,0,0,0,'888.00',NULL,99,99,1000,'毛衫测试11','xxx','999.00',100,0,'件','1000.00',1,'1,2,3','毛衫测试','毛衫测试','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','毛衫测试','毛衫测试','<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/155x54.bmp\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/APP登录bg1080.jpg\" width=\"500\" height=\"500\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/APP登录界面.jpg\" width=\"500\" height=\"500\" /></p>','',NULL,NULL,0,2,'小米','手机数码'),(24,6,7,0,NULL,'xxx','http://localhost:9000/mall/20241112/p-08.jpg','',1,1,0,0,0,0,0,'888.00',NULL,0,0,0,'xxx','','999.00',100,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','',NULL,NULL,0,0,'小米','外套'),(26,3,19,0,16,'Double Yellow Shirt','http://localhost:9000/mall/20241112/p-23.jpg','6946605',0,1,1,1,0,100,100,'888.00','3659.00',3788,3788,0,'Double Yellow Shirt','Tristique ullamcorper nunc egestas non. Justo, cum feugiat imperdiet nulla\n                        molestie ac vulputate\n                        scelerisque amet. Bibendum adipiscing platea blandit sit sed quam semper rhoncus. Diam ultrices\n                        maecenas\n                        consequat eu tortor. Orci, cras lectus mauris, cras egestas quam venenatis neque.','999.00',1000,0,'件','0.00',1,'2,3,1','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','There are many variations of passages of Lorem Ipsum available,but the majority have suffered alteration in some form,','<div>\n<pre>There are many variations of passages of Lorem Ipsum available,but the majority have suffered alteration in some form,</pre>\n</div>','<p>&nbsp;</p>\n<p>&nbsp;</p>','2023-01-10 15:49:38','2023-01-31 00:00:00',0,1,'华为','手机通讯'),(27,6,19,0,3,'Long Belly Grey Pant','http://localhost:9000/mall/20241112/p-08.jpg','7437788',0,1,1,1,0,0,99,'888.00',NULL,2699,2699,0,'Long Belly Grey Pant','小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待','999.00',100,0,'','0.00',0,'1','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','<p style=\"text-align: center;\"><img src=\"//img30.360buyimg.com/popWareDetail/jfs/t1/95935/9/19330/159477/5e9ecc13E5b8db8ae/8e954021a0835fb7.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWareDetail/jfs/t1/99224/22/19596/137593/5e9ecc13E34ef2113/2b362b90d8378ee1.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWareDetail/jfs/t1/93131/25/19321/107691/5e9ecc13E41e8addf/202a5f84d9129878.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWareDetail/jfs/t1/101843/19/19533/66831/5e9ecc13Ecb7f9d53/4fdd807266583c1e.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWareDetail/jfs/t1/99629/36/19016/59882/5e9ecc13E1f5beef5/1e5af3528f366e70.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/72343/29/8945/84548/5d6e5c67Ea07b1125/702791816b90eb3d.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/65403/35/9017/129532/5d6e5c68E3f2d0546/9ec771eb6e04a75a.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/58261/33/9380/106603/5d6e5c68E05a99177/2b5b9e29eed05b08.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/51968/40/9688/113552/5d6e5c68E5052b312/8969d83124cb78a4.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/75491/9/9101/146883/5d6e5c68E3db89775/c1aa57e78ded4e44.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/75063/11/9107/127874/5d6e5c68E0b1dfc61/10dd6000ce213375.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/47452/25/9579/108279/5d6e5c68Ea9002f3b/865b5d32ffd9da75.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/82146/26/9077/87075/5d6e5c68Ef63bccc8/556de5665a35a3f2.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/82804/21/9019/124404/5d6e5c69E06a8f575/0f861f8c4636c546.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/46044/10/9734/107686/5d6e5c69Edd5e66c7/a8c7b9324e271dbd.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/40729/32/13755/45997/5d6e5c69Eafee3664/6a3457a4efdb79c5.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/76254/34/9039/96195/5d6e5c69E3c71c809/49033c0b7024c208.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/79825/20/9065/90864/5d6e5c69E1e62ef89/a4d3ce383425a666.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/49939/21/9618/106207/5d6e5c6aEf7b1d4fd/0f5e963c66be3d0c.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/64035/7/9001/115159/5d6e5c6aE6919dfdf/39dfe4840157ad81.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/53389/3/9616/99637/5d6e5c6aEa33b9f35/b8f6aa26e72616a3.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/63219/6/9026/81576/5d6e5c6aEa9c74b49/b4fa364437531012.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/42146/27/13902/80437/5d6e5c6bE30c31ce9/475d4d54c7334313.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/45317/28/9596/78175/5d6e5c6bEce31e4b7/5675858b6933565c.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/60080/1/9112/138722/5d6e5c6bEefd9fc62/7ece7460a36d2fcc.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/51525/13/9549/36018/5d6e5c73Ebbccae6c/99bc2770dccc042b.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/61948/20/9088/72918/5d6e5c73Eab7aef5c/6f21e2f85cf478fa.jpg!q70.dpg.webp\" /></p>','<p style=\"text-align: center;\"><img src=\"//img30.360buyimg.com/popWareDetail/jfs/t1/95935/9/19330/159477/5e9ecc13E5b8db8ae/8e954021a0835fb7.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWareDetail/jfs/t1/99224/22/19596/137593/5e9ecc13E34ef2113/2b362b90d8378ee1.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWareDetail/jfs/t1/93131/25/19321/107691/5e9ecc13E41e8addf/202a5f84d9129878.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWareDetail/jfs/t1/101843/19/19533/66831/5e9ecc13Ecb7f9d53/4fdd807266583c1e.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWareDetail/jfs/t1/99629/36/19016/59882/5e9ecc13E1f5beef5/1e5af3528f366e70.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/72343/29/8945/84548/5d6e5c67Ea07b1125/702791816b90eb3d.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/65403/35/9017/129532/5d6e5c68E3f2d0546/9ec771eb6e04a75a.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/58261/33/9380/106603/5d6e5c68E05a99177/2b5b9e29eed05b08.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/51968/40/9688/113552/5d6e5c68E5052b312/8969d83124cb78a4.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/75491/9/9101/146883/5d6e5c68E3db89775/c1aa57e78ded4e44.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/75063/11/9107/127874/5d6e5c68E0b1dfc61/10dd6000ce213375.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/47452/25/9579/108279/5d6e5c68Ea9002f3b/865b5d32ffd9da75.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/82146/26/9077/87075/5d6e5c68Ef63bccc8/556de5665a35a3f2.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/82804/21/9019/124404/5d6e5c69E06a8f575/0f861f8c4636c546.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/46044/10/9734/107686/5d6e5c69Edd5e66c7/a8c7b9324e271dbd.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/40729/32/13755/45997/5d6e5c69Eafee3664/6a3457a4efdb79c5.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/76254/34/9039/96195/5d6e5c69E3c71c809/49033c0b7024c208.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/79825/20/9065/90864/5d6e5c69E1e62ef89/a4d3ce383425a666.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/49939/21/9618/106207/5d6e5c6aEf7b1d4fd/0f5e963c66be3d0c.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/64035/7/9001/115159/5d6e5c6aE6919dfdf/39dfe4840157ad81.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/53389/3/9616/99637/5d6e5c6aEa33b9f35/b8f6aa26e72616a3.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/63219/6/9026/81576/5d6e5c6aEa9c74b49/b4fa364437531012.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/42146/27/13902/80437/5d6e5c6bE30c31ce9/475d4d54c7334313.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/45317/28/9596/78175/5d6e5c6bEce31e4b7/5675858b6933565c.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/60080/1/9112/138722/5d6e5c6bEefd9fc62/7ece7460a36d2fcc.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/51525/13/9549/36018/5d6e5c73Ebbccae6c/99bc2770dccc042b.jpg!q70.dpg.webp\" /><img src=\"//img30.360buyimg.com/popWaterMark/jfs/t1/61948/20/9088/72918/5d6e5c73Eab7aef5c/6f21e2f85cf478fa.jpg!q70.dpg.webp\" /></p>',NULL,NULL,0,3,'小米','手机通讯'),(28,6,19,0,3,'Half Sleeve T-Shirt','http://localhost:9000/mall/20241112/p-25.jpg','7437789',0,1,1,1,0,0,98,'888.00',NULL,649,649,0,'Half Sleeve T-Shirt','','999.00',100,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<div><img src=\"//img12.360buyimg.com/imgzone/jfs/t1/67362/12/14546/708984/5dc28512Eefdd817d/c82503af0da6c038.gif\" /><img src=\"//img13.360buyimg.com/imgzone/jfs/t1/61488/17/14551/995918/5dc28512E821c228d/41e52005ea5b1f36.gif\" /><img src=\"//img14.360buyimg.com/imgzone/jfs/t1/72961/36/14769/305883/5dc28512E65d77261/3df6be29e3d489d1.gif\" />\n<p>&nbsp;</p>\n</div>',NULL,NULL,0,4,'小米','手机通讯'),(29,51,19,0,3,'Stylish Grey T-Shirt','http://localhost:9000/mall/20241112/p-15.jpg','7437799',0,1,1,1,0,0,97,'888.00','4799.00',5499,5499,0,'【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。','','999.00',100,0,'','0.00',0,'1,2,3','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<div><img src=\"//img10.360buyimg.com/cms/jfs/t1/20020/38/9725/228440/5c7f9208Eeaf4bf87/13a713066f71791d.jpg!q70.dpg.webp\" /> <img src=\"//img12.360buyimg.com/cms/jfs/t1/12128/39/9607/265349/5c7f9209Ecff29b88/08620ba570705634.jpg!q70.dpg.webp\" /> <img src=\"//img14.360buyimg.com/cms/jfs/t1/22731/40/9578/345163/5c7f9209E9ba056e5/a8a557060b84447e.jpg!q70.dpg.webp\" /> <img src=\"//img14.360buyimg.com/cms/jfs/t1/29506/38/9439/299492/5c7f9209E0e51eb29/15dedd95416f3c68.jpg!q70.dpg.webp\" /> <img src=\"//img14.360buyimg.com/cms/jfs/t1/26766/28/9574/257101/5c7f9209Eaca1b317/c7caa047b1566cf1.jpg!q70.dpg.webp\" /> <img src=\"//img13.360buyimg.com/cms/jfs/t1/11059/8/10473/286531/5c7f9208E05da0120/9034ad8799ad9553.jpg!q70.dpg.webp\" /> <img src=\"//img14.360buyimg.com/cms/jfs/t1/25641/2/9557/268826/5c7f9208Efbf0dc50/399580629e05e733.jpg!q70.dpg.webp\" /> <img src=\"//img13.360buyimg.com/cms/jfs/t1/28964/25/9527/305902/5c7f9208E275ffb9c/8464934d67e69b7a.jpg!q70.dpg.webp\" /></div>','2020-05-04 15:12:54','2020-05-30 00:00:00',0,1,'苹果','手机通讯'),(30,50,8,0,1,'Stylish Grey T-Shirt23','http://localhost:9000/mall/20241112/p-03.jpg','HNTBJ2E042A',0,1,1,1,0,0,0,'888.00',NULL,0,0,0,'2018夏季新品微弹舒适新款短T男生 6月6日-6月20日，满300减30，参与互动赢百元礼券，立即分享赢大奖','','999.00',100,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','',NULL,NULL,0,0,'海澜之家','T恤'),(31,50,8,0,1,'Stylish Grey T-Shirt34','http://localhost:9000/mall/20241112/p-03.jpg','HNTBJ2E080A',0,1,0,0,0,0,0,'888.00',NULL,0,0,0,'Stylish Grey T-Shirt345','','999.00',100,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','',NULL,NULL,0,0,'海澜之家','T恤'),(32,50,8,0,1,'Stylish Grey T-Shirter','http://localhost:9000/mall/20241112/p-31.jpg','HNTBJ2E153A',0,1,0,0,0,0,0,'888.00',NULL,0,0,0,'Stylish Grey T-Shirtdf','','999.00',100,0,'','0.00',0,'1,2','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','',NULL,NULL,0,0,'海澜之家','T恤'),(33,6,35,0,12,'Stylish Grey T-Shirtee','http://localhost:9000/mall/20241112/p-29.jpg','4609652',0,1,0,0,0,0,0,'888.00',NULL,0,0,0,'Stylish Grey T-Shirtee','','999.00',100,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','',NULL,NULL,0,0,'小米','电视'),(34,6,35,0,12,'Stylish Grey T-Shirt45','http://localhost:9000/mall/20241112/p-39.jpg','4609660',0,1,0,0,0,0,0,'888.00',NULL,0,0,0,'Stylish Grey T-Shirt45','','999.00',100,0,'','0.00',0,'1,2','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','',NULL,NULL,0,0,'小米','电视'),(35,58,29,0,11,'Stylish Grey T-Shirtee','http://localhost:9000/mall/20241112/p-36.jpg','6799342',0,1,0,0,0,0,0,'888.00',NULL,0,0,0,'耐克NIKE 男子 休闲鞋 ROSHE RUN 运动鞋 511881-010黑色41码','','999.00',100,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','',NULL,NULL,0,0,'NIKE','男鞋'),(36,58,29,0,11,'Stylish Grey T-Shirtee2','http://localhost:9000/mall/20241112/p-03.jpg','6799345',0,1,1,1,0,0,0,'888.00',NULL,0,0,0,'耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码','','999.00',100,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','',NULL,NULL,0,0,'NIKE','男鞋'),(37,51,19,0,3,'Stylish Grey T-Shirtee56','http://localhost:9000/mall/20241112/p-33.jpg','100038005189',0,1,0,0,0,200,0,'888.00',NULL,0,0,0,'【11.11大爱超大爱】指定iPhone14产品限时限量领券立减601元！！！部分iPhone产品现货抢购确认收货即送原厂手机壳10元优惠券！！！猛戳 ','','999.00',1000,0,'','208.00',0,'1,2,3','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<div style=\"margin: 0 auto;\"><img style=\"max-width: 390px;\" src=\"//img13.360buyimg.com/cms/jfs/t1/58071/39/19839/119559/63190110Edac0cea7/b62a84f1b8775fef.jpg!q70.dpg.webp\" /> <img style=\"max-width: 390px;\" src=\"//img20.360buyimg.com/cms/jfs/t1/138903/36/29400/86115/63190110E0a98c819/d2efbef39eeb2995.jpg!q70.dpg.webp\" /> <img style=\"max-width: 390px;\" src=\"//img30.360buyimg.com/cms/jfs/t1/176347/20/28995/115695/63190110Ef5d766f9/aee3d2d866522f66.jpg!q70.dpg.webp\" /> <img style=\"max-width: 390px;\" src=\"//img14.360buyimg.com/cms/jfs/t1/120515/39/28721/142961/63190110Eec31e31a/3486d6a065a18ddc.jpg!q70.dpg.webp\" /> <img style=\"max-width: 390px;\" src=\"//img13.360buyimg.com/cms/jfs/t1/30161/12/17674/81508/63190110E1385cf61/f05a2a43f4d304ff.jpg!q70.dpg.webp\" /> <img style=\"max-width: 390px;\" src=\"//img14.360buyimg.com/cms/jfs/t1/100037/16/31071/62177/6319010fE871efe01/b01a6f981c268e38.jpg!q70.dpg.webp\" /> <img style=\"max-width: 390px;\" src=\"//img14.360buyimg.com/cms/jfs/t1/90843/33/25852/74752/63190110E373559f4/74b6b52a3fb08c66.jpg!q70.dpg.webp\" /> <img style=\"max-width: 390px;\" src=\"//img14.360buyimg.com/cms/jfs/t1/181914/22/28400/126094/63190110Edefb838c/802a16e758be2b1d.jpg!q70.dpg.webp\" /></div>',NULL,NULL,0,1,'苹果','手机通讯'),(38,51,53,0,3,'Stylish Grey T-Shirtee78','http://localhost:9000/mall/20241112/p-11.jpg','100044025833',0,1,0,0,0,0,0,'888.00',NULL,0,0,0,'【11.11大爱超大爱】iPad9代限量抢购，价格优惠，更享以旧换新至高补贴325元！！快来抢购吧！！ ','','999.00',1000,0,'','0.00',0,'1,2,3','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<div style=\"margin: 0 auto;\"><img style=\"max-width: 390px;\" src=\"//img12.360buyimg.com/cms/jfs/t1/75040/28/21026/295081/634ed154E981e4d10/2ceef91d6f2b2273.jpg!q70.dpg.webp\" /> <img style=\"max-width: 390px;\" src=\"//img13.360buyimg.com/cms/jfs/t1/191028/1/28802/401291/634ed15eEb234dc40/5ab89f83531e1023.jpg!q70.dpg.webp\" /> <img style=\"max-width: 390px;\" src=\"//img14.360buyimg.com/cms/jfs/t1/32758/24/18599/330590/634ed15eEc3db173c/c52953dc8008a576.jpg!q70.dpg.webp\" /></div>',NULL,NULL,0,0,'苹果','平板电脑'),(39,6,54,0,13,'Stylish Grey T-Shirtee56','http://localhost:9000/mall/20241112/p-37.jpg','100023207945',0,1,0,1,0,0,0,'888.00',NULL,0,0,0,'【双十一大促来袭】指定型号至高优惠1000，以旧换新至高补贴1000元，晒单赢好礼','','999.00',500,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<div class=\"ssd-module-mobile-wrap\">\n<div class=\"ssd-module M16667778180631\" data-id=\"M16667778180631\"><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/xiaomi_computer_snipaste_01.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/xiaomi_computer_snipaste_02.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/xiaomi_computer_snipaste_03.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/xiaomi_computer_snipaste_04.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/xiaomi_computer_snipaste_05.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/xiaomi_computer_snipaste_06.png\" /></div>\n<div class=\"ssd-module M16667778180631\" data-id=\"M16667778180631\">&nbsp;</div>\n<div class=\"ssd-module M16534569204241\" data-id=\"M16534569204241\">&nbsp;</div>\n<div class=\"ssd-module M16667778416884\" data-id=\"M16667778416884\">\n<div class=\"ssd-widget-text W16667778440496\">&nbsp;</div>\n</div>\n<div class=\"ssd-module M165303211067557\" data-id=\"M165303211067557\">&nbsp;</div>\n<div class=\"ssd-module M16530320459861\" data-id=\"M16530320459861\">&nbsp;</div>\n<div class=\"ssd-module M16530320460062\" data-id=\"M16530320460062\">&nbsp;</div>\n<div class=\"ssd-module M16530320460153\" data-id=\"M16530320460153\">&nbsp;</div>\n<div class=\"ssd-module M16530320460366\" data-id=\"M16530320460366\">&nbsp;</div>\n<div class=\"ssd-module M16530320460477\" data-id=\"M16530320460477\">&nbsp;</div>\n<div class=\"ssd-module M16530320460578\" data-id=\"M16530320460578\">&nbsp;</div>\n<div class=\"ssd-module M16530320460699\" data-id=\"M16530320460699\">&nbsp;</div>\n<div class=\"ssd-module M165303204608110\" data-id=\"M165303204608110\">&nbsp;</div>\n<div class=\"ssd-module M165303204609511\" data-id=\"M165303204609511\">&nbsp;</div>\n<div class=\"ssd-module M165303204611213\" data-id=\"M165303204611213\">&nbsp;</div>\n<div class=\"ssd-module M165303204612714\" data-id=\"M165303204612714\">&nbsp;</div>\n<div class=\"ssd-module M165303204614115\" data-id=\"M165303204614115\">&nbsp;</div>\n<div class=\"ssd-module M165303204615516\" data-id=\"M165303204615516\">&nbsp;</div>\n<div class=\"ssd-module M165303204617417\" data-id=\"M165303204617417\">&nbsp;</div>\n<div class=\"ssd-module M165303204618818\" data-id=\"M165303204618818\">&nbsp;</div>\n<div class=\"ssd-module M165303204620219\" data-id=\"M165303204620219\">&nbsp;</div>\n<div class=\"ssd-module M165303204621620\" data-id=\"M165303204621620\">&nbsp;</div>\n<div class=\"ssd-module M165303204622921\" data-id=\"M165303204622921\">&nbsp;</div>\n<div class=\"ssd-module M165303204624522\" data-id=\"M165303204624522\">&nbsp;</div>\n<div class=\"ssd-module M165303204626024\" data-id=\"M165303204626024\">&nbsp;</div>\n<div class=\"ssd-module M165303204627525\" data-id=\"M165303204627525\">&nbsp;</div>\n<div class=\"ssd-module M165303204629127\" data-id=\"M165303204629127\">&nbsp;</div>\n<div class=\"ssd-module M165303204632330\" data-id=\"M165303204632330\">&nbsp;</div>\n<div class=\"ssd-module M165303204634031\" data-id=\"M165303204634031\">&nbsp;</div>\n<div class=\"ssd-module M165303204635832\" data-id=\"M165303204635832\">&nbsp;</div>\n<div class=\"ssd-module M165303204637533\" data-id=\"M165303204637533\">&nbsp;</div>\n<div class=\"ssd-module M165303204639334\" data-id=\"M165303204639334\">&nbsp;</div>\n<div class=\"ssd-module M165303204642235\" data-id=\"M165303204642235\">&nbsp;</div>\n<div class=\"ssd-module M165303204647936\" data-id=\"M165303204647936\">&nbsp;</div>\n<div class=\"ssd-module M165303204651037\" data-id=\"M165303204651037\">&nbsp;</div>\n<div class=\"ssd-module M165303204653838\" data-id=\"M165303204653838\">&nbsp;</div>\n<div class=\"ssd-module M165303204656239\" data-id=\"M165303204656239\">&nbsp;</div>\n<div class=\"ssd-module M165303204659141\" data-id=\"M165303204659141\">&nbsp;</div>\n<div class=\"ssd-module M165303204661943\" data-id=\"M165303204661943\">&nbsp;</div>\n<div class=\"ssd-module M165303204665844\" data-id=\"M165303204665844\">&nbsp;</div>\n<div class=\"ssd-module M165303204668045\" data-id=\"M165303204668045\">&nbsp;</div>\n<div class=\"ssd-module M165303204670146\" data-id=\"M165303204670146\">&nbsp;</div>\n<div class=\"ssd-module M165303204672147\" data-id=\"M165303204672147\">&nbsp;</div>\n<div class=\"ssd-module M165303204674348\" data-id=\"M165303204674348\">&nbsp;</div>\n<div class=\"ssd-module M165303204676749\" data-id=\"M165303204676749\">&nbsp;</div>\n<div class=\"ssd-module M165303204681352\" data-id=\"M165303204681352\">&nbsp;</div>\n<div class=\"ssd-module M165303204683553\" data-id=\"M165303204683553\">&nbsp;</div>\n<div class=\"ssd-module M165303204685855\" data-id=\"M165303204685855\">&nbsp;</div>\n<div class=\"ssd-module M165303204688356\" data-id=\"M165303204688356\">&nbsp;</div>\n</div>',NULL,NULL,0,0,'小米','笔记本'),(40,6,19,0,3,'Volunteer Half Blue','http://localhost:9000/mall/20241112/p-24.jpg','100027789721',0,1,1,1,0,0,0,'888.00',NULL,0,0,0,'Volunteer Half Blue','','999.00',500,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_snipaste_01.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_snipaste_02.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_snipaste_03.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_snipaste_04.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/xiaomi_12_pro_snipaste_05.png\" /></p>',NULL,NULL,0,4,'小米','手机通讯'),(41,6,19,0,3,'Stylish Grey T-Shirtee6767','http://localhost:9000/mall/20241112/p-24.jpg','100035246702',0,1,0,0,0,0,0,'888.00',NULL,0,0,0,'【品质好物】天玑8100，2K直屏，5500mAh大电量【Note12Pro火热抢购中】 ','','999.00',1000,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_snipaste_01.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_snipaste_02.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_snipaste_03.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_snipaste_04.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_snipaste_05.png\" /></p>',NULL,NULL,0,0,'小米','手机通讯'),(42,3,19,0,3,'Stylish Grey T-Shirtee45','http://localhost:9000/mall/20241112/p-24.jpg','100035295081',0,1,0,0,0,0,0,'888.00',NULL,0,0,0,'【华为Mate50新品上市】内置66W华为充电套装，超光变XMAGE影像,北斗卫星消息，鸿蒙操作系统3.0！立即抢购！华为新品可持续计划，猛戳》 ','','999.00',1000,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/huawei_mate50_snipaste_01.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/huawei_mate50_snipaste_02.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/huawei_mate50_snipaste_03.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/huawei_mate50_snipaste_04.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/huawei_mate50_snipaste_05.png\" /></p>',NULL,NULL,0,0,'华为','手机通讯'),(43,1,39,0,14,'Stylish Grey T-Shirtee3344','http://localhost:9000/mall/20241112/p-24.jpg','10044060351752',0,1,0,0,0,0,0,'888.00',NULL,0,0,0,'Full Sleeve Cover Shirt','','999.00',1000,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/wanhe_water_snipaste_01.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/wanhe_water_snipaste_02.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/wanhe_water_snipaste_03.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/wanhe_water_snipaste_04.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/wanhe_water_snipaste_05.png\" /></p>',NULL,NULL,0,0,'万和','厨卫大电'),(44,2,55,0,15,'Stylish Grey T-Shirtee3344','http://localhost:9000/mall/20241112/p-24.jpg','100018768480',0,1,0,0,0,0,0,'888.00',NULL,0,0,0,'【满血无缓存！进店抽百元E卡，部分型号白条三期免息】兼具速度与可靠性！读速高达3500MB/s，全功率模式！点击 ','','999.00',1000,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/sanxing_ssd_snipaste_01.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/sanxing_ssd_snipaste_02.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/sanxing_ssd_snipaste_03.png\" /></p>',NULL,NULL,0,0,'三星','硬盘'),(45,21,19,0,3,'Stylish Grey T-Shirtee3344789','http://localhost:9000/mall/20241112/p-36.jpg','10052147850350',0,1,0,0,0,0,0,'888.00','999.00',0,0,0,'【11.11提前购机享价保，好货不用等，系统申请一键价保补差!】【Reno8Pro爆款优惠】 ','','999.00',1000,0,'','0.00',0,'','','','http://localhost:9000/mall/20241112/p-03.jpg,http://localhost:9000/mall/20241112/p-10.jpg','','','','<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/oppo_r8_snipaste_01.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/oppo_r8_snipaste_02.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/oppo_r8_snipaste_03.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/oppo_r8_snipaste_04.png\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/oppo_r8_snipaste_05.png\" /></p>','2022-11-09 16:15:50','2022-11-25 00:00:00',0,4,'OPPO','手机通讯'),(46,49,19,0,16,'testfdgjkjfdkf','http://localhost:9000/mall/20241119/p-38.jpg','',0,1,0,1,0,0,0,'100.00',NULL,0,0,0,'dfdsfsdf','There are many variations of passages of Lorem      Ipsum available,but the majority have suffered alteration in some form,','200.00',0,0,'','0.00',0,'','','There are many variations of passages of Lorem\n                                        Ipsum available,but the majority have suffered alteration in some form,','http://localhost:9000/mall/20241119/p-31.jpg,http://localhost:9000/mall/20241125/p-33.jpg,http://localhost:9000/mall/20241125/p-37.jpg,http://localhost:9000/mall/20241125/p-04.jpg','','There are many variations of passages of Lorem   Ipsum available,but the majority have suffered alteration in some form,','<div>\n<pre>There are many variations of passages of Lorem<br />    Ipsum available,but the majority have suffered alteration in some form,</pre>\n</div>','',NULL,NULL,0,0,'七匹狼','手机通讯');

/*Table structure for table `pms_product_attribute` */

DROP TABLE IF EXISTS `pms_product_attribute`;

CREATE TABLE `pms_product_attribute` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_attribute_category_id` bigint(20) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `select_type` int(1) DEFAULT NULL COMMENT '属性选择类型：0->唯一；1->单选；2->多选',
  `input_type` int(1) DEFAULT NULL COMMENT '属性录入方式：0->手工录入；1->从列表中选取',
  `input_list` varchar(255) DEFAULT NULL COMMENT '可选值列表，以逗号隔开',
  `sort` int(11) DEFAULT NULL COMMENT '排序字段：最高的可以单独上传图片',
  `filter_type` int(1) DEFAULT NULL COMMENT '分类筛选样式：1->普通；1->颜色',
  `search_type` int(1) DEFAULT NULL COMMENT '检索类型；0->不需要进行检索；1->关键字检索；2->范围检索',
  `related_status` int(1) DEFAULT NULL COMMENT '相同属性产品是否关联；0->不关联；1->关联',
  `hand_add_status` int(1) DEFAULT NULL COMMENT '是否支持手动新增；0->不支持；1->支持',
  `type` int(1) DEFAULT NULL COMMENT '属性的类型；0->规格；1->参数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品属性参数表';

/*Data for the table `pms_product_attribute` */

insert  into `pms_product_attribute`(`id`,`product_attribute_category_id`,`name`,`select_type`,`input_type`,`input_list`,`sort`,`filter_type`,`search_type`,`related_status`,`hand_add_status`,`type`) values (1,1,'尺寸',2,1,'M,X,XL,2XL,3XL,4XL',0,0,0,0,0,0),(7,1,'颜色',2,1,'黑色,红色,白色,粉色',100,0,0,0,1,0),(13,0,'上市年份',1,1,'2013年,2014年,2015年,2016年,2017年',0,0,0,0,0,1),(14,0,'上市年份1',1,1,'2013年,2014年,2015年,2016年,2017年',0,0,0,0,0,1),(15,0,'上市年份2',1,1,'2013年,2014年,2015年,2016年,2017年',0,0,0,0,0,1),(16,0,'上市年份3',1,1,'2013年,2014年,2015年,2016年,2017年',0,0,0,0,0,1),(17,0,'上市年份4',1,1,'2013年,2014年,2015年,2016年,2017年',0,0,0,0,0,1),(18,0,'上市年份5',1,1,'2013年,2014年,2015年,2016年,2017年',0,0,0,0,0,1),(19,0,'适用对象',1,1,'青年女性,中年女性',0,0,0,0,0,1),(20,0,'适用对象1',2,1,'青年女性,中年女性',0,0,0,0,0,1),(21,0,'适用对象3',2,1,'青年女性,中年女性',0,0,0,0,0,1),(24,1,'商品编号',1,0,'',0,0,0,0,0,1),(25,1,'适用季节',1,1,'春季,夏季,秋季,冬季',0,0,0,0,0,1),(32,2,'适用人群',0,1,'老年,青年,中年',0,0,0,0,0,1),(33,2,'风格',0,1,'嘻哈风格,基础大众,商务正装',0,0,0,0,0,1),(35,2,'颜色',0,0,'',100,0,0,0,1,0),(37,1,'适用人群',1,1,'儿童,青年,中年,老年',0,0,0,0,0,1),(38,1,'上市时间',1,1,'2017年秋,2017年冬,2018年春,2018年夏',0,0,0,0,0,1),(39,1,'袖长',1,1,'短袖,长袖,中袖',0,0,0,0,0,1),(40,2,'尺码',0,1,'29,30,31,32,33,34',0,0,0,0,0,0),(41,2,'适用场景',0,1,'居家,运动,正装',0,0,0,0,0,1),(42,2,'上市时间',0,1,'2018年春,2018年夏',0,0,0,0,0,1),(43,3,'颜色',0,0,'',100,0,0,0,1,0),(44,3,'容量',0,1,'16G,32G,64G,128G,256G,512G',0,0,0,0,0,0),(45,3,'屏幕尺寸',0,0,'',0,0,0,0,0,1),(46,3,'网络',0,1,'3G,4G,5G,WLAN',0,0,0,0,0,1),(47,3,'系统',0,1,'Android,IOS',0,0,0,0,0,1),(48,3,'电池容量',0,0,'',0,0,0,0,0,1),(49,11,'颜色',0,1,'红色,蓝色,绿色',0,1,0,0,0,0),(50,11,'尺寸',0,1,'38,39,40',0,0,0,0,0,0),(51,11,'风格',0,1,'夏季,秋季',0,0,0,0,0,0),(52,12,'尺寸',0,1,'50英寸,65英寸,70英寸',0,0,0,0,0,0),(53,12,'内存',0,1,'8G,16G,32G',0,0,0,0,0,0),(54,12,'商品编号',0,0,'',0,0,0,0,0,1),(55,12,'商品毛重',0,0,'',0,0,0,0,0,1),(56,12,'商品产地',0,1,'中国大陆,其他',0,0,0,0,0,1),(57,12,'电视类型',0,1,'大屏,教育电视,4K超清',0,0,0,0,0,1),(58,13,'颜色',0,0,'',0,0,0,0,1,0),(59,13,'版本',0,1,'R7 16G 512,R5 16G 512,I5 16G 512,I7 16G 512',0,0,0,0,0,0),(60,13,'屏幕尺寸',0,0,'',0,0,0,0,0,1),(61,13,'屏幕分辨率',0,0,'',0,0,0,0,0,1),(62,13,'CPU型号',0,0,'',0,0,0,0,0,1),(63,14,'系列',0,0,'',0,0,0,0,1,0),(64,14,'上市时间',0,0,'',0,0,0,0,0,1),(65,14,'毛重',0,0,'',0,0,0,0,0,1),(66,14,'额定功率',0,0,'',0,0,0,0,0,1),(67,15,'颜色',0,0,'',0,0,0,0,1,0),(68,15,'版本',0,1,'512GB,1TB',0,0,0,0,0,0),(69,15,'系列',0,0,'',0,0,0,0,0,1),(70,15,'型号',0,0,'',0,0,0,0,0,1),(71,15,'闪存类型',0,0,'',0,0,0,0,0,1),(72,15,'顺序读速',0,0,'',0,0,0,0,0,1),(73,15,'顺序写入',0,0,'',0,0,0,0,0,1),(74,16,'Color',1,1,'Red,Yellow,Orange,Black,Blue',0,0,0,0,1,0),(75,16,'Size',0,1,'XS,S,M,L',0,0,0,0,0,0),(76,16,'Fabric',0,0,'',0,0,0,0,0,1),(77,16,'system',0,1,'android,IOS',0,0,0,0,0,1),(78,16,'Heating',1,1,'hot,not hot',0,0,0,0,0,1),(79,3,'test11',0,0,'test1',0,0,0,0,0,0);

/*Table structure for table `pms_product_attribute_category` */

DROP TABLE IF EXISTS `pms_product_attribute_category`;

CREATE TABLE `pms_product_attribute_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `attribute_count` int(11) DEFAULT '0' COMMENT '属性数量',
  `param_count` int(11) DEFAULT '0' COMMENT '参数数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='产品属性分类表';

/*Data for the table `pms_product_attribute_category` */

insert  into `pms_product_attribute_category`(`id`,`name`,`attribute_count`,`param_count`) values (1,'服装-T恤',2,5),(2,'服装-裤装',2,4),(3,'手机数码-手机通讯',3,4),(4,'配件',0,0),(5,'居家',0,0),(6,'洗护',0,0),(10,'测试分类',0,0),(11,'服装-鞋帽',3,0),(12,'家用电器-电视',2,4),(13,'电脑办公-笔记本',2,3),(14,'家用电器-厨卫大电',1,3),(15,'电脑办公-硬盘',2,5),(16,'product-attribute',2,3);

/*Table structure for table `pms_product_attribute_value` */

DROP TABLE IF EXISTS `pms_product_attribute_value`;

CREATE TABLE `pms_product_attribute_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `product_attribute_id` bigint(20) DEFAULT NULL,
  `value` varchar(64) DEFAULT NULL COMMENT '手动添加规格或参数的值，参数单值，规格有多个时以逗号隔开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=747 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='存储产品参数信息的表';

/*Data for the table `pms_product_attribute_value` */

insert  into `pms_product_attribute_value`(`id`,`product_id`,`product_attribute_id`,`value`) values (1,9,1,'X'),(2,10,1,'X'),(3,11,1,'X'),(4,12,1,'X'),(5,13,1,'X'),(6,14,1,'X'),(7,18,1,'X'),(8,7,1,'X'),(9,7,1,'XL'),(10,7,1,'XXL'),(11,22,7,'x,xx'),(12,22,24,'no110'),(13,22,25,'春季'),(14,22,37,'青年'),(15,22,38,'2018年春'),(16,22,39,'长袖'),(124,23,7,'米白色,浅黄色'),(125,23,24,'no1098'),(126,23,25,'春季'),(127,23,37,'青年'),(128,23,38,'2018年春'),(129,23,39,'长袖'),(130,1,13,NULL),(131,1,14,NULL),(132,1,15,NULL),(133,1,16,NULL),(134,1,17,NULL),(135,1,18,NULL),(136,1,19,NULL),(137,1,20,NULL),(138,1,21,NULL),(139,2,13,NULL),(140,2,14,NULL),(141,2,15,NULL),(142,2,16,NULL),(143,2,17,NULL),(144,2,18,NULL),(145,2,19,NULL),(146,2,20,NULL),(147,2,21,NULL),(457,42,43,'曜金黑,冰霜银'),(458,42,45,'6.7英寸'),(459,42,46,'5G'),(460,42,47,'Android'),(461,42,48,'4460mAh'),(466,44,67,'新品980｜NVMe PCIe3.0*4,980 PRO｜NVMe PCIe 4.0'),(467,44,69,'980'),(468,44,70,'MZ-V8V500BW'),(469,44,71,'TLC'),(470,44,72,'3100MB/s'),(471,44,73,'2600MB/s'),(562,43,63,'JSQ25-565W13【13升】【恒温旗舰款】,JSQ30-565W16【16升】【恒温旗舰款】'),(563,43,64,'2021-05'),(564,43,65,'15.5kg'),(565,43,66,'30w'),(637,28,43,'金色,银色'),(638,28,45,'5.0'),(639,28,46,'4G'),(640,28,47,'Android'),(641,28,48,'2800ml'),(642,29,43,'金色,银色'),(643,29,45,'4.7'),(644,29,46,'4G'),(645,29,47,'IOS'),(646,29,48,'1960ml'),(653,31,7,'浅灰色,深灰色'),(654,31,24,'HNTBJ2E080A'),(655,31,25,'夏季'),(656,31,37,'青年'),(657,31,38,'2018年夏'),(658,31,39,'短袖'),(659,32,7,'黑色,白色'),(660,32,24,'HNTBJ2E153A'),(661,32,25,'夏季'),(662,32,37,'青年'),(663,32,38,'2018年夏'),(664,32,39,'短袖'),(665,33,54,'4609652'),(666,33,55,'28.6kg'),(667,33,56,'中国大陆'),(668,33,57,'大屏'),(669,34,54,'4609660'),(670,34,55,'30.8kg'),(671,34,56,'中国大陆'),(672,34,57,'4K超清'),(673,37,43,'午夜色,星光色,紫色,蓝色'),(674,37,45,'6.1英寸'),(675,37,46,'5G'),(676,37,47,'IOS'),(677,37,48,'3000毫安'),(678,38,43,'银色,蓝色'),(679,38,45,'10.9英寸'),(680,38,46,'WLAN'),(681,38,47,'IOS'),(682,38,48,'6000毫安'),(683,39,58,'新小米Pro 14英寸 2.8K屏,新Redmi Pro 15英寸 3.2K屏,dfdf'),(684,39,60,'15.6英寸'),(685,39,61,'3200*2000'),(686,39,62,'R5 6600H'),(687,40,43,'黑色,蓝色'),(688,40,45,'6.73英寸'),(689,40,46,'5G'),(690,40,47,'Android'),(691,40,48,'5160mAh'),(692,45,43,'鸢尾紫,晴空蓝'),(693,45,45,'6.43英寸'),(694,45,46,'5G'),(695,45,47,'Android'),(696,45,48,'4500mAh'),(707,30,7,'蓝色,白色'),(708,30,24,'HNTBJ2E042A'),(709,30,25,'夏季'),(710,30,37,'青年'),(711,30,38,'2018年夏'),(712,30,39,'短袖'),(713,27,43,'黑色,蓝色'),(714,27,45,'5.8'),(715,27,46,'4G'),(716,27,47,'Android'),(717,27,48,'3000ml'),(722,41,43,'墨羽,银迹'),(723,41,45,'6.67英寸'),(724,41,46,'4G'),(725,41,47,'Android'),(726,41,48,'5500mAh'),(741,26,76,NULL),(742,26,77,NULL),(743,26,78,NULL),(744,46,76,'4545454'),(745,46,77,'IOS'),(746,46,78,'hot');

/*Table structure for table `pms_product_category` */

DROP TABLE IF EXISTS `pms_product_category`;

CREATE TABLE `pms_product_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上机分类的编号：0表示一级分类',
  `name` varchar(64) DEFAULT NULL,
  `level` int(1) DEFAULT NULL COMMENT '分类级别：0->1级；1->2级',
  `product_count` int(11) DEFAULT NULL,
  `product_unit` varchar(64) DEFAULT NULL,
  `nav_status` int(1) DEFAULT NULL COMMENT '是否显示在导航栏：0->不显示；1->显示',
  `show_status` int(1) DEFAULT NULL COMMENT '显示状态：0->不显示；1->显示',
  `sort` int(11) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `keywords` varchar(255) DEFAULT NULL,
  `description` text COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='产品分类';

/*Data for the table `pms_product_category` */

insert  into `pms_product_category`(`id`,`parent_id`,`name`,`level`,`product_count`,`product_unit`,`nav_status`,`show_status`,`sort`,`icon`,`keywords`,`description`) values (1,0,'服装',0,100,'件',1,1,1,NULL,'服装','服装分类'),(2,0,'手机数码',0,100,'件',1,1,1,NULL,'手机数码','手机数码'),(3,0,'家用电器',0,100,'件',1,1,1,NULL,'家用电器','家用电器'),(4,0,'家具家装',0,100,'件',1,1,1,NULL,'家具家装','家具家装'),(5,0,'汽车用品',0,100,'件',1,1,1,NULL,'汽车用品','汽车用品'),(7,1,'外套',1,100,'件',1,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190519/5ac4780cN6087feb5.jpg','外套','外套'),(8,1,'T恤',1,100,'件',1,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190519/5ac47ffaN8a7b2e14.png','T恤','T恤'),(9,1,'休闲裤',1,100,'件',1,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190519/5ac47845N7374a31d.jpg','休闲裤','休闲裤'),(10,1,'牛仔裤',1,100,'件',1,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190519/5ac47841Nff658599.jpg','牛仔裤','牛仔裤'),(11,1,'衬衫',1,100,'件',1,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190519/5ac48007Nb30b2118.jpg','衬衫','衬衫分类'),(13,12,'家电子分类1',1,1,'string',0,1,0,'string','string','string'),(14,12,'家电子分类2',1,1,'string',0,1,0,'string','string','string'),(19,2,'手机通讯',1,0,'件',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190519/5ac48d27N3f5bb821.jpg','手机通讯','手机通讯'),(29,1,'男鞋',1,0,'',0,0,0,'','',''),(30,2,'手机配件',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190519/5ac48672N11cf61fe.jpg','手机配件','手机配件'),(31,2,'摄影摄像',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190519/5a1679f2Nc2f659b6.jpg','',''),(32,2,'影音娱乐',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190519/5a167859N01d8198b.jpg','',''),(33,2,'数码配件',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190519/5a1676e9N1ba70a81.jpg','',''),(34,2,'智能设备',1,0,'',0,0,0,'','',''),(35,3,'电视',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a17f71eN25360979.jpg','',''),(36,3,'空调',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a17f6f6Ndfe746aa.jpg','',''),(37,3,'洗衣机',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a17f6eaN9ec936de.jpg','',''),(38,3,'冰箱',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a17f6c5Ne56d7e26.jpg','',''),(39,3,'厨卫大电',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a17f369N6a55ff3f.jpg','',''),(40,3,'厨房小电',1,0,'',0,0,0,'','',''),(41,3,'生活电器',1,0,'',0,0,0,'','',''),(42,3,'个护健康',1,0,'',0,0,0,'','',''),(43,4,'厨房卫浴',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a1eb12cN5ab932bb.jpg','',''),(44,4,'灯饰照明',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a1eb115Na5705672.jpg','',''),(45,4,'五金工具',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a28e743Nf6d99998.jpg','',''),(46,4,'卧室家具',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a1eb096N6326e0bd.jpg','',''),(47,4,'客厅家具',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a1eb080N38c2e7b7.jpg','',''),(48,5,'全新整车',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/ebe31b9cc535e122.png','',''),(49,5,'车载电器',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a1fb8d2N53bbd2ba.jpg','',''),(50,5,'维修保养',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a1fb8baNbe801af8.jpg','',''),(51,5,'汽车装饰',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20200607/5a28ae20N34461e66.jpg','',''),(52,0,'电脑办公',0,0,'件',1,1,1,'','电脑办公','电脑办公'),(53,52,'平板电脑',1,0,'件',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/pad_category_01.jpg','平板电脑','平板电脑'),(54,52,'笔记本',1,0,'件',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/computer_category_01.jpg','笔记本','笔记本'),(55,52,'硬盘',1,0,'',0,1,0,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/ssd_category_01.jpg','硬盘','');

/*Table structure for table `pms_product_category_attribute_relation` */

DROP TABLE IF EXISTS `pms_product_category_attribute_relation`;

CREATE TABLE `pms_product_category_attribute_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_category_id` bigint(20) DEFAULT NULL,
  `product_attribute_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='产品的分类和属性的关系表，用于设置分类筛选条件（只支持一级分类）';

/*Data for the table `pms_product_category_attribute_relation` */

insert  into `pms_product_category_attribute_relation`(`id`,`product_category_id`,`product_attribute_id`) values (1,24,24),(5,26,24),(7,28,24),(9,25,24),(10,25,25);

/*Table structure for table `pms_product_full_reduction` */

DROP TABLE IF EXISTS `pms_product_full_reduction`;

CREATE TABLE `pms_product_full_reduction` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `full_price` decimal(10,2) DEFAULT NULL,
  `reduce_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='产品满减表(只针对同商品)';

/*Data for the table `pms_product_full_reduction` */

insert  into `pms_product_full_reduction`(`id`,`product_id`,`full_price`,`reduce_price`) values (1,7,'100.00','20.00'),(2,8,'100.00','20.00'),(3,9,'100.00','20.00'),(4,10,'100.00','20.00'),(5,11,'100.00','20.00'),(6,12,'100.00','20.00'),(7,13,'100.00','20.00'),(8,14,'100.00','20.00'),(9,18,'100.00','20.00'),(10,7,'200.00','50.00'),(11,7,'300.00','100.00'),(14,22,'0.00','0.00'),(16,24,'0.00','0.00'),(34,23,'0.00','0.00'),(129,42,'0.00','0.00'),(131,44,'0.00','0.00'),(157,43,'0.00','0.00'),(178,28,'500.00','50.00'),(179,28,'1000.00','120.00'),(180,29,'0.00','0.00'),(182,31,'0.00','0.00'),(183,32,'0.00','0.00'),(184,33,'0.00','0.00'),(185,34,'0.00','0.00'),(186,35,'0.00','0.00'),(187,36,'0.00','0.00'),(188,37,'0.00','0.00'),(189,38,'0.00','0.00'),(190,39,'0.00','0.00'),(191,40,'2000.00','200.00'),(192,45,'2000.00','100.00'),(199,30,'0.00','0.00'),(204,27,'0.00','0.00'),(207,41,'0.00','0.00'),(214,26,'3000.00','300.00'),(215,26,'5000.00','500.00'),(216,46,'0.00','0.00');

/*Table structure for table `pms_product_ladder` */

DROP TABLE IF EXISTS `pms_product_ladder`;

CREATE TABLE `pms_product_ladder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `count` int(11) DEFAULT NULL COMMENT '满足的商品数量',
  `discount` decimal(10,2) DEFAULT NULL COMMENT '折扣',
  `price` decimal(10,2) DEFAULT NULL COMMENT '折后价格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='产品阶梯价格表(只针对同商品)';

/*Data for the table `pms_product_ladder` */

insert  into `pms_product_ladder`(`id`,`product_id`,`count`,`discount`,`price`) values (1,7,3,'0.70','0.00'),(2,8,3,'0.70','0.00'),(3,9,3,'0.70','0.00'),(4,10,3,'0.70','0.00'),(5,11,3,'0.70','0.00'),(6,12,3,'0.70','0.00'),(7,13,3,'0.70','0.00'),(8,14,3,'0.70','0.00'),(12,18,3,'0.70','0.00'),(14,7,4,'0.60','0.00'),(15,7,5,'0.50','0.00'),(18,22,0,'0.00','0.00'),(20,24,0,'0.00','0.00'),(38,23,0,'0.00','0.00'),(136,42,0,'0.00','0.00'),(138,44,0,'0.00','0.00'),(157,43,0,'0.00','0.00'),(174,28,0,'0.00','0.00'),(175,29,0,'0.00','0.00'),(177,31,0,'0.00','0.00'),(178,32,0,'0.00','0.00'),(179,33,0,'0.00','0.00'),(180,34,0,'0.00','0.00'),(181,35,0,'0.00','0.00'),(182,36,0,'0.00','0.00'),(183,37,0,'0.00','0.00'),(184,38,0,'0.00','0.00'),(185,39,0,'0.00','0.00'),(186,40,0,'0.00','0.00'),(187,45,1,'0.70','0.00'),(191,30,0,'0.00','0.00'),(196,27,2,'0.80','0.00'),(197,27,3,'0.75','0.00'),(199,41,0,'0.00','0.00'),(204,26,0,'0.00','0.00'),(205,46,0,'0.00','0.00');

/*Table structure for table `pms_product_operate_log` */

DROP TABLE IF EXISTS `pms_product_operate_log`;

CREATE TABLE `pms_product_operate_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `price_old` decimal(10,2) DEFAULT NULL,
  `price_new` decimal(10,2) DEFAULT NULL,
  `sale_price_old` decimal(10,2) DEFAULT NULL,
  `sale_price_new` decimal(10,2) DEFAULT NULL,
  `gift_point_old` int(11) DEFAULT NULL COMMENT '赠送的积分',
  `gift_point_new` int(11) DEFAULT NULL,
  `use_point_limit_old` int(11) DEFAULT NULL,
  `use_point_limit_new` int(11) DEFAULT NULL,
  `operate_man` varchar(64) DEFAULT NULL COMMENT '操作人',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `pms_product_operate_log` */

/*Table structure for table `pms_product_vertify_record` */

DROP TABLE IF EXISTS `pms_product_vertify_record`;

CREATE TABLE `pms_product_vertify_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `vertify_man` varchar(64) DEFAULT NULL COMMENT '审核人',
  `status` int(1) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL COMMENT '反馈详情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品审核记录';

/*Data for the table `pms_product_vertify_record` */

insert  into `pms_product_vertify_record`(`id`,`product_id`,`create_time`,`vertify_man`,`status`,`detail`) values (1,1,'2018-04-27 16:36:41','test',1,'验证通过'),(2,2,'2018-04-27 16:36:41','test',1,'验证通过');

/*Table structure for table `pms_sku_stock` */

DROP TABLE IF EXISTS `pms_sku_stock`;

CREATE TABLE `pms_sku_stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `sku_code` varchar(64) NOT NULL COMMENT 'sku编码',
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT '0' COMMENT '库存',
  `low_stock` int(11) DEFAULT NULL COMMENT '预警库存',
  `pic` varchar(255) DEFAULT NULL COMMENT '展示图片',
  `sale` int(11) DEFAULT NULL COMMENT '销量',
  `promotion_price` decimal(10,2) DEFAULT NULL COMMENT '单品促销价格',
  `lock_stock` int(11) DEFAULT '0' COMMENT '锁定库存',
  `sp_data` varchar(500) DEFAULT NULL COMMENT '商品销售属性，json格式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='sku的库存';

/*Data for the table `pms_sku_stock` */

insert  into `pms_sku_stock`(`id`,`product_id`,`sku_code`,`price`,`stock`,`low_stock`,`pic`,`sale`,`promotion_price`,`lock_stock`,`sp_data`) values (98,27,'201808270027001','2699.00',86,NULL,NULL,NULL,NULL,-24,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(99,27,'201808270027002','2999.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"64G\"}]'),(100,27,'201808270027003','2699.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(101,27,'201808270027004','2999.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"容量\",\"value\":\"64G\"}]'),(102,28,'201808270028001','649.00',99,NULL,NULL,NULL,NULL,-8,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(103,28,'201808270028002','699.00',99,NULL,NULL,NULL,NULL,-8,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(104,28,'201808270028003','649.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(105,28,'201808270028004','699.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(106,29,'201808270029001','5499.00',99,NULL,NULL,NULL,'4999.00',-8,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(107,29,'201808270029002','6299.00',100,NULL,NULL,NULL,'5799.00',0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"64G\"}]'),(108,29,'201808270029003','5499.00',100,NULL,NULL,NULL,'4999.00',0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(109,29,'201808270029004','6299.00',100,NULL,NULL,NULL,'5799.00',0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"容量\",\"value\":\"64G\"}]'),(110,26,'201806070026001','3788.00',487,NULL,NULL,NULL,'3699.00',0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(111,26,'201806070026002','3999.00',499,NULL,NULL,NULL,'3899.00',0,'[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(112,26,'201806070026003','3788.00',500,NULL,NULL,NULL,'3699.00',0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),(113,26,'201806070026004','3999.00',500,NULL,NULL,NULL,'3899.00',0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),(163,36,'202002210036001','100.00',100,25,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"秋季\"}]'),(164,36,'202002210036002','120.00',98,20,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),(165,36,'202002210036003','100.00',100,20,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"39\"},{\"key\":\"风格\",\"value\":\"秋季\"}]'),(166,36,'202002210036004','100.00',100,20,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"39\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),(167,36,'202002210036005','100.00',100,20,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"秋季\"}]'),(168,36,'202002210036006','100.00',100,20,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),(169,36,'202002210036007','100.00',100,20,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"39\"},{\"key\":\"风格\",\"value\":\"秋季\"}]'),(170,36,'202002210036008','100.00',100,20,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"39\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),(171,35,'202002250035001','200.00',100,50,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),(172,35,'202002250035002','240.00',100,50,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"秋季\"}]'),(173,35,'202002250035003','200.00',100,50,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"39\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),(174,35,'202002250035004','200.00',100,50,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"39\"},{\"key\":\"风格\",\"value\":\"秋季\"}]'),(175,35,'202002250035005','200.00',100,50,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),(176,35,'202002250035006','200.00',100,50,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"秋季\"}]'),(177,35,'202002250035007','200.00',100,50,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"39\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),(178,35,'202002250035008','200.00',100,50,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"39\"},{\"key\":\"风格\",\"value\":\"秋季\"}]'),(179,30,'202004190030001','88.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"X\"}]'),(180,30,'202004190030002','88.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"XL\"}]'),(181,30,'202004190030003','88.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"尺寸\",\"value\":\"M\"}]'),(182,30,'202004190030004','88.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"白色\"},{\"key\":\"尺寸\",\"value\":\"X\"}]'),(183,30,'202004190030005','88.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"白色\"},{\"key\":\"尺寸\",\"value\":\"XL\"}]'),(184,30,'202004190030006','88.00',100,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"白色\"},{\"key\":\"尺寸\",\"value\":\"M\"}]'),(185,31,'202004190031001','88.00',80,10,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"浅灰色\"},{\"key\":\"尺寸\",\"value\":\"X\"}]'),(186,31,'202004190031002','88.00',80,10,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"浅灰色\"},{\"key\":\"尺寸\",\"value\":\"XL\"}]'),(187,31,'202004190031003','88.00',80,10,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"深灰色\"},{\"key\":\"尺寸\",\"value\":\"X\"}]'),(188,31,'202004190031004','88.00',80,10,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"深灰色\"},{\"key\":\"尺寸\",\"value\":\"XL\"}]'),(189,32,'202004190032001','99.00',100,10,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"尺寸\",\"value\":\"X\"}]'),(190,32,'202004190032002','99.00',100,10,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"尺寸\",\"value\":\"M\"}]'),(191,32,'202004190032003','99.00',100,10,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"白色\"},{\"key\":\"尺寸\",\"value\":\"X\"}]'),(192,32,'202004190032004','99.00',100,10,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"白色\"},{\"key\":\"尺寸\",\"value\":\"M\"}]'),(193,33,'202004190033001','2499.00',500,10,NULL,NULL,NULL,0,'[{\"key\":\"尺寸\",\"value\":\"50英寸\"},{\"key\":\"内存\",\"value\":\"8G\"}]'),(194,33,'202004190033002','2499.00',500,10,NULL,NULL,NULL,0,'[{\"key\":\"尺寸\",\"value\":\"50英寸\"},{\"key\":\"内存\",\"value\":\"16G\"}]'),(195,33,'202004190033003','2499.00',500,10,NULL,NULL,NULL,0,'[{\"key\":\"尺寸\",\"value\":\"65英寸\"},{\"key\":\"内存\",\"value\":\"8G\"}]'),(196,33,'202004190033004','2499.00',500,10,NULL,NULL,NULL,0,'[{\"key\":\"尺寸\",\"value\":\"65英寸\"},{\"key\":\"内存\",\"value\":\"16G\"}]'),(197,34,'202004190034001','3999.00',500,10,NULL,NULL,NULL,0,'[{\"key\":\"尺寸\",\"value\":\"65英寸\"},{\"key\":\"内存\",\"value\":\"16G\"}]'),(198,34,'202004190034002','3999.00',500,10,NULL,NULL,NULL,0,'[{\"key\":\"尺寸\",\"value\":\"65英寸\"},{\"key\":\"内存\",\"value\":\"32G\"}]'),(199,34,'202004190034003','3999.00',500,10,NULL,NULL,NULL,0,'[{\"key\":\"尺寸\",\"value\":\"70英寸\"},{\"key\":\"内存\",\"value\":\"16G\"}]'),(200,34,'202004190034004','3999.00',500,10,NULL,NULL,NULL,0,'[{\"key\":\"尺寸\",\"value\":\"70英寸\"},{\"key\":\"内存\",\"value\":\"32G\"}]'),(201,37,'202210280037001','5999.00',195,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg',NULL,NULL,1,'[{\"key\":\"颜色\",\"value\":\"午夜色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(202,37,'202210280037002','6899.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"午夜色\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(203,37,'202210280037003','8699.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_001.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"午夜色\"},{\"key\":\"容量\",\"value\":\"512G\"}]'),(204,37,'202210280037004','5999.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_002.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"星光色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(205,37,'202210280037005','6899.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_002.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"星光色\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(206,37,'202210280037006','8699.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_002.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"星光色\"},{\"key\":\"容量\",\"value\":\"512G\"}]'),(207,37,'202210280037007','5999.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_003.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"紫色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(208,37,'202210280037008','6899.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_003.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"紫色\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(209,37,'202210280037009','8699.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_003.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"紫色\"},{\"key\":\"容量\",\"value\":\"512G\"}]'),(210,37,'202210280037010','5999.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_004.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(211,37,'202210280037011','6899.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_004.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(212,37,'202210280037012','8699.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/iphone14_004.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"容量\",\"value\":\"512G\"}]'),(213,38,'202210280038001','3599.00',198,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/ipad_001.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"容量\",\"value\":\"64G\"}]'),(214,38,'202210280038002','4799.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/ipad_001.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(215,38,'202210280038003','3599.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/ipad_002.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"容量\",\"value\":\"64G\"}]'),(216,38,'202210280038004','4799.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221028/ipad_002.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(221,40,'202211040040001','2999.00',91,NULL,'',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(222,40,'202211040040002','3499.00',100,NULL,'',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(223,40,'202211040040003','2999.00',100,NULL,'',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(224,40,'202211040040004','3499.00',100,NULL,'',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"蓝色\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(225,41,'202211040041001','2099.00',195,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_01.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"墨羽\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(226,41,'202211040041002','2299.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_01.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"墨羽\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(227,41,'202211040041003','2099.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_02.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"银迹\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(228,41,'202211040041004','2299.00',200,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/redmi_k50_02.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"银迹\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(229,42,'202211040042001','4999.00',99,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/huawei_mate50_01.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"曜金黑\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(230,42,'202211040042002','5499.00',100,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/huawei_mate50_01.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"曜金黑\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(231,42,'202211040042003','4999.00',100,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/huawei_mate50_02.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"冰霜银\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(232,42,'202211040042004','5499.00',100,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/huawei_mate50_02.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"冰霜银\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(233,43,'202211040043001','1649.00',500,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/wanhe_13L_01.png',NULL,NULL,0,'[{\"key\":\"系列\",\"value\":\"JSQ25-565W13【13升】【恒温旗舰款】\"}]'),(234,43,'202211040043002','1799.00',500,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221104/wanhe_13L_01.png',NULL,NULL,0,'[{\"key\":\"系列\",\"value\":\"JSQ30-565W16【16升】【恒温旗舰款】\"}]'),(235,44,'202211080044001','369.00',99,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/sanxing_ssd_02.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"新品980｜NVMe PCIe3.0*4\"},{\"key\":\"版本\",\"value\":\"512GB\"}]'),(236,44,'202211080044002','649.00',100,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/sanxing_ssd_02.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"新品980｜NVMe PCIe3.0*4\"},{\"key\":\"版本\",\"value\":\"1TB\"}]'),(237,44,'202211080044003','549.00',100,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/sanxing_ssd_01.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"980 PRO｜NVMe PCIe 4.0\"},{\"key\":\"版本\",\"value\":\"512GB\"}]'),(238,44,'202211080044004','899.00',100,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/sanxing_ssd_01.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"980 PRO｜NVMe PCIe 4.0\"},{\"key\":\"版本\",\"value\":\"1TB\"}]'),(243,39,'202411120039001',NULL,NULL,NULL,'',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"新小米Pro 14英寸 2.8K屏\"},{\"key\":\"版本\",\"value\":\"R7 16G 512\"}]'),(244,39,'202411120039002',NULL,NULL,NULL,'',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"新小米Pro 14英寸 2.8K屏\"},{\"key\":\"版本\",\"value\":\"R5 16G 512\"}]'),(245,39,'202411120039003',NULL,NULL,NULL,'',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"新Redmi Pro 15英寸 3.2K屏\"},{\"key\":\"版本\",\"value\":\"R7 16G 512\"}]'),(246,39,'202411120039004',NULL,NULL,NULL,'',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"新Redmi Pro 15英寸 3.2K屏\"},{\"key\":\"版本\",\"value\":\"R5 16G 512\"}]'),(247,45,'202411120045001',NULL,NULL,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/oppo_r8_01.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"鸢尾紫\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(248,45,'202411120045002',NULL,NULL,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/oppo_r8_01.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"鸢尾紫\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(249,45,'202411120045003',NULL,NULL,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/oppo_r8_02.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"晴空蓝\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(250,45,'202411120045004',NULL,NULL,NULL,'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/oppo_r8_02.jpg',NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"晴空蓝\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(251,45,'202411120045005',NULL,NULL,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"dfdf\"},{\"key\":\"容量\",\"value\":\"128G\"}]'),(252,45,'202411120045006',NULL,NULL,NULL,NULL,NULL,NULL,0,'[{\"key\":\"颜色\",\"value\":\"dfdf\"},{\"key\":\"容量\",\"value\":\"256G\"}]'),(258,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-10.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Red\"},{\"key\":\"Size\",\"value\":\"XS\"}]'),(259,46,'2024111917','100.00',100,100,'http://localhost:9000/mall/20241119/p-10.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Red\"},{\"key\":\"Size\",\"value\":\"S\"}]'),(260,46,'2024111918','100.00',100,100,'http://localhost:9000/mall/20241119/p-10.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Red\"},{\"key\":\"Size\",\"value\":\"M\"}]'),(261,46,'2024111919','100.00',100,100,'http://localhost:9000/mall/20241119/p-10.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Red\"},{\"key\":\"Size\",\"value\":\"L\"}]'),(262,46,'2024111920','100.00',100,100,'http://localhost:9000/mall/20241119/p-16.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Yellow\"},{\"key\":\"Size\",\"value\":\"XS\"}]'),(263,46,'2024111921','100.00',100,100,'http://localhost:9000/mall/20241119/p-16.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Yellow\"},{\"key\":\"Size\",\"value\":\"S\"}]'),(264,46,'2024111922','100.00',100,100,'http://localhost:9000/mall/20241119/p-16.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Yellow\"},{\"key\":\"Size\",\"value\":\"M\"}]'),(265,46,'2024111923','100.00',100,100,'http://localhost:9000/mall/20241119/p-16.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Yellow\"},{\"key\":\"Size\",\"value\":\"L\"}]'),(266,46,'2024111924','100.00',100,100,'http://localhost:9000/mall/20241119/p-17.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Orange\"},{\"key\":\"Size\",\"value\":\"XS\"}]'),(267,46,'2024111925','100.00',100,100,'http://localhost:9000/mall/20241119/p-17.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Orange\"},{\"key\":\"Size\",\"value\":\"S\"}]'),(268,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-17.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Orange\"},{\"key\":\"Size\",\"value\":\"M\"}]'),(269,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-17.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Orange\"},{\"key\":\"Size\",\"value\":\"L\"}]'),(270,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-11.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Black\"},{\"key\":\"Size\",\"value\":\"XS\"}]'),(271,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-11.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Black\"},{\"key\":\"Size\",\"value\":\"S\"}]'),(272,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-11.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Black\"},{\"key\":\"Size\",\"value\":\"M\"}]'),(273,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-11.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Black\"},{\"key\":\"Size\",\"value\":\"L\"}]'),(274,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-05.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Blue\"},{\"key\":\"Size\",\"value\":\"XS\"}]'),(275,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-05.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Blue\"},{\"key\":\"Size\",\"value\":\"S\"}]'),(276,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-05.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Blue\"},{\"key\":\"Size\",\"value\":\"M\"}]'),(277,46,'2024111916','100.00',100,100,'http://localhost:9000/mall/20241119/p-05.jpg',NULL,NULL,0,'[{\"key\":\"Color\",\"value\":\"Blue\"},{\"key\":\"Size\",\"value\":\"L\"}]');

/*Table structure for table `sms_coupon` */

DROP TABLE IF EXISTS `sms_coupon`;

CREATE TABLE `sms_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(1) DEFAULT NULL COMMENT '优惠券类型；0->全场赠券；1->会员赠券；2->购物赠券；3->注册赠券',
  `name` varchar(100) DEFAULT NULL,
  `platform` int(1) DEFAULT NULL COMMENT '使用平台：0->全部；1->移动；2->PC',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `per_limit` int(11) DEFAULT NULL COMMENT '每人限领张数',
  `min_point` decimal(10,2) DEFAULT NULL COMMENT '使用门槛；0表示无门槛',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `use_type` int(1) DEFAULT NULL COMMENT '使用类型：0->全场通用；1->指定分类；2->指定商品',
  `note` varchar(200) DEFAULT NULL COMMENT '备注',
  `publish_count` int(11) DEFAULT NULL COMMENT '发行数量',
  `use_count` int(11) DEFAULT NULL COMMENT '已使用数量',
  `receive_count` int(11) DEFAULT NULL COMMENT '领取数量',
  `enable_time` datetime DEFAULT NULL COMMENT '可以领取的日期',
  `code` varchar(64) DEFAULT NULL COMMENT '优惠码',
  `member_level` int(1) DEFAULT NULL COMMENT '可领取的会员类型：0->无限时',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='优惠券表';

/*Data for the table `sms_coupon` */

insert  into `sms_coupon`(`id`,`type`,`name`,`platform`,`count`,`amount`,`per_limit`,`min_point`,`start_time`,`end_time`,`use_type`,`note`,`publish_count`,`use_count`,`receive_count`,`enable_time`,`code`,`member_level`) values (27,0,'全品类通用券',0,94,'10.00',10,'100.00','2022-11-08 00:00:00','2023-11-30 00:00:00',0,NULL,100,0,6,'2022-11-08 00:00:00',NULL,NULL),(28,0,'手机分类专用券',0,995,'100.00',5,'1000.00','2022-11-08 00:00:00','2023-11-30 00:00:00',1,NULL,1000,0,5,'2022-11-08 00:00:00',NULL,NULL),(29,0,'苹果手机专用券',0,998,'600.00',1,'4000.00','2022-11-08 00:00:00','2023-11-30 00:00:00',2,NULL,1000,0,2,'2022-11-08 00:00:00',NULL,NULL),(30,0,'小米手机专用券',0,998,'200.00',1,'2000.00','2022-11-08 00:00:00','2023-11-30 00:00:00',2,NULL,1000,0,2,'2022-11-08 00:00:00',NULL,NULL),(31,0,'限时优惠券',0,999,'20.00',5,'500.00','2022-12-01 00:00:00','2022-12-22 00:00:00',0,NULL,1000,0,1,'2022-12-23 00:00:00',NULL,NULL);

/*Table structure for table `sms_coupon_history` */

DROP TABLE IF EXISTS `sms_coupon_history`;

CREATE TABLE `sms_coupon_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  `coupon_code` varchar(64) DEFAULT NULL,
  `member_nickname` varchar(64) DEFAULT NULL COMMENT '领取人昵称',
  `get_type` int(1) DEFAULT NULL COMMENT '获取类型：0->后台赠送；1->主动获取',
  `create_time` datetime DEFAULT NULL,
  `use_status` int(1) DEFAULT NULL COMMENT '使用状态：0->未使用；1->已使用；2->已过期',
  `use_time` datetime DEFAULT NULL COMMENT '使用时间',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单编号',
  `order_sn` varchar(100) DEFAULT NULL COMMENT '订单号码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_member_id` (`member_id`) USING BTREE,
  KEY `idx_coupon_id` (`coupon_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='优惠券使用、领取历史表';

/*Data for the table `sms_coupon_history` */

insert  into `sms_coupon_history`(`id`,`coupon_id`,`member_id`,`coupon_code`,`member_nickname`,`get_type`,`create_time`,`use_status`,`use_time`,`order_id`,`order_sn`) values (37,30,1,'7806895974110001','windir',1,'2022-11-09 15:14:29',1,'2022-11-09 15:14:58',NULL,NULL),(38,27,1,'7872472849240001','windir',1,'2022-11-09 15:25:25',1,'2022-11-09 15:25:38',NULL,NULL),(39,29,1,'7876204111480001','windir',1,'2022-11-09 15:26:02',1,'2022-11-09 15:26:11',NULL,NULL),(40,27,1,'7911945030190001','windir',1,'2022-11-09 15:31:59',0,NULL,NULL,NULL),(41,28,1,'8194868687790001','windir',1,'2022-11-09 16:19:09',1,'2022-11-11 16:12:42',NULL,NULL),(42,28,1,'1239565720390001','test',1,'2022-12-21 16:46:36',1,'2022-12-21 16:53:07',NULL,NULL),(43,31,1,'6030247208280001','test',1,'2022-12-23 09:51:42',0,NULL,NULL,NULL),(44,28,1,'6050939443480001','test',1,'2022-12-23 09:55:09',0,NULL,NULL,NULL),(45,27,1,'4182437014580001','test',1,'2023-01-10 17:10:24',0,NULL,NULL,NULL),(46,27,11,'9011281751500011','member',1,'2023-05-11 15:28:33',0,NULL,NULL,NULL),(47,28,11,'9011495851370011','member',1,'2023-05-11 15:28:35',1,'2023-05-11 15:37:16',NULL,NULL),(48,30,11,'9011677197430011','member',1,'2023-05-11 15:28:37',1,'2023-05-11 15:28:56',NULL,NULL),(49,27,11,'9046676666610011','member',1,'2023-05-11 15:34:27',0,NULL,NULL,NULL),(50,28,11,'9046909751910011','member',1,'2023-05-11 15:34:29',0,NULL,NULL,NULL),(51,29,11,'9047077722990011','member',1,'2023-05-11 15:34:31',0,NULL,NULL,NULL),(52,27,11,'9075818288630011','member',1,'2023-05-11 15:39:18',0,NULL,NULL,NULL);

/*Table structure for table `sms_coupon_product_category_relation` */

DROP TABLE IF EXISTS `sms_coupon_product_category_relation`;

CREATE TABLE `sms_coupon_product_category_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) DEFAULT NULL,
  `product_category_id` bigint(20) DEFAULT NULL,
  `product_category_name` varchar(200) DEFAULT NULL COMMENT '产品分类名称',
  `parent_category_name` varchar(200) DEFAULT NULL COMMENT '父分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='优惠券和产品分类关系表';

/*Data for the table `sms_coupon_product_category_relation` */

insert  into `sms_coupon_product_category_relation`(`id`,`coupon_id`,`product_category_id`,`product_category_name`,`parent_category_name`) values (11,28,19,'手机通讯','手机数码');

/*Table structure for table `sms_coupon_product_relation` */

DROP TABLE IF EXISTS `sms_coupon_product_relation`;

CREATE TABLE `sms_coupon_product_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `product_name` varchar(500) DEFAULT NULL COMMENT '商品名称',
  `product_sn` varchar(200) DEFAULT NULL COMMENT '商品编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='优惠券和产品的关系表';

/*Data for the table `sms_coupon_product_relation` */

insert  into `sms_coupon_product_relation`(`id`,`coupon_id`,`product_id`,`product_name`,`product_sn`) values (18,29,37,'Apple iPhone 14 (A2884) 128GB 支持移动联通电信5G 双卡双待手机','100038005189'),(19,29,29,'Apple iPhone 8 Plus 64GB 红色特别版 移动联通电信4G手机','7437799'),(21,30,41,'Redmi K50 天玑8100 2K柔性直屏 OIS光学防抖 67W快充 5500mAh大电量 墨羽 12GB+256GB 5G智能手机 小米 红米','100035246702'),(22,30,40,'小米12 Pro 天玑版 天玑9000+处理器 5000万疾速影像 2K超视感屏 120Hz高刷 67W快充 12GB+256GB 黑色 5G手机','100027789721');

/*Table structure for table `sms_flash_promotion` */

DROP TABLE IF EXISTS `sms_flash_promotion`;

CREATE TABLE `sms_flash_promotion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL COMMENT '秒杀时间段名称',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `end_date` date DEFAULT NULL COMMENT '结束日期',
  `status` int(1) DEFAULT NULL COMMENT '上下线状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='限时购表';

/*Data for the table `sms_flash_promotion` */

insert  into `sms_flash_promotion`(`id`,`title`,`start_date`,`end_date`,`status`,`create_time`) values (14,'双11特卖活动','2022-11-09','2023-12-31',1,'2022-11-09 14:56:48');

/*Table structure for table `sms_flash_promotion_log` */

DROP TABLE IF EXISTS `sms_flash_promotion_log`;

CREATE TABLE `sms_flash_promotion_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `member_phone` varchar(64) DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `subscribe_time` datetime DEFAULT NULL COMMENT '会员订阅时间',
  `send_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='限时购通知记录';

/*Data for the table `sms_flash_promotion_log` */

/*Table structure for table `sms_flash_promotion_product_relation` */

DROP TABLE IF EXISTS `sms_flash_promotion_product_relation`;

CREATE TABLE `sms_flash_promotion_product_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `flash_promotion_id` bigint(20) DEFAULT NULL,
  `flash_promotion_session_id` bigint(20) DEFAULT NULL COMMENT '编号',
  `product_id` bigint(20) DEFAULT NULL,
  `flash_promotion_price` decimal(10,2) DEFAULT NULL COMMENT '限时购价格',
  `flash_promotion_count` int(11) DEFAULT NULL COMMENT '限时购数量',
  `flash_promotion_limit` int(11) DEFAULT NULL COMMENT '每人限购数量',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品限时购与商品关系表';

/*Data for the table `sms_flash_promotion_product_relation` */

insert  into `sms_flash_promotion_product_relation`(`id`,`flash_promotion_id`,`flash_promotion_session_id`,`product_id`,`flash_promotion_price`,`flash_promotion_count`,`flash_promotion_limit`,`sort`) values (1,2,1,26,'3000.00',10,1,0),(2,2,1,27,'2000.00',10,1,20),(3,2,1,28,'599.00',19,1,0),(4,2,1,29,'4999.00',10,1,100),(9,2,2,26,'2999.00',100,1,0),(10,2,2,27,NULL,NULL,NULL,NULL),(11,2,2,28,NULL,NULL,NULL,NULL),(12,2,2,29,NULL,NULL,NULL,NULL),(13,2,2,30,NULL,NULL,NULL,NULL),(14,2,3,31,NULL,NULL,NULL,NULL),(15,2,3,32,NULL,NULL,NULL,NULL),(16,2,4,33,NULL,NULL,NULL,NULL),(17,2,4,34,NULL,NULL,NULL,NULL),(18,2,5,36,NULL,NULL,NULL,NULL),(19,2,6,33,NULL,NULL,NULL,NULL),(20,2,6,34,NULL,NULL,NULL,NULL),(21,14,1,26,NULL,NULL,NULL,NULL),(22,14,1,27,NULL,NULL,NULL,NULL),(23,14,1,28,NULL,NULL,NULL,NULL),(24,14,1,29,NULL,NULL,NULL,NULL),(25,14,2,30,NULL,NULL,NULL,NULL),(26,14,2,31,NULL,NULL,NULL,NULL),(27,14,2,32,NULL,NULL,NULL,NULL),(28,14,2,35,NULL,NULL,NULL,NULL),(29,14,3,33,NULL,NULL,NULL,NULL),(30,14,3,34,NULL,NULL,NULL,NULL),(31,14,3,36,NULL,NULL,NULL,NULL),(32,14,3,37,NULL,NULL,NULL,NULL),(33,14,4,37,'5699.00',10,1,NULL),(34,14,4,38,NULL,NULL,NULL,NULL),(35,14,4,39,NULL,NULL,NULL,NULL),(36,14,4,40,NULL,NULL,NULL,NULL),(37,14,5,41,NULL,NULL,NULL,NULL),(38,14,5,42,NULL,NULL,NULL,NULL),(39,14,5,43,NULL,NULL,NULL,NULL),(40,14,5,44,NULL,NULL,NULL,NULL),(41,14,5,45,NULL,NULL,NULL,NULL),(42,14,6,26,NULL,NULL,NULL,NULL),(43,14,6,27,NULL,NULL,NULL,NULL),(44,14,6,28,NULL,NULL,NULL,NULL),(45,14,6,29,NULL,NULL,NULL,NULL),(46,14,6,30,NULL,NULL,NULL,NULL),(47,14,7,31,NULL,NULL,NULL,NULL),(48,14,7,32,NULL,NULL,NULL,NULL),(49,14,7,33,NULL,NULL,NULL,NULL),(50,14,7,34,NULL,NULL,NULL,NULL),(51,14,7,35,NULL,NULL,NULL,NULL);

/*Table structure for table `sms_flash_promotion_session` */

DROP TABLE IF EXISTS `sms_flash_promotion_session`;

CREATE TABLE `sms_flash_promotion_session` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(200) DEFAULT NULL COMMENT '场次名称',
  `start_time` time DEFAULT NULL COMMENT '每日开始时间',
  `end_time` time DEFAULT NULL COMMENT '每日结束时间',
  `status` int(1) DEFAULT NULL COMMENT '启用状态：0->不启用；1->启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='限时购场次表';

/*Data for the table `sms_flash_promotion_session` */

insert  into `sms_flash_promotion_session`(`id`,`name`,`start_time`,`end_time`,`status`,`create_time`) values (1,'8:00','08:00:00','10:00:00',1,'2018-11-16 13:22:17'),(2,'10:00','10:00:00','12:00:00',1,'2018-11-16 13:22:34'),(3,'12:00','12:00:00','14:00:00',1,'2018-11-16 13:22:37'),(4,'14:00','14:00:00','16:00:00',1,'2018-11-16 13:22:41'),(5,'16:00','16:00:00','18:00:00',1,'2018-11-16 13:22:45'),(6,'18:00','18:00:00','20:00:00',1,'2018-11-16 13:21:34'),(7,'20:00','20:00:00','22:00:00',1,'2018-11-16 13:22:55');

/*Table structure for table `sms_home_advertise` */

DROP TABLE IF EXISTS `sms_home_advertise`;

CREATE TABLE `sms_home_advertise` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `type` int(1) DEFAULT NULL COMMENT '轮播位置：0->PC首页轮播；1->app首页轮播',
  `pic` varchar(500) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `status` int(1) DEFAULT NULL COMMENT '上下线状态：0->下线；1->上线',
  `click_count` int(11) DEFAULT NULL COMMENT '点击数',
  `order_count` int(11) DEFAULT NULL COMMENT '下单数',
  `url` varchar(500) DEFAULT NULL COMMENT '链接地址',
  `note` varchar(500) DEFAULT NULL COMMENT '备注',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='首页轮播广告表';

/*Data for the table `sms_home_advertise` */

insert  into `sms_home_advertise`(`id`,`name`,`type`,`pic`,`start_time`,`end_time`,`status`,`click_count`,`order_count`,`url`,`note`,`sort`) values (20,'sold1',1,'http://localhost:9000/mall/20241114/slider-1.jpg','2024-11-12 15:44:06','2024-11-27 00:00:00',1,0,0,'dfdf',NULL,0),(21,'sold2',1,'http://localhost:9000/mall/20241112/slider-6.jpg','2024-11-12 00:00:00','2024-11-19 00:00:00',1,0,0,'dfdf',NULL,0),(22,'sourt3',1,'http://localhost:9000/mall/20241112/slider-5.jpg','2024-11-12 00:00:00','2024-11-12 00:00:00',1,0,0,'dfdfdf',NULL,0);

/*Table structure for table `sms_home_brand` */

DROP TABLE IF EXISTS `sms_home_brand`;

CREATE TABLE `sms_home_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `brand_id` bigint(20) DEFAULT NULL,
  `brand_name` varchar(64) DEFAULT NULL,
  `recommend_status` int(1) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='首页推荐品牌表';

/*Data for the table `sms_home_brand` */

insert  into `sms_home_brand`(`id`,`brand_id`,`brand_name`,`recommend_status`,`sort`) values (6,6,'小米',1,300),(32,50,'海澜之家',1,198),(33,51,'苹果',1,199),(34,2,'三星',1,195),(35,3,'华为',1,200),(39,21,'OPPO',1,197),(45,1,'万和',1,0),(46,5,'方太',1,0),(47,4,'格力',1,0);

/*Table structure for table `sms_home_featured_product` */

DROP TABLE IF EXISTS `sms_home_featured_product`;

CREATE TABLE `sms_home_featured_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `product_name` varchar(500) DEFAULT NULL,
  `recommend_status` int(1) DEFAULT NULL,
  `sort` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='新鲜好物表';

/*Data for the table `sms_home_featured_product` */

insert  into `sms_home_featured_product`(`id`,`product_id`,`product_name`,`recommend_status`,`sort`) values (32,46,'Double Yellow Shirt',1,0),(33,46,'Long Belly Grey Pant',1,0),(34,46,'Half Sleeve T-Shirt',1,0),(35,46,'Stylish Grey T-Shirt',1,0),(36,46,'Stylish Grey T-Shirt23',1,0);

/*Table structure for table `sms_home_new_product` */

DROP TABLE IF EXISTS `sms_home_new_product`;

CREATE TABLE `sms_home_new_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `product_name` varchar(500) DEFAULT NULL,
  `recommend_status` int(1) DEFAULT NULL,
  `sort` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='新鲜好物表';

/*Data for the table `sms_home_new_product` */

insert  into `sms_home_new_product`(`id`,`product_id`,`product_name`,`recommend_status`,`sort`) values (32,26,'Double Yellow Shirt',1,0),(33,27,'Long Belly Grey Pant',1,0),(34,28,'Half Sleeve T-Shirt',1,0),(35,29,'Stylish Grey T-Shirt',1,0),(36,30,'Stylish Grey T-Shirt23',1,0);

/*Table structure for table `sms_home_recommend_product` */

DROP TABLE IF EXISTS `sms_home_recommend_product`;

CREATE TABLE `sms_home_recommend_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `product_name` varchar(500) DEFAULT NULL,
  `recommend_status` int(1) DEFAULT NULL,
  `sort` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='人气推荐商品表';

/*Data for the table `sms_home_recommend_product` */

insert  into `sms_home_recommend_product`(`id`,`product_id`,`product_name`,`recommend_status`,`sort`) values (15,26,'Double Yellow Shirt',1,0),(16,27,'Long Belly Grey Pant',1,0),(17,28,'Half Sleeve T-Shirt',1,0),(18,29,'Stylish Grey T-Shirt',1,0),(19,30,'Stylish Grey T-Shirt23',1,0),(20,31,'Stylish Grey T-Shirt34',1,0),(21,32,'Stylish Grey T-Shirter',1,0),(22,33,'Stylish Grey T-Shirtee',1,0),(23,34,'Stylish Grey T-Shirt45',1,0);

/*Table structure for table `sms_home_recommend_subject` */

DROP TABLE IF EXISTS `sms_home_recommend_subject`;

CREATE TABLE `sms_home_recommend_subject` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subject_id` bigint(20) DEFAULT NULL,
  `subject_name` varchar(64) DEFAULT NULL,
  `recommend_status` int(1) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='首页推荐专题表';

/*Data for the table `sms_home_recommend_subject` */

insert  into `sms_home_recommend_subject`(`id`,`subject_id`,`subject_name`,`recommend_status`,`sort`) values (14,1,'polo衬衫的也时尚',1,0),(15,2,'大牌手机低价秒',1,0),(16,3,'晓龙845新品上市',1,0),(17,4,'夏天应该穿什么',1,0),(18,5,'夏季精选',1,100),(19,6,'品牌手机降价',0,0),(20,1,'polo衬衫的也时尚',0,0),(21,1,'polo衬衫的也时尚',0,0),(22,1,'polo衬衫的也时尚',0,0);

/*Table structure for table `sms_home_trending_product` */

DROP TABLE IF EXISTS `sms_home_trending_product`;

CREATE TABLE `sms_home_trending_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `product_name` varchar(500) DEFAULT NULL,
  `recommend_status` int(1) DEFAULT NULL,
  `sort` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='新鲜好物表';

/*Data for the table `sms_home_trending_product` */

insert  into `sms_home_trending_product`(`id`,`product_id`,`product_name`,`recommend_status`,`sort`) values (32,13,'Double Yellow Shirt',1,0),(33,14,'Long Belly Grey Pant',1,0),(34,18,'Half Sleeve T-Shirt',1,0),(35,22,'Stylish Grey T-Shirt',1,0);

/*Table structure for table `ums_admin` */

DROP TABLE IF EXISTS `ums_admin`;

CREATE TABLE `ums_admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `icon` varchar(500) DEFAULT NULL COMMENT '头像',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
  `note` varchar(500) DEFAULT NULL COMMENT '备注信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `status` int(1) DEFAULT '1' COMMENT '帐号启用状态：0->禁用；1->启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户表';

/*Data for the table `ums_admin` */

insert  into `ums_admin`(`id`,`username`,`password`,`icon`,`email`,`nick_name`,`note`,`create_time`,`login_time`,`status`) values (1,'test','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','https://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/icon/github_icon_02.png','test@qq.com','测试账号',NULL,'2018-09-29 13:55:30','2018-09-29 13:55:39',1),(3,'admin','$2a$10$8tzCu1EBRGIZcadCzMms3.tpv3kt/k3oHx/AS6vQhyOTEJem15nmW','https://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/icon/github_icon_01.png','admin@163.com','系统管理员','系统管理员','2018-10-08 13:32:47','2019-04-20 12:45:16',1),(4,'macro','$2a$10$Bx4jZPR7GhEpIQfefDQtVeS58GfT5n6mxs/b4nLLK65eMFa16topa','https://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/icon/github_icon_01.png','macro@qq.com','macro','macro专用','2019-10-06 15:53:51','2020-02-03 14:55:55',1),(6,'productAdmin','$2a$10$6/.J.p.6Bhn7ic4GfoB5D.pGd7xSiD1a9M6ht6yO0fxzlKJPjRAGm','https://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/icon/github_icon_03.png','product@qq.com','商品管理员','只有商品权限','2020-02-07 16:15:08',NULL,1),(7,'orderAdmin','$2a$10$UqEhA9UZXjHHA3B.L9wNG.6aerrBjC6WHTtbv1FdvYPUI.7lkL6E.','https://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/icon/github_icon_04.png','order@qq.com','订单管理员','只有订单管理权限','2020-02-07 16:15:50',NULL,1),(8,'test123','$2a$10$M1qJguEzwoAN0la7PB8UO.HOGe1xZGku7xw1iTaUUpY0ZVRCxrxoO','string','abc@qq.com','string','string','2022-08-07 14:45:42',NULL,1),(9,'test256','$2a$10$kTMBrt8mkXcO8T4eHThFWOf3KuNK6tqevkiAf4YbtXtaCJ6ocYkJa','string','abc@qq.com','string','string','2022-08-07 14:52:57',NULL,1),(10,'test1267','$2a$10$VUywDhXVPY13YZxMD/uPWeDqkzSozN7o8u/3MX6sBig2NK2VaTJZ2',NULL,'test1267@qq.com','test1267','test1267','2023-01-04 16:13:34',NULL,1);

/*Table structure for table `ums_admin_login_log` */

DROP TABLE IF EXISTS `ums_admin_login_log`;

CREATE TABLE `ums_admin_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `user_agent` varchar(100) DEFAULT NULL COMMENT '浏览器登录类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户登录日志表';

/*Data for the table `ums_admin_login_log` */

insert  into `ums_admin_login_log`(`id`,`admin_id`,`create_time`,`ip`,`address`,`user_agent`) values (1,3,'2018-12-23 14:27:00','0:0:0:0:0:0:0:1',NULL,NULL),(2,3,'2019-04-07 16:04:39','0:0:0:0:0:0:0:1',NULL,NULL),(3,3,'2019-04-08 21:47:52','0:0:0:0:0:0:0:1',NULL,NULL),(4,3,'2019-04-08 21:48:18','0:0:0:0:0:0:0:1',NULL,NULL),(5,3,'2019-04-18 22:18:40','0:0:0:0:0:0:0:1',NULL,NULL),(6,3,'2019-04-20 12:45:16','0:0:0:0:0:0:0:1',NULL,NULL),(7,3,'2019-05-19 14:52:12','0:0:0:0:0:0:0:1',NULL,NULL),(8,3,'2019-05-25 15:00:17','0:0:0:0:0:0:0:1',NULL,NULL),(9,3,'2019-06-19 20:11:42','0:0:0:0:0:0:0:1',NULL,NULL),(10,3,'2019-06-30 10:33:48','0:0:0:0:0:0:0:1',NULL,NULL),(11,3,'2019-06-30 10:34:31','0:0:0:0:0:0:0:1',NULL,NULL),(12,3,'2019-06-30 10:35:34','0:0:0:0:0:0:0:1',NULL,NULL),(13,3,'2019-07-27 17:11:01','0:0:0:0:0:0:0:1',NULL,NULL),(14,3,'2019-07-27 17:13:18','0:0:0:0:0:0:0:1',NULL,NULL),(15,3,'2019-07-27 17:15:35','0:0:0:0:0:0:0:1',NULL,NULL),(16,3,'2019-07-27 17:17:11','0:0:0:0:0:0:0:1',NULL,NULL),(17,3,'2019-07-27 17:18:34','0:0:0:0:0:0:0:1',NULL,NULL),(18,3,'2019-07-27 21:21:52','0:0:0:0:0:0:0:1',NULL,NULL),(19,3,'2019-07-27 21:34:29','0:0:0:0:0:0:0:1',NULL,NULL),(20,3,'2019-07-27 21:35:17','0:0:0:0:0:0:0:1',NULL,NULL),(21,3,'2019-07-27 21:35:48','0:0:0:0:0:0:0:1',NULL,NULL),(22,3,'2019-07-27 21:40:33','0:0:0:0:0:0:0:1',NULL,NULL),(23,3,'2019-08-18 16:00:38','0:0:0:0:0:0:0:1',NULL,NULL),(24,3,'2019-08-18 16:01:06','0:0:0:0:0:0:0:1',NULL,NULL),(25,3,'2019-08-18 16:47:01','0:0:0:0:0:0:0:1',NULL,NULL),(26,3,'2019-10-06 15:54:23','0:0:0:0:0:0:0:1',NULL,NULL),(27,3,'2019-10-06 16:03:28','0:0:0:0:0:0:0:1',NULL,NULL),(28,3,'2019-10-06 16:04:51','0:0:0:0:0:0:0:1',NULL,NULL),(29,3,'2019-10-06 16:06:44','0:0:0:0:0:0:0:1',NULL,NULL),(30,3,'2019-10-06 16:14:51','0:0:0:0:0:0:0:1',NULL,NULL),(31,1,'2019-10-06 16:15:09','0:0:0:0:0:0:0:1',NULL,NULL),(32,1,'2019-10-06 16:16:14','0:0:0:0:0:0:0:1',NULL,NULL),(33,3,'2019-10-06 16:16:35','0:0:0:0:0:0:0:1',NULL,NULL),(34,3,'2019-10-06 16:16:42','0:0:0:0:0:0:0:1',NULL,NULL),(35,3,'2019-10-07 15:20:48','0:0:0:0:0:0:0:1',NULL,NULL),(36,3,'2019-10-07 15:40:07','0:0:0:0:0:0:0:1',NULL,NULL),(37,3,'2019-10-07 16:34:15','0:0:0:0:0:0:0:1',NULL,NULL),(38,3,'2019-10-09 21:19:08','0:0:0:0:0:0:0:1',NULL,NULL),(39,4,'2019-10-09 21:30:35','0:0:0:0:0:0:0:1',NULL,NULL),(40,4,'2019-10-09 21:31:30','0:0:0:0:0:0:0:1',NULL,NULL),(41,4,'2019-10-09 21:32:39','0:0:0:0:0:0:0:1',NULL,NULL),(42,4,'2019-10-09 21:33:27','0:0:0:0:0:0:0:1',NULL,NULL),(43,4,'2019-10-09 21:33:50','0:0:0:0:0:0:0:1',NULL,NULL),(44,3,'2019-10-20 16:02:53','0:0:0:0:0:0:0:1',NULL,NULL),(45,3,'2019-10-23 21:20:55','0:0:0:0:0:0:0:1',NULL,NULL),(46,3,'2019-10-27 21:41:45','0:0:0:0:0:0:0:1',NULL,NULL),(47,3,'2019-11-09 16:44:57','0:0:0:0:0:0:0:1',NULL,NULL),(48,3,'2019-11-09 16:46:56','0:0:0:0:0:0:0:1',NULL,NULL),(49,3,'2019-11-09 16:49:55','0:0:0:0:0:0:0:1',NULL,NULL),(50,3,'2019-11-23 14:17:16','0:0:0:0:0:0:0:1',NULL,NULL),(51,6,'2019-11-23 14:52:30','0:0:0:0:0:0:0:1',NULL,NULL),(52,3,'2019-11-23 15:07:24','0:0:0:0:0:0:0:1',NULL,NULL),(53,3,'2019-11-30 21:25:30','192.168.3.185',NULL,NULL),(54,3,'2019-11-30 21:27:54','192.168.3.185',NULL,NULL),(55,3,'2019-12-28 15:23:01','0:0:0:0:0:0:0:1',NULL,NULL),(56,3,'2020-01-01 15:21:46','0:0:0:0:0:0:0:1',NULL,NULL),(57,3,'2020-01-04 16:00:54','192.168.3.185',NULL,NULL),(58,3,'2020-02-01 15:05:19','0:0:0:0:0:0:0:1',NULL,NULL),(59,3,'2020-02-01 15:36:05','0:0:0:0:0:0:0:1',NULL,NULL),(60,3,'2020-02-01 15:36:36','0:0:0:0:0:0:0:1',NULL,NULL),(61,3,'2020-02-01 15:37:30','0:0:0:0:0:0:0:1',NULL,NULL),(62,3,'2020-02-01 15:37:46','0:0:0:0:0:0:0:1',NULL,NULL),(63,3,'2020-02-01 15:38:20','0:0:0:0:0:0:0:1',NULL,NULL),(64,3,'2020-02-01 15:38:33','0:0:0:0:0:0:0:1',NULL,NULL),(65,3,'2020-02-01 15:39:06','0:0:0:0:0:0:0:1',NULL,NULL),(66,3,'2020-02-01 15:41:31','0:0:0:0:0:0:0:1',NULL,NULL),(67,3,'2020-02-01 15:43:17','0:0:0:0:0:0:0:1',NULL,NULL),(68,3,'2020-02-01 15:44:34','0:0:0:0:0:0:0:1',NULL,NULL),(69,3,'2020-02-01 15:45:10','0:0:0:0:0:0:0:1',NULL,NULL),(70,3,'2020-02-01 15:46:04','0:0:0:0:0:0:0:1',NULL,NULL),(71,3,'2020-02-01 15:48:33','0:0:0:0:0:0:0:1',NULL,NULL),(72,3,'2020-02-01 16:00:07','0:0:0:0:0:0:0:1',NULL,NULL),(73,3,'2020-02-01 16:07:25','0:0:0:0:0:0:0:1',NULL,NULL),(74,3,'2020-02-01 16:08:22','0:0:0:0:0:0:0:1',NULL,NULL),(75,3,'2020-02-02 15:28:13','0:0:0:0:0:0:0:1',NULL,NULL),(76,3,'2020-02-02 15:44:37','0:0:0:0:0:0:0:1',NULL,NULL),(77,3,'2020-02-02 15:45:25','0:0:0:0:0:0:0:1',NULL,NULL),(78,3,'2020-02-02 15:52:32','0:0:0:0:0:0:0:1',NULL,NULL),(79,3,'2020-02-02 15:53:44','0:0:0:0:0:0:0:1',NULL,NULL),(80,3,'2020-02-02 15:54:36','0:0:0:0:0:0:0:1',NULL,NULL),(81,3,'2020-02-02 16:01:00','0:0:0:0:0:0:0:1',NULL,NULL),(82,3,'2020-02-02 16:05:19','0:0:0:0:0:0:0:1',NULL,NULL),(83,3,'2020-02-02 16:06:31','0:0:0:0:0:0:0:1',NULL,NULL),(84,3,'2020-02-02 16:17:26','0:0:0:0:0:0:0:1',NULL,NULL),(85,3,'2020-02-02 16:18:45','0:0:0:0:0:0:0:1',NULL,NULL),(86,3,'2020-02-02 16:19:05','0:0:0:0:0:0:0:1',NULL,NULL),(87,3,'2020-02-02 16:19:23','0:0:0:0:0:0:0:1',NULL,NULL),(88,3,'2020-02-02 16:22:27','0:0:0:0:0:0:0:1',NULL,NULL),(89,3,'2020-02-02 16:23:30','0:0:0:0:0:0:0:1',NULL,NULL),(90,3,'2020-02-02 16:23:48','0:0:0:0:0:0:0:1',NULL,NULL),(91,3,'2020-02-02 16:24:38','0:0:0:0:0:0:0:1',NULL,NULL),(92,3,'2020-02-02 16:25:22','0:0:0:0:0:0:0:1',NULL,NULL),(93,3,'2020-02-02 16:26:19','0:0:0:0:0:0:0:1',NULL,NULL),(94,3,'2020-02-02 16:26:31','0:0:0:0:0:0:0:1',NULL,NULL),(95,3,'2020-02-02 16:27:08','0:0:0:0:0:0:0:1',NULL,NULL),(96,3,'2020-02-02 16:31:02','0:0:0:0:0:0:0:1',NULL,NULL),(97,3,'2020-02-02 16:31:08','0:0:0:0:0:0:0:1',NULL,NULL),(98,3,'2020-02-02 16:31:25','0:0:0:0:0:0:0:1',NULL,NULL),(99,3,'2020-02-02 16:31:50','0:0:0:0:0:0:0:1',NULL,NULL),(100,3,'2020-02-02 16:33:22','0:0:0:0:0:0:0:1',NULL,NULL),(101,3,'2020-02-02 16:33:41','0:0:0:0:0:0:0:1',NULL,NULL),(102,3,'2020-02-02 16:34:58','0:0:0:0:0:0:0:1',NULL,NULL),(103,3,'2020-02-02 16:38:42','0:0:0:0:0:0:0:1',NULL,NULL),(104,3,'2020-02-02 16:39:41','0:0:0:0:0:0:0:1',NULL,NULL),(105,3,'2020-02-02 16:42:22','0:0:0:0:0:0:0:1',NULL,NULL),(106,3,'2020-02-02 16:46:21','0:0:0:0:0:0:0:1',NULL,NULL),(107,3,'2020-02-02 16:50:23','0:0:0:0:0:0:0:1',NULL,NULL),(108,3,'2020-02-02 16:51:11','0:0:0:0:0:0:0:1',NULL,NULL),(109,3,'2020-02-02 16:51:22','0:0:0:0:0:0:0:1',NULL,NULL),(110,3,'2020-02-02 16:52:00','0:0:0:0:0:0:0:1',NULL,NULL),(111,3,'2020-02-02 17:01:05','0:0:0:0:0:0:0:1',NULL,NULL),(112,3,'2020-02-03 10:43:22','0:0:0:0:0:0:0:1',NULL,NULL),(113,3,'2020-02-03 10:45:29','0:0:0:0:0:0:0:1',NULL,NULL),(114,3,'2020-02-03 10:46:33','0:0:0:0:0:0:0:1',NULL,NULL),(115,3,'2020-02-03 10:54:33','0:0:0:0:0:0:0:1',NULL,NULL),(116,3,'2020-02-03 14:24:47','0:0:0:0:0:0:0:1',NULL,NULL),(117,3,'2020-02-03 14:25:38','0:0:0:0:0:0:0:1',NULL,NULL),(118,5,'2020-02-03 15:22:28','0:0:0:0:0:0:0:1',NULL,NULL),(119,5,'2020-02-03 15:23:00','0:0:0:0:0:0:0:1',NULL,NULL),(120,5,'2020-02-03 15:24:29','0:0:0:0:0:0:0:1',NULL,NULL),(121,3,'2020-02-03 15:24:50','0:0:0:0:0:0:0:1',NULL,NULL),(122,5,'2020-02-03 15:27:18','0:0:0:0:0:0:0:1',NULL,NULL),(123,3,'2020-02-03 15:27:33','0:0:0:0:0:0:0:1',NULL,NULL),(124,3,'2020-02-03 15:29:06','0:0:0:0:0:0:0:1',NULL,NULL),(125,5,'2020-02-03 15:33:25','0:0:0:0:0:0:0:1',NULL,NULL),(126,3,'2020-02-03 15:33:51','0:0:0:0:0:0:0:1',NULL,NULL),(127,1,'2020-02-03 15:34:35','0:0:0:0:0:0:0:1',NULL,NULL),(128,3,'2020-02-03 15:34:47','0:0:0:0:0:0:0:1',NULL,NULL),(129,3,'2020-02-04 14:14:46','0:0:0:0:0:0:0:1',NULL,NULL),(130,3,'2020-02-05 10:33:35','0:0:0:0:0:0:0:1',NULL,NULL),(131,3,'2020-02-05 10:36:21','0:0:0:0:0:0:0:1',NULL,NULL),(132,3,'2020-02-05 16:34:37','0:0:0:0:0:0:0:1',NULL,NULL),(133,4,'2020-02-05 16:58:37','0:0:0:0:0:0:0:1',NULL,NULL),(134,3,'2020-02-05 16:59:03','0:0:0:0:0:0:0:1',NULL,NULL),(135,3,'2020-02-06 10:25:02','0:0:0:0:0:0:0:1',NULL,NULL),(136,3,'2020-02-07 14:34:34','0:0:0:0:0:0:0:1',NULL,NULL),(137,3,'2020-02-07 14:36:20','0:0:0:0:0:0:0:1',NULL,NULL),(138,1,'2020-02-07 14:43:34','0:0:0:0:0:0:0:1',NULL,NULL),(139,3,'2020-02-07 15:18:06','0:0:0:0:0:0:0:1',NULL,NULL),(140,3,'2020-02-07 15:20:07','0:0:0:0:0:0:0:1',NULL,NULL),(141,3,'2020-02-07 15:22:20','0:0:0:0:0:0:0:1',NULL,NULL),(142,3,'2020-02-07 15:22:28','0:0:0:0:0:0:0:1',NULL,NULL),(143,3,'2020-02-07 15:55:11','0:0:0:0:0:0:0:1',NULL,NULL),(144,3,'2020-02-07 15:56:04','0:0:0:0:0:0:0:1',NULL,NULL),(145,3,'2020-02-07 15:58:49','0:0:0:0:0:0:0:1',NULL,NULL),(146,6,'2020-02-07 16:16:21','0:0:0:0:0:0:0:1',NULL,NULL),(147,7,'2020-02-07 16:16:37','0:0:0:0:0:0:0:1',NULL,NULL),(148,3,'2020-02-07 16:18:39','0:0:0:0:0:0:0:1',NULL,NULL),(149,7,'2020-02-07 16:20:06','0:0:0:0:0:0:0:1',NULL,NULL),(150,3,'2020-02-07 16:20:44','0:0:0:0:0:0:0:1',NULL,NULL),(151,3,'2020-02-07 16:32:31','0:0:0:0:0:0:0:1',NULL,NULL),(152,3,'2020-02-07 19:32:34','0:0:0:0:0:0:0:1',NULL,NULL),(153,3,'2020-02-07 19:32:48','0:0:0:0:0:0:0:1',NULL,NULL),(154,3,'2020-02-07 19:33:01','0:0:0:0:0:0:0:1',NULL,NULL),(155,3,'2020-02-07 19:33:06','0:0:0:0:0:0:0:1',NULL,NULL),(156,3,'2020-02-07 19:33:21','0:0:0:0:0:0:0:1',NULL,NULL),(157,3,'2020-02-07 19:35:33','0:0:0:0:0:0:0:1',NULL,NULL),(158,3,'2020-02-07 19:37:10','0:0:0:0:0:0:0:1',NULL,NULL),(159,3,'2020-02-07 19:37:14','0:0:0:0:0:0:0:1',NULL,NULL),(160,3,'2020-02-07 19:37:25','0:0:0:0:0:0:0:1',NULL,NULL),(161,3,'2020-02-07 19:45:41','0:0:0:0:0:0:0:1',NULL,NULL),(162,3,'2020-02-07 19:47:45','0:0:0:0:0:0:0:1',NULL,NULL),(163,3,'2020-02-07 20:02:25','0:0:0:0:0:0:0:1',NULL,NULL),(164,6,'2020-02-07 20:10:55','0:0:0:0:0:0:0:1',NULL,NULL),(165,6,'2020-02-07 20:11:02','0:0:0:0:0:0:0:1',NULL,NULL),(166,6,'2020-02-07 20:13:44','0:0:0:0:0:0:0:1',NULL,NULL),(167,6,'2020-02-07 20:17:14','0:0:0:0:0:0:0:1',NULL,NULL),(168,3,'2020-02-07 20:17:44','0:0:0:0:0:0:0:1',NULL,NULL),(169,6,'2020-02-07 20:18:13','0:0:0:0:0:0:0:1',NULL,NULL),(170,3,'2020-02-10 10:28:14','0:0:0:0:0:0:0:1',NULL,NULL),(171,3,'2020-02-10 10:45:15','0:0:0:0:0:0:0:1',NULL,NULL),(172,3,'2020-02-10 10:57:46','0:0:0:0:0:0:0:1',NULL,NULL),(173,3,'2020-02-10 10:59:06','0:0:0:0:0:0:0:1',NULL,NULL),(174,3,'2020-02-10 11:04:19','0:0:0:0:0:0:0:1',NULL,NULL),(175,3,'2020-02-10 11:05:55','0:0:0:0:0:0:0:1',NULL,NULL),(176,3,'2020-02-10 11:06:45','0:0:0:0:0:0:0:1',NULL,NULL),(177,3,'2020-02-10 11:07:41','0:0:0:0:0:0:0:1',NULL,NULL),(178,3,'2020-02-10 11:08:13','0:0:0:0:0:0:0:1',NULL,NULL),(179,3,'2020-02-10 11:10:02','0:0:0:0:0:0:0:1',NULL,NULL),(180,6,'2020-02-10 14:25:17','0:0:0:0:0:0:0:1',NULL,NULL),(181,6,'2020-02-10 14:29:14','0:0:0:0:0:0:0:1',NULL,NULL),(182,3,'2020-02-10 16:09:16','0:0:0:0:0:0:0:1',NULL,NULL),(183,3,'2020-02-20 14:39:19','0:0:0:0:0:0:0:1',NULL,NULL),(184,8,'2020-02-20 17:14:58','0:0:0:0:0:0:0:1',NULL,NULL),(185,8,'2020-02-20 17:17:04','0:0:0:0:0:0:0:1',NULL,NULL),(186,8,'2020-02-20 17:17:42','0:0:0:0:0:0:0:1',NULL,NULL),(187,8,'2020-02-21 10:26:56','0:0:0:0:0:0:0:1',NULL,NULL),(188,8,'2020-02-21 10:28:54','0:0:0:0:0:0:0:1',NULL,NULL),(189,8,'2020-02-21 10:32:25','0:0:0:0:0:0:0:1',NULL,NULL),(190,8,'2020-02-21 10:33:41','0:0:0:0:0:0:0:1',NULL,NULL),(191,8,'2020-02-21 10:35:58','0:0:0:0:0:0:0:1',NULL,NULL),(192,8,'2020-02-21 10:36:49','0:0:0:0:0:0:0:1',NULL,NULL),(193,3,'2020-02-21 11:10:11','0:0:0:0:0:0:0:1',NULL,NULL),(194,3,'2020-02-25 16:11:13','0:0:0:0:0:0:0:1',NULL,NULL),(195,3,'2020-02-25 16:46:29','0:0:0:0:0:0:0:1',NULL,NULL),(196,3,'2020-03-07 16:33:59','192.168.3.185',NULL,NULL),(197,6,'2020-03-07 16:35:38','192.168.3.185',NULL,NULL),(198,3,'2020-03-07 17:00:09','192.168.3.185',NULL,NULL),(199,3,'2020-03-14 14:32:08','0:0:0:0:0:0:0:1',NULL,NULL),(200,8,'2020-03-14 14:32:59','0:0:0:0:0:0:0:1',NULL,NULL),(201,3,'2020-03-14 14:33:26','0:0:0:0:0:0:0:1',NULL,NULL),(202,8,'2020-03-14 14:34:57','0:0:0:0:0:0:0:1',NULL,NULL),(203,3,'2020-03-14 14:35:23','0:0:0:0:0:0:0:1',NULL,NULL),(204,8,'2020-03-14 14:36:31','0:0:0:0:0:0:0:1',NULL,NULL),(205,3,'2020-03-14 14:36:51','0:0:0:0:0:0:0:1',NULL,NULL),(206,8,'2020-03-14 14:37:31','0:0:0:0:0:0:0:1',NULL,NULL),(207,3,'2020-03-14 14:37:44','0:0:0:0:0:0:0:1',NULL,NULL),(208,8,'2020-03-14 14:38:30','0:0:0:0:0:0:0:1',NULL,NULL),(209,3,'2020-03-14 14:38:50','0:0:0:0:0:0:0:1',NULL,NULL),(210,8,'2020-03-14 14:39:26','0:0:0:0:0:0:0:1',NULL,NULL),(211,3,'2020-03-14 14:39:41','0:0:0:0:0:0:0:1',NULL,NULL),(212,3,'2020-03-15 14:23:54','0:0:0:0:0:0:0:1',NULL,NULL),(213,3,'2020-03-22 14:33:17','0:0:0:0:0:0:0:1',NULL,NULL),(214,3,'2020-03-22 14:59:51','0:0:0:0:0:0:0:1',NULL,NULL),(215,3,'2020-03-22 15:04:32','0:0:0:0:0:0:0:1',NULL,NULL),(216,3,'2020-03-29 16:14:37','0:0:0:0:0:0:0:1',NULL,NULL),(217,3,'2020-03-29 17:17:00','0:0:0:0:0:0:0:1',NULL,NULL),(218,3,'2020-04-06 16:54:49','0:0:0:0:0:0:0:1',NULL,NULL),(219,3,'2020-04-12 15:01:40','0:0:0:0:0:0:0:1',NULL,NULL),(220,3,'2020-04-19 09:50:59','0:0:0:0:0:0:0:1',NULL,NULL),(221,3,'2020-05-04 10:45:45','0:0:0:0:0:0:0:1',NULL,NULL),(222,3,'2020-05-05 11:02:44','0:0:0:0:0:0:0:1',NULL,NULL),(223,3,'2020-05-16 15:17:21','0:0:0:0:0:0:0:1',NULL,NULL),(224,3,'2020-05-17 14:58:35','0:0:0:0:0:0:0:1',NULL,NULL),(225,3,'2020-05-18 15:47:46','0:0:0:0:0:0:0:1',NULL,NULL),(226,3,'2020-05-23 16:51:15','0:0:0:0:0:0:0:1',NULL,NULL),(227,3,'2020-05-23 16:54:53','0:0:0:0:0:0:0:1',NULL,NULL),(228,3,'2020-05-23 17:00:33','0:0:0:0:0:0:0:1',NULL,NULL),(229,3,'2020-05-24 10:38:00','0:0:0:0:0:0:0:1',NULL,NULL),(230,3,'2020-06-07 09:39:31','0:0:0:0:0:0:0:1',NULL,NULL),(231,3,'2020-06-14 14:23:30','0:0:0:0:0:0:0:1',NULL,NULL),(232,3,'2020-06-14 17:11:59','0:0:0:0:0:0:0:1',NULL,NULL),(233,3,'2020-06-20 14:53:51','0:0:0:0:0:0:0:1',NULL,NULL),(234,3,'2020-06-21 14:57:36','0:0:0:0:0:0:0:1',NULL,NULL),(235,3,'2020-06-27 10:41:31','0:0:0:0:0:0:0:1',NULL,NULL),(236,3,'2020-07-05 15:54:21','0:0:0:0:0:0:0:1',NULL,NULL),(237,3,'2020-07-11 10:40:28','0:0:0:0:0:0:0:1',NULL,NULL),(238,3,'2020-07-11 10:45:01','0:0:0:0:0:0:0:1',NULL,NULL),(239,3,'2020-07-19 11:00:16','192.168.3.185',NULL,NULL),(240,3,'2020-07-19 11:46:27','192.168.3.185',NULL,NULL),(241,3,'2020-07-19 11:53:47','192.168.3.185',NULL,NULL),(242,3,'2020-07-19 14:17:37','192.168.3.185',NULL,NULL),(243,3,'2020-07-19 14:44:24','192.168.3.185',NULL,NULL),(244,3,'2020-07-19 14:44:58','192.168.3.185',NULL,NULL),(245,3,'2020-07-19 14:48:27','192.168.3.185',NULL,NULL),(246,3,'2020-07-19 14:48:57','192.168.3.185',NULL,NULL),(247,3,'2020-07-19 14:49:30','192.168.3.185',NULL,NULL),(248,3,'2020-07-19 14:50:18','192.168.3.185',NULL,NULL),(249,3,'2020-07-19 14:51:51','192.168.3.185',NULL,NULL),(250,3,'2020-07-19 14:55:27','192.168.3.185',NULL,NULL),(251,3,'2020-07-19 14:58:14','192.168.3.185',NULL,NULL),(252,6,'2020-07-19 15:04:21','192.168.3.185',NULL,NULL),(253,3,'2020-07-19 15:38:49','192.168.3.185',NULL,NULL),(254,6,'2020-07-19 16:26:24','0:0:0:0:0:0:0:1',NULL,NULL),(255,3,'2020-08-08 10:39:12','0:0:0:0:0:0:0:1',NULL,NULL),(256,3,'2020-08-09 11:06:31','0:0:0:0:0:0:0:1',NULL,NULL),(257,3,'2020-08-10 20:41:30','0:0:0:0:0:0:0:1',NULL,NULL),(258,3,'2020-08-15 10:12:25','0:0:0:0:0:0:0:1',NULL,NULL),(259,1,'2020-08-19 21:23:59','0:0:0:0:0:0:0:1',NULL,NULL),(260,1,'2020-08-19 21:25:06','0:0:0:0:0:0:0:1',NULL,NULL),(261,3,'2020-09-05 16:14:50','192.168.3.185',NULL,NULL),(262,3,'2020-09-05 16:15:37','192.168.3.185',NULL,NULL),(263,3,'2020-09-12 16:07:35','0:0:0:0:0:0:0:1',NULL,NULL),(264,6,'2020-09-12 16:08:14','0:0:0:0:0:0:0:1',NULL,NULL),(265,1,'2020-09-12 16:08:26','0:0:0:0:0:0:0:1',NULL,NULL),(266,6,'2020-09-12 16:09:08','0:0:0:0:0:0:0:1',NULL,NULL),(267,1,'2020-09-12 16:09:17','0:0:0:0:0:0:0:1',NULL,NULL),(268,3,'2020-09-13 14:22:25','0:0:0:0:0:0:0:1',NULL,NULL),(269,3,'2020-09-13 14:23:07','0:0:0:0:0:0:0:1',NULL,NULL),(270,3,'2020-09-13 14:24:21','0:0:0:0:0:0:0:1',NULL,NULL),(271,3,'2020-09-13 14:32:32','0:0:0:0:0:0:0:1',NULL,NULL),(272,1,'2020-09-19 15:43:31','192.168.3.185',NULL,NULL),(273,3,'2020-09-19 15:43:58','192.168.3.185',NULL,NULL),(274,3,'2020-09-19 15:49:44','192.168.3.185',NULL,NULL),(275,6,'2020-09-19 15:50:12','192.168.3.185',NULL,NULL),(276,6,'2020-09-19 15:50:18','192.168.3.185',NULL,NULL),(277,1,'2020-09-19 15:50:41','192.168.3.185',NULL,NULL),(278,6,'2020-09-19 15:52:28','192.168.3.185',NULL,NULL),(279,1,'2020-09-19 15:53:01','192.168.3.185',NULL,NULL),(280,1,'2020-09-19 15:53:48','192.168.3.185',NULL,NULL),(281,6,'2020-09-19 15:54:37','192.168.3.185',NULL,NULL),(282,3,'2020-09-20 11:13:50','192.168.3.185',NULL,NULL),(283,1,'2020-10-08 14:26:58','0:0:0:0:0:0:0:1',NULL,NULL),(284,1,'2020-10-08 14:30:49','192.168.3.185',NULL,NULL),(285,3,'2021-04-11 10:27:43','192.168.3.227',NULL,NULL),(286,1,'2021-04-11 10:29:19','192.168.3.227',NULL,NULL),(287,3,'2021-04-11 10:30:40','192.168.3.227',NULL,NULL),(288,3,'2021-04-11 10:37:50','192.168.3.227',NULL,NULL),(289,3,'2021-12-08 10:44:09','192.168.3.4',NULL,NULL),(290,3,'2022-04-15 15:04:51','192.168.56.1',NULL,NULL),(291,1,'2022-05-10 15:25:58','192.168.56.1',NULL,NULL),(292,1,'2022-05-10 15:31:08','192.168.56.1',NULL,NULL),(293,1,'2022-05-10 15:32:18','192.168.56.1',NULL,NULL),(294,1,'2022-05-10 15:34:17','192.168.56.1',NULL,NULL),(295,1,'2022-05-10 15:34:38','192.168.56.1',NULL,NULL),(296,1,'2022-05-10 15:54:50','192.168.56.1',NULL,NULL),(297,1,'2022-05-10 16:31:20','192.168.56.1',NULL,NULL),(298,1,'2022-05-10 16:33:45','192.168.56.1',NULL,NULL),(299,1,'2022-05-10 16:39:07','192.168.56.1',NULL,NULL),(300,1,'2022-05-18 14:53:41','192.168.56.1',NULL,NULL),(301,3,'2022-06-07 17:28:29','192.168.56.1',NULL,NULL),(302,3,'2022-06-08 09:48:32','192.168.56.1',NULL,NULL),(303,3,'2022-06-08 10:34:20','192.168.56.1',NULL,NULL),(304,3,'2022-06-08 17:09:29','192.168.56.1',NULL,NULL),(305,3,'2022-06-08 17:10:11','192.168.56.1',NULL,NULL),(306,6,'2022-06-08 17:10:55','192.168.56.1',NULL,NULL),(307,3,'2022-06-08 17:23:05','192.168.56.1',NULL,NULL),(308,3,'2022-06-08 17:30:51','192.168.56.1',NULL,NULL),(309,3,'2022-06-08 17:31:42','192.168.56.1',NULL,NULL),(310,3,'2022-06-08 17:31:48','192.168.56.1',NULL,NULL),(311,3,'2022-06-08 21:03:56','192.168.56.1',NULL,NULL),(312,3,'2022-06-09 10:41:31','192.168.56.1',NULL,NULL),(313,3,'2022-06-09 15:18:46','192.168.56.1',NULL,NULL),(314,3,'2022-06-10 15:43:15','192.168.56.1',NULL,NULL),(315,3,'2022-06-10 15:52:27','192.168.56.1',NULL,NULL),(316,3,'2022-06-15 14:41:59','192.168.56.1',NULL,NULL),(317,3,'2022-06-23 16:24:09','192.168.3.6',NULL,NULL),(318,3,'2022-06-23 16:41:33','192.168.3.6',NULL,NULL),(319,3,'2022-06-23 16:42:50','192.168.3.6',NULL,NULL),(320,3,'2022-06-23 16:42:51','192.168.3.6',NULL,NULL),(321,3,'2022-06-23 16:42:52','192.168.3.6',NULL,NULL),(322,3,'2022-06-23 16:42:53','192.168.3.6',NULL,NULL),(323,3,'2022-06-23 16:43:07','192.168.3.6',NULL,NULL),(324,3,'2022-06-23 16:44:56','192.168.3.6',NULL,NULL),(325,3,'2022-06-23 16:45:42','192.168.3.6',NULL,NULL),(326,3,'2022-06-23 16:50:08','192.168.3.6',NULL,NULL),(327,3,'2022-06-24 15:19:04','192.168.3.227',NULL,NULL),(328,3,'2022-06-24 15:25:52','192.168.3.227',NULL,NULL),(329,3,'2022-06-24 15:40:29','192.168.3.227',NULL,NULL),(330,3,'2022-06-25 15:13:52','192.168.56.1',NULL,NULL),(331,3,'2022-06-25 15:25:12','192.168.56.1',NULL,NULL),(332,3,'2022-06-27 16:38:37','192.168.56.1',NULL,NULL),(333,3,'2022-07-24 10:10:06','192.168.3.227',NULL,NULL),(334,1,'2022-07-25 17:15:55','192.168.56.1',NULL,NULL),(335,3,'2022-07-27 09:41:32','192.168.3.227',NULL,NULL),(336,1,'2022-07-28 16:56:10','192.168.56.1',NULL,NULL),(337,1,'2022-07-28 16:56:25','192.168.56.1',NULL,NULL),(338,8,'2022-08-07 14:46:00','192.168.56.1',NULL,NULL),(339,9,'2022-08-07 14:53:32','192.168.56.1',NULL,NULL),(340,9,'2022-08-07 14:53:46','192.168.56.1',NULL,NULL),(341,9,'2022-08-07 14:56:19','192.168.56.1',NULL,NULL),(342,1,'2022-08-09 10:53:55','192.168.56.1',NULL,NULL),(343,1,'2022-08-09 10:54:36','192.168.56.1',NULL,NULL),(344,1,'2022-08-09 11:00:06','192.168.56.1',NULL,NULL),(345,1,'2022-08-09 11:02:04','192.168.56.1',NULL,NULL),(346,1,'2022-08-09 15:48:14','192.168.56.1',NULL,NULL),(347,1,'2022-08-16 16:35:24','192.168.56.1',NULL,NULL),(348,1,'2022-08-17 15:03:52','192.168.56.1',NULL,NULL),(349,1,'2022-08-20 16:49:19','192.168.56.1',NULL,NULL),(350,1,'2022-08-23 14:54:06','192.168.56.1',NULL,NULL),(351,1,'2022-08-31 17:16:35','192.168.56.1',NULL,NULL),(352,3,'2022-10-14 15:31:42','192.168.56.1',NULL,NULL),(353,3,'2022-10-14 15:42:39','192.168.56.1',NULL,NULL),(354,3,'2022-10-14 15:44:08','192.168.56.1',NULL,NULL),(355,3,'2022-10-14 15:46:23','192.168.56.1',NULL,NULL),(356,3,'2022-10-14 15:46:35','192.168.56.1',NULL,NULL),(357,3,'2022-10-14 16:06:11','192.168.56.1',NULL,NULL),(358,3,'2022-10-14 16:24:08','192.168.56.1',NULL,NULL),(359,3,'2022-10-17 16:44:52','192.168.56.1',NULL,NULL),(360,3,'2022-10-17 16:49:42','192.168.56.1',NULL,NULL),(361,3,'2022-10-17 16:49:53','192.168.56.1',NULL,NULL),(362,3,'2022-10-17 17:03:10','192.168.56.1',NULL,NULL),(363,3,'2022-10-17 17:03:22','192.168.56.1',NULL,NULL),(364,3,'2022-10-17 21:00:48','192.168.56.1',NULL,NULL),(365,3,'2022-10-24 16:32:31','192.168.56.1',NULL,NULL),(366,3,'2022-10-26 16:31:17','192.168.56.1',NULL,NULL),(367,3,'2022-10-26 16:50:48','192.168.56.1',NULL,NULL),(368,3,'2022-10-26 16:52:28','192.168.56.1',NULL,NULL),(369,3,'2022-10-27 17:21:28','192.168.56.1',NULL,NULL),(370,3,'2022-10-28 10:52:22','192.168.56.1',NULL,NULL),(371,3,'2022-11-04 16:09:08','192.168.56.1',NULL,NULL),(372,3,'2022-11-08 10:27:27','192.168.56.1',NULL,NULL),(373,3,'2022-11-09 10:42:30','192.168.56.1',NULL,NULL),(374,3,'2022-11-10 15:03:08','192.168.56.1',NULL,NULL),(375,3,'2022-11-11 10:11:11','192.168.56.1',NULL,NULL),(376,3,'2022-11-14 16:33:30','192.168.56.1',NULL,NULL),(377,3,'2022-11-15 10:54:02','192.168.56.1',NULL,NULL),(378,3,'2022-11-15 15:16:35','192.168.56.1',NULL,NULL),(379,3,'2022-11-15 15:17:41','192.168.56.1',NULL,NULL),(380,3,'2022-11-15 15:17:47','192.168.56.1',NULL,NULL),(381,1,'2022-11-15 15:19:56','192.168.56.1',NULL,NULL),(382,3,'2022-11-15 15:20:12','192.168.56.1',NULL,NULL),(383,3,'2022-11-15 15:22:22','192.168.56.1',NULL,NULL),(384,3,'2022-11-16 10:39:08','192.168.56.1',NULL,NULL),(385,1,'2022-11-24 20:02:12','192.168.56.1',NULL,NULL),(386,3,'2022-11-28 15:24:02','192.168.56.1',NULL,NULL),(387,3,'2022-11-30 09:34:28','192.168.56.1',NULL,NULL),(388,3,'2022-12-05 09:43:58','192.168.56.1',NULL,NULL),(389,3,'2022-12-09 17:18:09','192.168.56.1',NULL,NULL),(390,3,'2022-12-15 14:53:39','192.168.56.1',NULL,NULL),(391,3,'2022-12-15 16:11:54','192.168.56.1',NULL,NULL),(392,3,'2022-12-20 15:55:18','192.168.56.1',NULL,NULL),(393,3,'2022-12-21 14:49:30','192.168.56.1',NULL,NULL),(394,3,'2022-12-23 09:49:50','192.168.56.1',NULL,NULL),(395,3,'2023-01-04 10:17:44','192.168.56.1',NULL,NULL),(396,3,'2023-01-04 15:28:47','192.168.56.1',NULL,NULL),(397,3,'2023-01-05 10:13:43','192.168.56.1',NULL,NULL),(398,3,'2023-01-06 09:49:23','192.168.56.1',NULL,NULL),(399,3,'2023-01-06 10:04:19','192.168.56.1',NULL,NULL),(400,3,'2023-01-06 10:07:06','192.168.56.1',NULL,NULL),(401,3,'2023-01-06 16:21:31','192.168.56.1',NULL,NULL),(402,3,'2023-01-09 16:50:30','192.168.56.1',NULL,NULL),(403,3,'2023-01-10 10:05:52','192.168.56.1',NULL,NULL),(404,3,'2023-01-10 17:09:44','192.168.56.1',NULL,NULL),(405,3,'2023-01-11 10:17:17','192.168.56.1',NULL,NULL),(406,3,'2023-01-13 09:35:37','192.168.56.1',NULL,NULL),(407,3,'2023-01-13 09:40:51','192.168.56.1',NULL,NULL),(408,3,'2023-01-31 10:46:52','192.168.56.1',NULL,NULL),(409,3,'2023-02-08 17:11:11','192.168.56.1',NULL,NULL),(410,3,'2023-02-09 15:46:41','192.168.56.1',NULL,NULL),(411,3,'2023-02-10 17:23:52','192.168.56.1',NULL,NULL),(412,3,'2023-05-11 15:29:54','192.168.56.1',NULL,NULL),(413,3,'2024-06-26 17:04:10','172.28.9.155',NULL,NULL),(414,3,'2024-06-27 11:54:52','172.28.9.155',NULL,NULL),(415,3,'2024-06-27 13:44:55','172.28.9.155',NULL,NULL),(416,3,'2024-06-28 14:23:01','172.28.9.155',NULL,NULL),(417,3,'2024-07-01 10:35:08','172.28.9.155',NULL,NULL),(418,3,'2024-07-02 10:38:06','198.18.0.1',NULL,NULL),(419,3,'2024-07-02 17:29:01','172.28.9.155',NULL,NULL),(420,3,'2024-07-03 11:27:04','172.28.9.155',NULL,NULL),(421,3,'2024-07-05 08:49:58','172.28.9.155',NULL,NULL),(422,3,'2024-07-05 14:01:07','172.28.9.155',NULL,NULL),(423,3,'2024-07-08 15:54:51','172.28.9.155',NULL,NULL),(424,3,'2024-07-11 09:41:22','198.18.0.1',NULL,NULL),(425,3,'2024-07-12 15:16:30','198.18.0.1',NULL,NULL),(426,3,'2024-07-17 10:34:01','172.28.9.155',NULL,NULL),(427,3,'2024-07-22 14:16:24','172.28.9.155',NULL,NULL),(428,3,'2024-07-24 09:01:58','172.28.9.155',NULL,NULL),(429,3,'2024-09-10 17:17:20','172.28.122.157',NULL,NULL),(430,3,'2024-11-12 14:06:47','172.28.122.157',NULL,NULL),(431,3,'2024-11-12 14:09:42','172.28.122.157',NULL,NULL),(432,3,'2024-11-13 10:17:42','172.28.122.157',NULL,NULL),(433,3,'2024-11-14 09:38:43','172.28.122.157',NULL,NULL),(434,3,'2024-11-15 13:47:24','172.28.122.157',NULL,NULL),(435,3,'2024-11-18 11:24:03','172.28.122.157',NULL,NULL),(436,3,'2024-11-19 14:55:10','198.18.0.1',NULL,NULL),(437,3,'2024-11-19 15:46:54','198.18.0.1',NULL,NULL),(438,3,'2024-11-20 09:45:32','172.28.122.157',NULL,NULL),(439,3,'2024-11-21 15:52:44','172.28.122.157',NULL,NULL),(440,3,'2024-11-25 14:23:57','198.18.0.1',NULL,NULL);

/*Table structure for table `ums_admin_permission_relation` */

DROP TABLE IF EXISTS `ums_admin_permission_relation`;

CREATE TABLE `ums_admin_permission_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) DEFAULT NULL,
  `permission_id` bigint(20) DEFAULT NULL,
  `type` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户和权限关系表(除角色中定义的权限以外的加减权限)';

/*Data for the table `ums_admin_permission_relation` */

/*Table structure for table `ums_admin_role_relation` */

DROP TABLE IF EXISTS `ums_admin_role_relation`;

CREATE TABLE `ums_admin_role_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户和角色关系表';

/*Data for the table `ums_admin_role_relation` */

insert  into `ums_admin_role_relation`(`id`,`admin_id`,`role_id`) values (26,3,5),(27,6,1),(28,7,2),(29,1,5),(30,4,5),(31,8,1);

/*Table structure for table `ums_growth_change_history` */

DROP TABLE IF EXISTS `ums_growth_change_history`;

CREATE TABLE `ums_growth_change_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `change_type` int(1) DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
  `change_count` int(11) DEFAULT NULL COMMENT '积分改变数量',
  `operate_man` varchar(100) DEFAULT NULL COMMENT '操作人员',
  `operate_note` varchar(200) DEFAULT NULL COMMENT '操作备注',
  `source_type` int(1) DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='成长值变化历史记录表';

/*Data for the table `ums_growth_change_history` */

insert  into `ums_growth_change_history`(`id`,`member_id`,`create_time`,`change_type`,`change_count`,`operate_man`,`operate_note`,`source_type`) values (1,1,'2018-08-29 17:16:35',0,1000,'test','测试使用',1);

/*Table structure for table `ums_integration_change_history` */

DROP TABLE IF EXISTS `ums_integration_change_history`;

CREATE TABLE `ums_integration_change_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `change_type` int(1) DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
  `change_count` int(11) DEFAULT NULL COMMENT '积分改变数量',
  `operate_man` varchar(100) DEFAULT NULL COMMENT '操作人员',
  `operate_note` varchar(200) DEFAULT NULL COMMENT '操作备注',
  `source_type` int(1) DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='积分变化历史记录表';

/*Data for the table `ums_integration_change_history` */

/*Table structure for table `ums_integration_consume_setting` */

DROP TABLE IF EXISTS `ums_integration_consume_setting`;

CREATE TABLE `ums_integration_consume_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deduction_per_amount` int(11) DEFAULT NULL COMMENT '每一元需要抵扣的积分数量',
  `max_percent_per_order` int(11) DEFAULT NULL COMMENT '每笔订单最高抵用百分比',
  `use_unit` int(11) DEFAULT NULL COMMENT '每次使用积分最小单位100',
  `coupon_status` int(1) DEFAULT NULL COMMENT '是否可以和优惠券同用；0->不可以；1->可以',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='积分消费设置';

/*Data for the table `ums_integration_consume_setting` */

insert  into `ums_integration_consume_setting`(`id`,`deduction_per_amount`,`max_percent_per_order`,`use_unit`,`coupon_status`) values (1,100,50,100,1);

/*Table structure for table `ums_member` */

DROP TABLE IF EXISTS `ums_member`;

CREATE TABLE `ums_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_level_id` bigint(20) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `phone` varchar(64) DEFAULT NULL COMMENT '手机号码',
  `status` int(1) DEFAULT NULL COMMENT '帐号启用状态:0->禁用；1->启用',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  `icon` varchar(500) DEFAULT NULL COMMENT '头像',
  `gender` int(1) DEFAULT NULL COMMENT '性别：0->未知；1->男；2->女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `city` varchar(64) DEFAULT NULL COMMENT '所做城市',
  `job` varchar(100) DEFAULT NULL COMMENT '职业',
  `personalized_signature` varchar(200) DEFAULT NULL COMMENT '个性签名',
  `source_type` int(1) DEFAULT NULL COMMENT '用户来源',
  `integration` int(11) DEFAULT NULL COMMENT '积分',
  `growth` int(11) DEFAULT NULL COMMENT '成长值',
  `luckey_count` int(11) DEFAULT NULL COMMENT '剩余抽奖次数',
  `history_integration` int(11) DEFAULT NULL COMMENT '历史积分数量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_username` (`username`) USING BTREE,
  UNIQUE KEY `idx_phone` (`phone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员表';

/*Data for the table `ums_member` */

insert  into `ums_member`(`id`,`member_level_id`,`username`,`password`,`nickname`,`phone`,`status`,`email`,`create_time`,`icon`,`gender`,`birthday`,`city`,`job`,`personalized_signature`,`source_type`,`integration`,`growth`,`luckey_count`,`history_integration`) values (1,4,'test','$2a$10$w4gexUkmPSHGPV7kLkYyuu2LMPbfTkMmY6nNKkAokYalx7IN0q38C','test','18061581849',1,'test@gmail.com','2018-08-02 10:35:44','https://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/icon/github_icon_03.png',1,'2009-06-01','上海','学生','test',NULL,3900,1000,NULL,NULL),(3,4,'windy','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','windy','18061581848',1,NULL,'2018-08-03 16:46:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,4,'zhengsan','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','zhengsan','18061581847',1,NULL,'2018-11-12 14:12:04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,4,'lisi','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','lisi','18061581841',1,NULL,'2018-11-12 14:12:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,4,'wangwu','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','wangwu','18061581842',1,NULL,'2018-11-12 14:13:09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,4,'lion','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','lion','18061581845',1,NULL,'2018-11-12 14:21:39',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,4,'shari','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','shari','18061581844',1,NULL,'2018-11-12 14:22:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,4,'aewen','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','aewen','18061581843',1,NULL,'2018-11-12 14:22:55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,4,'guest','$2a$10$WQiD4RzEs1iJVWU.2HVu8OdSlExJHWKmwndaw3SUfMyqfKZmXe1vq',NULL,'18911111111',1,NULL,'2020-03-14 14:52:18',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,4,'abeljing2','$2a$10$us5cOOMCT/pVbXyw6PF3/u1jkfWvdgoIhNag9U85rwUCcP.1ye6aO',NULL,NULL,1,'abeljing2@gmail.com','2024-07-01 16:29:49',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,4,'abeljing','$2a$10$w4gexUkmPSHGPV7kLkYyuu2LMPbfTkMmY6nNKkAokYalx7IN0q38C',NULL,NULL,1,'abeljing1@gmail.com','2024-07-01 17:11:16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `ums_member_level` */

DROP TABLE IF EXISTS `ums_member_level`;

CREATE TABLE `ums_member_level` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `growth_point` int(11) DEFAULT NULL,
  `default_status` int(1) DEFAULT NULL COMMENT '是否为默认等级：0->不是；1->是',
  `free_freight_point` decimal(10,2) DEFAULT NULL COMMENT '免运费标准',
  `comment_growth_point` int(11) DEFAULT NULL COMMENT '每次评价获取的成长值',
  `priviledge_free_freight` int(1) DEFAULT NULL COMMENT '是否有免邮特权',
  `priviledge_sign_in` int(1) DEFAULT NULL COMMENT '是否有签到特权',
  `priviledge_comment` int(1) DEFAULT NULL COMMENT '是否有评论获奖励特权',
  `priviledge_promotion` int(1) DEFAULT NULL COMMENT '是否有专享活动特权',
  `priviledge_member_price` int(1) DEFAULT NULL COMMENT '是否有会员价格特权',
  `priviledge_birthday` int(1) DEFAULT NULL COMMENT '是否有生日特权',
  `note` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员等级表';

/*Data for the table `ums_member_level` */

insert  into `ums_member_level`(`id`,`name`,`growth_point`,`default_status`,`free_freight_point`,`comment_growth_point`,`priviledge_free_freight`,`priviledge_sign_in`,`priviledge_comment`,`priviledge_promotion`,`priviledge_member_price`,`priviledge_birthday`,`note`) values (1,'黄金会员',1000,0,'199.00',5,1,1,1,1,1,1,NULL),(2,'白金会员',5000,0,'99.00',10,1,1,1,1,1,1,NULL),(3,'钻石会员',15000,0,'69.00',15,1,1,1,1,1,1,NULL),(4,'普通会员',1,1,'199.00',20,1,1,1,1,0,0,NULL);

/*Table structure for table `ums_member_login_log` */

DROP TABLE IF EXISTS `ums_member_login_log`;

CREATE TABLE `ums_member_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `login_type` int(1) DEFAULT NULL COMMENT '登录类型：0->PC；1->android;2->ios;3->小程序',
  `province` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员登录记录';

/*Data for the table `ums_member_login_log` */

/*Table structure for table `ums_member_member_tag_relation` */

DROP TABLE IF EXISTS `ums_member_member_tag_relation`;

CREATE TABLE `ums_member_member_tag_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `tag_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户和标签关系表';

/*Data for the table `ums_member_member_tag_relation` */

/*Table structure for table `ums_member_product_category_relation` */

DROP TABLE IF EXISTS `ums_member_product_category_relation`;

CREATE TABLE `ums_member_product_category_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `product_category_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员与产品分类关系表（用户喜欢的分类）';

/*Data for the table `ums_member_product_category_relation` */

/*Table structure for table `ums_member_receive_address` */

DROP TABLE IF EXISTS `ums_member_receive_address`;

CREATE TABLE `ums_member_receive_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '收货人名称',
  `phone_number` varchar(64) DEFAULT NULL,
  `default_status` int(1) DEFAULT NULL COMMENT '是否为默认',
  `post_code` varchar(100) DEFAULT NULL COMMENT '邮政编码',
  `province` varchar(100) DEFAULT NULL COMMENT '省份/直辖市',
  `city` varchar(100) DEFAULT NULL COMMENT '城市',
  `region` varchar(100) DEFAULT NULL COMMENT '区',
  `detail_address` varchar(128) DEFAULT NULL COMMENT '详细地址(街道)',
  `company` varchar(100) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `street_address` varchar(200) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员收货地址表';

/*Data for the table `ums_member_receive_address` */

insert  into `ums_member_receive_address`(`id`,`member_id`,`first_name`,`name`,`phone_number`,`default_status`,`post_code`,`province`,`city`,`region`,`detail_address`,`company`,`country`,`street_address`,`email`) values (1,1,'1111','大梨','18033441849',0,'518000','广东省','深圳市','南山区','科兴科学园','ican','USA','dfdf','test@gmaill.com'),(5,11,NULL,'小李','18961511111',1,'518000','广东省','深圳市','福田区','东晓街道',NULL,NULL,NULL,NULL),(6,11,NULL,'小李','18961511111',NULL,'518000','广东省','深圳市','福田区','清水河街道',NULL,NULL,NULL,NULL);

/*Table structure for table `ums_member_rule_setting` */

DROP TABLE IF EXISTS `ums_member_rule_setting`;

CREATE TABLE `ums_member_rule_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `continue_sign_day` int(11) DEFAULT NULL COMMENT '连续签到天数',
  `continue_sign_point` int(11) DEFAULT NULL COMMENT '连续签到赠送数量',
  `consume_per_point` decimal(10,2) DEFAULT NULL COMMENT '每消费多少元获取1个点',
  `low_order_amount` decimal(10,2) DEFAULT NULL COMMENT '最低获取点数的订单金额',
  `max_point_per_order` int(11) DEFAULT NULL COMMENT '每笔订单最高获取点数',
  `type` int(1) DEFAULT NULL COMMENT '类型：0->积分规则；1->成长值规则',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员积分成长规则表';

/*Data for the table `ums_member_rule_setting` */

/*Table structure for table `ums_member_statistics_info` */

DROP TABLE IF EXISTS `ums_member_statistics_info`;

CREATE TABLE `ums_member_statistics_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `consume_amount` decimal(10,2) DEFAULT NULL COMMENT '累计消费金额',
  `order_count` int(11) DEFAULT NULL COMMENT '订单数量',
  `coupon_count` int(11) DEFAULT NULL COMMENT '优惠券数量',
  `comment_count` int(11) DEFAULT NULL COMMENT '评价数',
  `return_order_count` int(11) DEFAULT NULL COMMENT '退货数量',
  `login_count` int(11) DEFAULT NULL COMMENT '登录次数',
  `attend_count` int(11) DEFAULT NULL COMMENT '关注数量',
  `fans_count` int(11) DEFAULT NULL COMMENT '粉丝数量',
  `collect_product_count` int(11) DEFAULT NULL,
  `collect_subject_count` int(11) DEFAULT NULL,
  `collect_topic_count` int(11) DEFAULT NULL,
  `collect_comment_count` int(11) DEFAULT NULL,
  `invite_friend_count` int(11) DEFAULT NULL,
  `recent_order_time` datetime DEFAULT NULL COMMENT '最后一次下订单时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员统计信息';

/*Data for the table `ums_member_statistics_info` */

/*Table structure for table `ums_member_tag` */

DROP TABLE IF EXISTS `ums_member_tag`;

CREATE TABLE `ums_member_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `finish_order_count` int(11) DEFAULT NULL COMMENT '自动打标签完成订单数量',
  `finish_order_amount` decimal(10,2) DEFAULT NULL COMMENT '自动打标签完成订单金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户标签表';

/*Data for the table `ums_member_tag` */

/*Table structure for table `ums_member_task` */

DROP TABLE IF EXISTS `ums_member_task`;

CREATE TABLE `ums_member_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `growth` int(11) DEFAULT NULL COMMENT '赠送成长值',
  `intergration` int(11) DEFAULT NULL COMMENT '赠送积分',
  `type` int(1) DEFAULT NULL COMMENT '任务类型：0->新手任务；1->日常任务',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员任务表';

/*Data for the table `ums_member_task` */

/*Table structure for table `ums_menu` */

DROP TABLE IF EXISTS `ums_menu`;

CREATE TABLE `ums_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父级ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `title` varchar(100) DEFAULT NULL COMMENT '菜单名称',
  `level` int(4) DEFAULT NULL COMMENT '菜单级数',
  `sort` int(4) DEFAULT NULL COMMENT '菜单排序',
  `name` varchar(100) DEFAULT NULL COMMENT '前端名称',
  `icon` varchar(200) DEFAULT NULL COMMENT '前端图标',
  `hidden` int(1) DEFAULT NULL COMMENT '前端隐藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台菜单表';

/*Data for the table `ums_menu` */

insert  into `ums_menu`(`id`,`parent_id`,`create_time`,`title`,`level`,`sort`,`name`,`icon`,`hidden`) values (1,0,'2020-02-02 14:50:36','商品',0,0,'pms','product',0),(2,1,'2020-02-02 14:51:50','商品列表',1,0,'product','product-list',0),(3,1,'2020-02-02 14:52:44','添加商品',1,0,'addProduct','product-add',0),(4,1,'2020-02-02 14:53:51','商品分类',1,0,'productCate','product-cate',0),(5,1,'2020-02-02 14:54:51','商品类型',1,0,'productAttr','product-attr',0),(6,1,'2020-02-02 14:56:29','品牌管理',1,0,'brand','product-brand',0),(7,0,'2020-02-02 16:54:07','订单',0,0,'oms','order',0),(8,7,'2020-02-02 16:55:18','订单列表',1,0,'order','product-list',0),(9,7,'2020-02-02 16:56:46','订单设置',1,0,'orderSetting','order-setting',0),(10,7,'2020-02-02 16:57:39','退货申请处理',1,0,'returnApply','order-return',0),(11,7,'2020-02-02 16:59:40','退货原因设置',1,0,'returnReason','order-return-reason',0),(12,0,'2020-02-04 16:18:00','营销',0,0,'sms','sms',0),(13,12,'2020-02-04 16:19:22','秒杀活动列表',1,0,'flash','sms-flash',0),(14,12,'2020-02-04 16:20:16','优惠券列表',1,0,'coupon','sms-coupon',0),(16,12,'2020-02-07 16:22:38','品牌推荐',1,0,'homeBrand','product-brand',0),(17,12,'2020-02-07 16:23:14','新品推荐',1,0,'homeNew','sms-new',0),(18,12,'2020-02-07 16:26:38','人气推荐',1,0,'homeHot','sms-hot',0),(19,12,'2020-02-07 16:28:16','专题推荐',1,0,'homeSubject','sms-subject',0),(20,12,'2020-02-07 16:28:42','广告列表',1,0,'homeAdvertise','sms-ad',0),(21,0,'2020-02-07 16:29:13','权限',0,0,'ums','ums',0),(22,21,'2020-02-07 16:29:51','用户列表',1,0,'admin','ums-admin',0),(23,21,'2020-02-07 16:30:13','角色列表',1,0,'role','ums-role',0),(24,21,'2020-02-07 16:30:53','菜单列表',1,0,'menu','ums-menu',0),(25,21,'2020-02-07 16:31:13','资源列表',1,0,'resource','ums-resource',0);

/*Table structure for table `ums_permission` */

DROP TABLE IF EXISTS `ums_permission`;

CREATE TABLE `ums_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT NULL COMMENT '父级权限id',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `value` varchar(200) DEFAULT NULL COMMENT '权限值',
  `icon` varchar(500) DEFAULT NULL COMMENT '图标',
  `type` int(1) DEFAULT NULL COMMENT '权限类型：0->目录；1->菜单；2->按钮（接口绑定权限）',
  `uri` varchar(200) DEFAULT NULL COMMENT '前端资源路径',
  `status` int(1) DEFAULT NULL COMMENT '启用状态；0->禁用；1->启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户权限表';

/*Data for the table `ums_permission` */

insert  into `ums_permission`(`id`,`pid`,`name`,`value`,`icon`,`type`,`uri`,`status`,`create_time`,`sort`) values (1,0,'商品',NULL,NULL,0,NULL,1,'2018-09-29 16:15:14',0),(2,1,'商品列表','pms:product:read',NULL,1,'/pms/product/index',1,'2018-09-29 16:17:01',0),(3,1,'添加商品','pms:product:create',NULL,1,'/pms/product/add',1,'2018-09-29 16:18:51',0),(4,1,'商品分类','pms:productCategory:read',NULL,1,'/pms/productCate/index',1,'2018-09-29 16:23:07',0),(5,1,'商品类型','pms:productAttribute:read',NULL,1,'/pms/productAttr/index',1,'2018-09-29 16:24:43',0),(6,1,'品牌管理','pms:brand:read',NULL,1,'/pms/brand/index',1,'2018-09-29 16:25:45',0),(7,2,'编辑商品','pms:product:update',NULL,2,'/pms/product/updateProduct',1,'2018-09-29 16:34:23',0),(8,2,'删除商品','pms:product:delete',NULL,2,'/pms/product/delete',1,'2018-09-29 16:38:33',0),(9,4,'添加商品分类','pms:productCategory:create',NULL,2,'/pms/productCate/create',1,'2018-09-29 16:43:23',0),(10,4,'修改商品分类','pms:productCategory:update',NULL,2,'/pms/productCate/update',1,'2018-09-29 16:43:55',0),(11,4,'删除商品分类','pms:productCategory:delete',NULL,2,'/pms/productAttr/delete',1,'2018-09-29 16:44:38',0),(12,5,'添加商品类型','pms:productAttribute:create',NULL,2,'/pms/productAttr/create',1,'2018-09-29 16:45:25',0),(13,5,'修改商品类型','pms:productAttribute:update',NULL,2,'/pms/productAttr/update',1,'2018-09-29 16:48:08',0),(14,5,'删除商品类型','pms:productAttribute:delete',NULL,2,'/pms/productAttr/delete',1,'2018-09-29 16:48:44',0),(15,6,'添加品牌','pms:brand:create',NULL,2,'/pms/brand/add',1,'2018-09-29 16:49:34',0),(16,6,'修改品牌','pms:brand:update',NULL,2,'/pms/brand/update',1,'2018-09-29 16:50:55',0),(17,6,'删除品牌','pms:brand:delete',NULL,2,'/pms/brand/delete',1,'2018-09-29 16:50:59',0),(18,0,'首页',NULL,NULL,0,NULL,1,'2018-09-29 16:51:57',0);

/*Table structure for table `ums_resource` */

DROP TABLE IF EXISTS `ums_resource`;

CREATE TABLE `ums_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `name` varchar(200) DEFAULT NULL COMMENT '资源名称',
  `url` varchar(200) DEFAULT NULL COMMENT '资源URL',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `category_id` bigint(20) DEFAULT NULL COMMENT '资源分类ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台资源表';

/*Data for the table `ums_resource` */

insert  into `ums_resource`(`id`,`create_time`,`name`,`url`,`description`,`category_id`) values (1,'2020-02-04 17:04:55','商品品牌管理','/brand/**',NULL,1),(2,'2020-02-04 17:05:35','商品属性分类管理','/productAttribute/category/**',NULL,1),(3,'2020-02-04 17:06:13','商品属性管理','/productAttribute/**',NULL,1),(4,'2020-02-04 17:07:15','商品分类管理','/productCategory/**',NULL,1),(5,'2020-02-04 17:09:16','商品管理','/product/**',NULL,1),(6,'2020-02-04 17:09:53','商品库存管理','/sku/**',NULL,1),(8,'2020-02-05 14:43:37','订单管理','/order/**','',2),(9,'2020-02-05 14:44:22',' 订单退货申请管理','/returnApply/**','',2),(10,'2020-02-05 14:45:08','退货原因管理','/returnReason/**','',2),(11,'2020-02-05 14:45:43','订单设置管理','/orderSetting/**','',2),(12,'2020-02-05 14:46:23','收货地址管理','/companyAddress/**','',2),(13,'2020-02-07 16:37:22','优惠券管理','/coupon/**','',3),(14,'2020-02-07 16:37:59','优惠券领取记录管理','/couponHistory/**','',3),(15,'2020-02-07 16:38:28','限时购活动管理','/flash/**','',3),(16,'2020-02-07 16:38:59','限时购商品关系管理','/flashProductRelation/**','',3),(17,'2020-02-07 16:39:22','限时购场次管理','/flashSession/**','',3),(18,'2020-02-07 16:40:07','首页轮播广告管理','/home/advertise/**','',3),(19,'2020-02-07 16:40:34','首页品牌管理','/home/brand/**','',3),(20,'2020-02-07 16:41:06','首页新品管理','/home/newProduct/**','',3),(21,'2020-02-07 16:42:16','首页人气推荐管理','/home/recommendProduct/**','',3),(22,'2020-02-07 16:42:48','首页专题推荐管理','/home/recommendSubject/**','',3),(23,'2020-02-07 16:44:56',' 商品优选管理','/prefrenceArea/**','',5),(24,'2020-02-07 16:45:39','商品专题管理','/subject/**','',5),(25,'2020-02-07 16:47:34','后台用户管理','/admin/**','',4),(26,'2020-02-07 16:48:24','后台用户角色管理','/role/**','',4),(27,'2020-02-07 16:48:48','后台菜单管理','/menu/**','',4),(28,'2020-02-07 16:49:18','后台资源分类管理','/resourceCategory/**','',4),(29,'2020-02-07 16:49:45','后台资源管理','/resource/**','',4),(30,'2020-09-19 15:47:57','会员等级管理','/memberLevel/**','',7),(31,'2020-09-19 15:51:29','获取登录用户信息','/admin/info','用户登录必配',4),(32,'2020-09-19 15:53:34','用户登出','/admin/logout','用户登出必配',4);

/*Table structure for table `ums_resource_category` */

DROP TABLE IF EXISTS `ums_resource_category`;

CREATE TABLE `ums_resource_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `name` varchar(200) DEFAULT NULL COMMENT '分类名称',
  `sort` int(4) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='资源分类表';

/*Data for the table `ums_resource_category` */

insert  into `ums_resource_category`(`id`,`create_time`,`name`,`sort`) values (1,'2020-02-05 10:21:44','商品模块',0),(2,'2020-02-05 10:22:34','订单模块',0),(3,'2020-02-05 10:22:48','营销模块',0),(4,'2020-02-05 10:23:04','权限模块',0),(5,'2020-02-07 16:34:27','内容模块',0),(7,'2020-09-19 15:49:08','其他模块',0);

/*Table structure for table `ums_role` */

DROP TABLE IF EXISTS `ums_role`;

CREATE TABLE `ums_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `admin_count` int(11) DEFAULT NULL COMMENT '后台用户数量',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` int(1) DEFAULT '1' COMMENT '启用状态：0->禁用；1->启用',
  `sort` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户角色表';

/*Data for the table `ums_role` */

insert  into `ums_role`(`id`,`name`,`description`,`admin_count`,`create_time`,`status`,`sort`) values (1,'商品管理员','只能查看及操作商品',0,'2020-02-03 16:50:37',1,0),(2,'订单管理员','只能查看及操作订单',0,'2018-09-30 15:53:45',1,0),(5,'超级管理员','拥有所有查看和操作功能',0,'2020-02-02 15:11:05',1,0);

/*Table structure for table `ums_role_menu_relation` */

DROP TABLE IF EXISTS `ums_role_menu_relation`;

CREATE TABLE `ums_role_menu_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台角色菜单关系表';

/*Data for the table `ums_role_menu_relation` */

insert  into `ums_role_menu_relation`(`id`,`role_id`,`menu_id`) values (53,2,7),(54,2,8),(55,2,9),(56,2,10),(57,2,11),(72,5,1),(73,5,2),(74,5,3),(75,5,4),(76,5,5),(77,5,6),(78,5,7),(79,5,8),(80,5,9),(81,5,10),(82,5,11),(83,5,12),(84,5,13),(85,5,14),(86,5,16),(87,5,17),(88,5,18),(89,5,19),(90,5,20),(91,5,21),(92,5,22),(93,5,23),(94,5,24),(95,5,25),(121,1,1),(122,1,2),(123,1,3),(124,1,4),(125,1,5),(126,1,6);

/*Table structure for table `ums_role_permission_relation` */

DROP TABLE IF EXISTS `ums_role_permission_relation`;

CREATE TABLE `ums_role_permission_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL,
  `permission_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户角色和权限关系表';

/*Data for the table `ums_role_permission_relation` */

insert  into `ums_role_permission_relation`(`id`,`role_id`,`permission_id`) values (1,1,1),(2,1,2),(3,1,3),(4,1,7),(5,1,8),(6,2,4),(7,2,9),(8,2,10),(9,2,11),(10,3,5),(11,3,12),(12,3,13),(13,3,14),(14,4,6),(15,4,15),(16,4,16),(17,4,17);

/*Table structure for table `ums_role_resource_relation` */

DROP TABLE IF EXISTS `ums_role_resource_relation`;

CREATE TABLE `ums_role_resource_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `resource_id` bigint(20) DEFAULT NULL COMMENT '资源ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台角色资源关系表';

/*Data for the table `ums_role_resource_relation` */

insert  into `ums_role_resource_relation`(`id`,`role_id`,`resource_id`) values (194,5,1),(195,5,2),(196,5,3),(197,5,4),(198,5,5),(199,5,6),(200,5,8),(201,5,9),(202,5,10),(203,5,11),(204,5,12),(205,5,13),(206,5,14),(207,5,15),(208,5,16),(209,5,17),(210,5,18),(211,5,19),(212,5,20),(213,5,21),(214,5,22),(215,5,23),(216,5,24),(217,5,25),(218,5,26),(219,5,27),(220,5,28),(221,5,29),(222,5,30),(232,2,8),(233,2,9),(234,2,10),(235,2,11),(236,2,12),(237,2,31),(238,2,32),(239,1,1),(240,1,2),(241,1,3),(242,1,4),(243,1,5),(244,1,6),(245,1,23),(246,1,24),(247,1,31),(248,1,32);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
