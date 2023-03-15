/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : magiccreative

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 14/03/2023 23:07:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for claims
-- ----------------------------
DROP TABLE IF EXISTS `claims`;
CREATE TABLE `claims`  (
  `claims_id` int(11) NOT NULL COMMENT '可以随机，也可以自增长',
  `claims_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '索赔号：随机数就行用uuid吧',
  `claims_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '申请索赔的时间年月日时分秒',
  `claims_money` float(255, 2) NULL DEFAULT NULL COMMENT '申请索赔的金额，不能超过保险赔偿的最大金额',
  `claims_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '申请的转台 approved同意  negotiation理赔成功， blocked申请失败',
  `policies_id` int(11) NULL DEFAULT NULL COMMENT '购买的保险订单id，可以从这个在policies中找到订单信息从而找到这个保险的最大赔偿金额',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '申请索赔描述',
  `root_id` int(11) NULL DEFAULT NULL COMMENT '处理索赔的保险员',
  `cust_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '客户',
  PRIMARY KEY (`claims_id`) USING BTREE,
  INDEX `policies_id`(`policies_id`) USING BTREE,
  INDEX `root_id`(`root_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of claims
-- ----------------------------
INSERT INTO `claims` VALUES (2754, 'SP1678631413490', '2023-03-12 00:00:00', 200.00, 'negotiation', 31, '111', NULL, '2');
INSERT INTO `claims` VALUES (964, 'SP1678631376654', '2023-03-12 00:00:00', 500.00, 'approved', 31, '111', NULL, '2');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `cust_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户id',
  `cust_account` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '客户账号',
  `cust_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '客户密码',
  `cust_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '客户名字',
  `role` int(11) NULL DEFAULT 2 COMMENT '客户的权限 没用 0超管 1保险员 2用户，用户全部默认是2',
  `cust_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `cust_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '手机',
  `cust_birthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '生日',
  `cust_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '邮件',
  `cust_sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '性别  后面需要的话用户表可以加上一个头像',
  PRIMARY KEY (`cust_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1233334 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, 'hdadmin', 'hdadmin', '欧阳烨', 1, '湖南省张家界市吉首大学仙人阁', '13500000000', '20010927', '2247678912', '女');
INSERT INTO `customer` VALUES (2, 'test11111', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer` VALUES (6, 'test035', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer` VALUES (7, 'test037', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer` VALUES (8, 'test036', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer` VALUES (20, 'test035', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer` VALUES (21, 'test035', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer` VALUES (22, 'test0323', '123', '李志伟', 2, '张家界', '12345565555', '20000101', '960455454@qq.com', '女');
INSERT INTO `customer` VALUES (23, 'test0323', '123', '李志伟', 2, '张家界', '12345565555', '20000101', '960455454@qq.com', '女');
INSERT INTO `customer` VALUES (12, 'test032311', '123', '李志伟111', 2, '张家界', '12345565555', '20000101', '960455454@qq.com', '女');
INSERT INTO `customer` VALUES (122, 'test0323', '123', '李志伟', 2, '张家界', '12345565555', '20000101', '960455454@qq.com', '女');
INSERT INTO `customer` VALUES (123, 'admin', '123', '余博奇', 0, '张家界', '18773611140', '20010927', '2247678912@qq.com', '男');
INSERT INTO `customer` VALUES (12333, 'demo', '123', 'ybq', 2, '张家界', '11111111111', '20190122', '2247678912@qq.com', '男');
INSERT INTO `customer` VALUES (1233333, 'demo2', '123', 'ybqq', 2, '张家界', '11111323321', '20010927', '2247678912@qq.com', '男');
INSERT INTO `customer` VALUES (154416, '7b3e9b70', 'Kv109', '孙朱杨', 2, '河南省信阳市商城县', '112515460972', '20070409', '365684697@qq.com', '男');
INSERT INTO `customer` VALUES (186669, '7b3e9f4e', 'He988', '吴张周', 2, '云南省曲靖市麒麟区', '112172785261', '19931116', '490694283@qq.com', '男');
INSERT INTO `customer` VALUES (264372, '7b3ea001', 'Ao774', '李王宋', 2, '广东省深圳市龙岗区', '111767327003', '20150809', '359544945@qq.com', '男');
INSERT INTO `customer` VALUES (489782, '7b3ea078', 'Uq826', '刘杨梁', 2, '江苏省苏州市吴中区', '112302570063', '20071110', '287587554@qq.com', '男');
INSERT INTO `customer` VALUES (125435, '7b3ea0e6', 'Tr152', '黄周郑', 2, '浙江省宁波市鄞州区', '111737228469', '20021120', '375051160@qq.com', '男');
INSERT INTO `customer` VALUES (928035, '7b3ea150', 'Ms241', '马孙郭', 2, '河南省信阳市罗山县', '110276891273', '20170227', '910749194@qq.com', '女');
INSERT INTO `customer` VALUES (884851, '7b3ea1bd', 'Vm875', '罗王周', 2, '广东省深圳市宝安区', '111126914614', '19980115', '194774784@qq.com', '女');
INSERT INTO `customer` VALUES (360250, '7b3ea228', 'Ro715', '何梁郑', 2, '四川省绵阳市游仙区', '112729043736', '20020219', '461688745@qq.com', '女');
INSERT INTO `customer` VALUES (722642, '7b3ea299', 'Dn349', '高陈孙', 2, '河南省平顶山市新华区金山街D座498号', '110355596352', '20111027', '117886728@qq.com', '男');
INSERT INTO `customer` VALUES (886164, '7b3ea304', 'Fk519', '李宋何', 2, '北京市昌平区沙河桥东北旺西路98号', '110291143786', '19910429', '111984244@qq.com', '女');
INSERT INTO `customer` VALUES (978592, '7b3ea36e', 'Bl934', '周宋高', 2, '广东省东莞市东城区天安数码城3栋501号', '112945022915', '20190521', '725136709@qq.com', '女');
INSERT INTO `customer` VALUES (574325, '7b3ea3da', 'Wt284', '郭李刘', 2, '北京市朝阳区安贞西里10号楼3单元602室', '111506619215', '19850120', '673003690@qq.com', '女');
INSERT INTO `customer` VALUES (658323, '7b3ea519', 'Jb219', '孙李郑', 2, '广东省深圳市南山区高新中二道8号', '111903602014', '19890806', '888400684@qq.com', '女');
INSERT INTO `customer` VALUES (182872, '7b3ea628', 'Vw858', '胡朱罗', 2, '上海市浦东新区浦东南路855号', '110813195069', '20201112', '277393939@qq.com', '男');
INSERT INTO `customer` VALUES (637016, '7b3ea72a', 'Ro823', '黄杨刘', 2, '上海市浦东新区浦东南路855号', '110360233598', '20050901', '198947724@qq.com', '男');
INSERT INTO `customer` VALUES (309646, '7b3ea825', 'Vl730', '陈郑何', 2, '河南省洛阳市涧西区蓝田街道九都村1号', '112198070354', '19920331', '115385795@qq.com', '女');
INSERT INTO `customer` VALUES (496258, '7b3ea9d3', 'Nf584', '李林陈', 2, '河南省洛阳市涧西区蓝田街道九都村1号', '112613762843', '19811020', '615009764@qq.com', '女');
INSERT INTO `customer` VALUES (478835, '7b3eaa3f', 'Qw434', '黄徐周', 2, '河南省洛阳市涧西区蓝田街道九都村1号', '111136791584', '19880324', '741593496@qq.com', '女');
INSERT INTO `customer` VALUES (508681, '7b3eaaa8', 'Sf923', '罗罗郑', 2, '7b3eaa 6771, 7b3eaa, 7b3eaa, 7b3eaa, 682773', '111852423856', '20170713', '876312284@qq.com', '男');
INSERT INTO `customer` VALUES (840833, '7b3eab10', 'Rw438', '杨张梁', 2, '7b3eab 8325, 7b3eab, 7b3eab, 7b3eab, 653242', '110693916194', '20181123', '299663175@qq.com', '男');
INSERT INTO `customer` VALUES (281242, '7b3eab78', 'Xv538', '罗赵马', 2, '7b3eab 558, 7b3eab, 7b3eab, 7b3eab, 529759', '111556097059', '20150919', '883606217@qq.com', '男');
INSERT INTO `customer` VALUES (786450, '7b3eabe1', 'Pr560', '马吴周', 2, '7b3eab 5538, 7b3eab, 7b3eab, 7b3eac, 663817', '111027646883', '19921122', '738423711@qq.com', '女');
INSERT INTO `customer` VALUES (926156, '7b3eac48', 'Tb998', '高张王', 2, '7b3eac 8996, 7b3eac, 7b3eac, 7b3eac, 380472', '112389980386', '20170221', '758250711@qq.com', '男');
INSERT INTO `customer` VALUES (998988, '7b3ead9e', 'Wk410', '朱胡胡', 2, '7b3ead 2189, 7b3ead, 7b3ead, 7b3ead, 195882', '112032440317', '19811017', '175657021@qq.com', '男');
INSERT INTO `customer` VALUES (264188, '7b3eae3a', 'Bs454', '梁王马', 2, '7b3eae 8965, 7b3eae, 7b3eae, 7b3eae, 702831', '110526320582', '19801015', '944155678@qq.com', '女');
INSERT INTO `customer` VALUES (496441, '7b3eaf89', 'Qy720', '林杨杨', 2, '7b3eaf 5143, 7b3eaf, 7b3eaf, 7b3eaf, 816237', '111385764258', '19900810', '501894539@qq.com', '男');
INSERT INTO `customer` VALUES (223208, '7b3eaff6', 'Fp383', '梁陈孙', 2, '7b3eb0 8910, 7b3eb0, 7b3eb0, 7b3eb0, 967535', '112506052881', '20190915', '634474580@qq.com', '女');
INSERT INTO `customer` VALUES (370112, '7b3eb2c1', 'Qj850', '张宋马', 2, '7b3eb2 9245, 7b3eb2, 7b3eb2, 7b3eb2, 922300', '110486032037', '19981203', '893908150@qq.com', '男');
INSERT INTO `customer` VALUES (414013, '7b3eb347', 'Dr107', '宋梁杨', 2, '7b3eb3 7477, 7b3eb3, 7b3eb3, 7b3eb3, 991114', '110863120179', '20050922', '874231042@qq.com', '女');
INSERT INTO `customer` VALUES (200166, '7b3eb3b6', 'Yj134', '李杨王', 2, '7b3eb4 3583, 7b3eb4, 7b3eb4, 7b3eb4, 731738', '111249353712', '20110320', '213349408@qq.com', '男');
INSERT INTO `customer` VALUES (671489, '7b3eb4b4', 'Oy959', '宋王杨', 2, '7b3eb4 346, 7b3eb4, 7b3eb4, 7b3eb4, 492940', '111917374344', '19940708', '198830390@qq.com', '男');
INSERT INTO `customer` VALUES (262131, '7b3eb51e', 'Zl268', '胡马张', 2, '7b3eb5 8323, 7b3eb5, 7b3eb5, 7b3eb5, 770967', '111926474889', '20000414', '668482230@qq.com', '女');
INSERT INTO `customer` VALUES (306267, '7b3eb5bc', 'Rr400', '林黄朱', 2, '7b3eb5 8374, 7b3eb5, 7b3eb5, 7b3eb5, 530963', '112572577515', '19850522', '952709509@qq.com', '男');
INSERT INTO `customer` VALUES (524599, '7b3eb62d', 'Ol524', '李梁王', 2, '7b3eb6 6573, 7b3eb6, 7b3eb6, 7b3eb6, 185319', '110136207491', '19890704', '652928965@qq.com', '女');
INSERT INTO `customer` VALUES (712676, '7b3eb697', 'Hk240', '马周刘', 2, '7b3eb6 6175, 7b3eb6, 7b3eb6, 7b3eb6, 651722', '111782506965', '19830701', '319570335@qq.com', '女');
INSERT INTO `customer` VALUES (337036, '7b3eb700', 'Nv534', '宋孙孙', 2, '7b3eb7 931, 7b3eb7, 7b3eb7, 7b3eb7, 915683', '112103139441', '20120513', '371849703@qq.com', '女');
INSERT INTO `customer` VALUES (247231, '7b3eb76a', 'Zk118', '罗马陈', 2, '7b3eb8 2280, 7b3eb8, 7b3eb8, 7b3eb8, 522251', '110218339679', '19820529', '452242428@qq.com', '男');
INSERT INTO `customer` VALUES (415526, '7b3eb8b5', 'Ld441', '孙赵梁', 2, '7b3eb8 5484, 7b3eb8, 7b3eb8, 7b3eb8, 143307', '112786648207', '20191108', '319955144@qq.com', '男');
INSERT INTO `customer` VALUES (917882, '7b3eb9b5', 'Ob692', '张孙刘', 2, '7b3eb9 2370, 7b3eb9, 7b3eb9, 7b3eb9, 774921', '112509532267', '20010110', '113003388@qq.com', '女');
INSERT INTO `customer` VALUES (566254, '7b3ebae8', 'Ws104', '郑吴吴', 2, '7b3eba 8881, 7b3ebb, 7b3ebb, 7b3ebb, 156117', '112651556227', '19840316', '109803093@qq.com', '女');
INSERT INTO `customer` VALUES (357026, '7b3ebb55', 'Vi216', '林罗林', 2, '7b3ebb 4831, 7b3ebb, 7b3ebb, 7b3ebb, 453664', '110543030158', '20110328', '705211266@qq.com', '女');
INSERT INTO `customer` VALUES (875263, '7b3ebbc3', 'Zi670', '杨杨吴', 2, '7b3ebb 4678, 7b3ebb, 7b3ebb, 7b3ebb, 63482', '110258340353', '19960807', '718319942@qq.com', '女');
INSERT INTO `customer` VALUES (706647, '7b3ebc2e', 'Sq938', '高刘黄', 2, '7b3ebc 1669, 7b3ebc, 7b3ebc, 7b3ebc, 893136', '110105721400', '19860915', '138386647@qq.com', '男');
INSERT INTO `customer` VALUES (425322, '7b3ebd33', 'Nm891', '罗李马', 2, '7b3ebe 6485, 7b3ebe, 7b3ebe, 7b3ebe, 505744', '111250923986', '19970505', '388040178@qq.com', '女');
INSERT INTO `customer` VALUES (925663, '7b3ebe6e', 'Wo252', '陈孙高', 2, '7b3ebe 6434, 7b3ebe, 7b3ebe, 7b3ebe, 762381', '110355621523', '19850413', '314425606@qq.com', '女');
INSERT INTO `customer` VALUES (927338, '7b3ebeda', 'Vi245', '梁郭李', 2, '7b3ebe 1908, 7b3ebe, 7b3ebe, 7b3ebe, 747300', '112507842260', '20040411', '205306158@qq.com', '女');
INSERT INTO `customer` VALUES (663596, '7b3ebf47', 'Tv992', '吴刘周', 2, '7b3ebf 5605, 7b3ebf, 7b3ebf, 7b3ebf, 631109', '111577867912', '20000712', '116015178@qq.com', '女');
INSERT INTO `customer` VALUES (709449, '7b3ec05f', 'Os898', '黄罗郭', 2, '7b3ec0 7841, 7b3ec0, 7b3ec0, 7b3ec0, 766540', '111559092703', '19841203', '981761792@qq.com', '女');
INSERT INTO `customer` VALUES (998216, '7b3ec0e1', 'Qd856', '何黄赵', 2, '7b3ec0 4633, 7b3ec0, 7b3ec1, 7b3ec1, 467821', '110152893519', '19940306', '843873829@qq.com', '男');
INSERT INTO `customer` VALUES (955731, '7b3ec154', 'Xq501', '周吴王', 2, '7b3ec1 8332, 7b3ec1, 7b3ec1, 7b3ec1, 122600', '112659806458', '19880401', '494674957@qq.com', '男');
INSERT INTO `customer` VALUES (487309, '7b3ec256', 'Sf132', '孙周赵', 2, '7b3ec2 4265, 7b3ec2, 7b3ec2, 7b3ec2, 236861', '110285973767', '20150209', '556173277@qq.com', '女');
INSERT INTO `customer` VALUES (532745, '7b3ec391', 'Po154', '马郭梁', 2, '7b3ec3 10, 7b3ec3, 7b3ec3, 7b3ec3, 521858', '111181951970', '20001021', '217700094@qq.com', '男');
INSERT INTO `customer` VALUES (950098, '7b3ec411', 'Xu177', '张黄周', 2, '7b3ec4 7418, 7b3ec4, 7b3ec4, 7b3ec4, 647172', '112969227597', '19840508', '776053670@qq.com', '女');
INSERT INTO `customer` VALUES (648585, '7b3ec47f', 'Dv742', '张吴林', 2, '7b3ec4 1173, 7b3ec4, 7b3ec4, 7b3ec4, 601578', '111032191190', '20000702', '845340791@qq.com', '男');
INSERT INTO `customer` VALUES (165379, '7b3ec4ed', 'Ly412', '罗郭高', 2, '7b3ec5 8921, 7b3ec5, 7b3ec5, 7b3ec5, 997615', '112065417697', '20040501', '184772854@qq.com', '男');
INSERT INTO `customer` VALUES (806826, '7b3ec764', 'Hb561', '黄刘高', 2, '7b3ec7 5428, 7b3ec7, 7b3ec7, 7b3ec7, 289376', '110544794367', '19890916', '328543246@qq.com', '男');
INSERT INTO `customer` VALUES (862407, '7b3ec7f6', 'Hv314', '何张陈', 2, '7b3ec8 7146, 7b3ec8, 7b3ec8, 7b3ec8, 968147', '110909510065', '20051129', '173174124@qq.com', '女');
INSERT INTO `customer` VALUES (345178, '7b3ec869', 'Wl697', '宋罗高', 2, '7b3ec8 1075, 7b3ec8, 7b3ec8, 7b3ec8, 159829', '111570694531', '20180811', '379639114@qq.com', '男');
INSERT INTO `customer` VALUES (231623, '7b3ec975', 'Mz513', '周周何', 2, '7b3ec9 7751, 7b3ec9, 7b3ec9, 7b3ec9, 556248', '111632364750', '20060828', '931189589@qq.com', '女');
INSERT INTO `customer` VALUES (439221, '7b3ec9dd', 'Kw153', '何朱朱', 2, '7b3eca 854, 7b3eca, 7b3eca, 7b3eca, 769998', '111218831146', '20080218', '444855251@qq.com', '男');
INSERT INTO `customer` VALUES (705613, '7b3ecb22', 'Wi162', '黄孙吴', 2, '7b3ecb 6487, 7b3ecb, 7b3ecb, 7b3ecb, 975717', '110203330104', '20110925', '279922753@qq.com', '女');
INSERT INTO `customer` VALUES (945986, '7b3ecb8d', 'Eb796', '林张朱', 2, '7b3ecb 3883, 7b3ecb, 7b3ecb, 7b3ecb, 285723', '112209616031', '19990119', '392085328@qq.com', '男');
INSERT INTO `customer` VALUES (616195, '7b3ecbfa', 'Oz338', '吴刘林', 2, '7b3ecc 9180, 7b3ecc, 7b3ecc, 7b3ecc, 526691', '110361896811', '20150313', '598985997@qq.com', '男');
INSERT INTO `customer` VALUES (570377, '7b3ecc65', 'Hy817', '刘吴胡', 2, '7b3ecc 8549, 7b3ecc, 7b3ecc, 7b3ecc, 401593', '111670847428', '19800331', '778214186@qq.com', '男');
INSERT INTO `customer` VALUES (828052, '7b3ecd01', 'Ap937', '郑胡马', 2, '7b3ecd 120, 7b3ecd, 7b3ecd, 7b3ecd, 279449', '111916373318', '20210817', '182212978@qq.com', '女');
INSERT INTO `customer` VALUES (947728, '7b3ece14', 'Eb848', '罗陈张', 2, '7b3ecf 9945, 7b3ecf, 7b3ecf, 7b3ecf, 646331', '112256036897', '19921130', '300127868@qq.com', '男');
INSERT INTO `customer` VALUES (440353, '7b3ecf5b', 'Re935', '张林李', 2, '7b3ecf 4146, 7b3ecf, 7b3ecf, 7b3ecf, 814319', '110516931853', '20101230', '499602167@qq.com', '女');
INSERT INTO `customer` VALUES (537969, '7b3ecfc8', 'Tg121', '周何高', 2, '7b3ecf 5822, 7b3ecf, 7b3ecf, 7b3ecf, 559731', '112843855752', '20050531', '787655580@qq.com', '女');
INSERT INTO `customer` VALUES (797919, '7b3ed037', 'Lw978', '黄胡刘', 2, '7b3ed0 9621, 7b3ed0, 7b3ed0, 7b3ed0, 320473', '110852312201', '20060904', '519862188@qq.com', '女');
INSERT INTO `customer` VALUES (442246, '7b3ed0a3', 'Qa309', '李郭黄', 2, '7b3ed0 5044, 7b3ed0, 7b3ed0, 7b3ed0, 531644', '112565741036', '19850119', '716761479@qq.com', '男');
INSERT INTO `customer` VALUES (218292, '7b3ed1a4', 'Ii652', '李朱马', 2, '7b3ed1 1531, 7b3ed1, 7b3ed1, 7b3ed1, 62341', '110443554938', '19830106', '785309187@qq.com', '男');
INSERT INTO `customer` VALUES (242485, '7b3ed2e5', 'Ye997', '孙马徐', 2, '7b3ed2 5147, 7b3ed2, 7b3ed3, 7b3ed3, 176963', '111978638582', '19870227', '829802628@qq.com', '男');
INSERT INTO `customer` VALUES (898497, '7b3ed354', 'Go156', '胡王张', 2, '7b3ed3 5033, 7b3ed3, 7b3ed3, 7b3ed3, 207931', '111411277511', '19811223', '401872642@qq.com', '女');
INSERT INTO `customer` VALUES (629116, '7b3ed3c0', 'Ed287', '马黄高', 2, '7b3ed3 733, 7b3ed3, 7b3ed3, 7b3ed3, 959181', '111272576730', '19800201', '224869141@qq.com', '女');
INSERT INTO `customer` VALUES (204082, '7b3ed42f', 'By609', '宋陈刘', 2, '7b3ed4 57, 7b3ed4, 7b3ed4, 7b3ed4, 637009', '112496232375', '20201222', '219432541@qq.com', '女');
INSERT INTO `customer` VALUES (342037, '7b3ed53f', 'Ox949', '宋王陈', 2, '7b3ed5 37, 7b3ed5, 7b3ed5, 7b3ed5, 369582', '110489952882', '19830423', '884764159@qq.com', '男');
INSERT INTO `customer` VALUES (818044, '7b3ed642', 'Ti399', '郭胡李', 2, '7b3ed6 3961, 7b3ed6, 7b3ed6, 7b3ed6, 769185', '111027389053', '20220222', '743355567@qq.com', '男');
INSERT INTO `customer` VALUES (306669, '7b3ed6b0', 'Sy528', '马朱郑', 2, '7b3ed6 9161, 7b3ed6, 7b3ed6, 7b3ed6, 864447', '111278611927', '19910526', '383472248@qq.com', '男');
INSERT INTO `customer` VALUES (165921, '7b3ed71d', 'To566', '罗李朱', 2, '7b3ed7 4385, 7b3ed7, 7b3ed7, 7b3ed7, 624652', '110577035983', '19870306', '374388392@qq.com', '男');
INSERT INTO `customer` VALUES (284562, '7b3ed87d', 'Yd911', '李朱马', 2, '7b3ed8 3202, 7b3ed9, 7b3ed9, 7b3ed9, 820698', '112572132497', '19900915', '490252244@qq.com', '男');

-- ----------------------------
-- Table structure for customer_demo
-- ----------------------------
DROP TABLE IF EXISTS `customer_demo`;
CREATE TABLE `customer_demo`  (
  `cust_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户id',
  `cust_account` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '客户账号',
  `cust_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '客户密码',
  `cust_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '客户名字',
  `role` int(11) NULL DEFAULT 2 COMMENT '客户的权限 没用 0超管 1保险员 2用户，用户全部默认是2',
  `cust_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `cust_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '手机',
  `cust_birthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '生日',
  `cust_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '邮件',
  `cust_sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '性别  后面需要的话用户表可以加上一个头像',
  PRIMARY KEY (`cust_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1233334 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_demo
-- ----------------------------
INSERT INTO `customer_demo` VALUES (1, 'hdadmin', 'hdadmin', '欧阳烨', 1, '湖南省张家界市吉首大学仙人阁', '13500000000', '20010927', '2247678912', '女');
INSERT INTO `customer_demo` VALUES (2, 'test11111', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer_demo` VALUES (6, 'test035', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer_demo` VALUES (7, 'test037', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer_demo` VALUES (8, 'test036', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer_demo` VALUES (20, 'test035', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer_demo` VALUES (21, 'test035', '123', '李志文', 2, '湖南省', '12222222222', '20010909', '2222222222@qq.com', '男');
INSERT INTO `customer_demo` VALUES (22, 'test0323', '123', '李志伟', 2, '张家界', '12345565555', '20000101', '960455454', '女');
INSERT INTO `customer_demo` VALUES (23, 'test0323', '123', '李志伟', 2, '张家界', '12345565555', '20000101', '960455454', '女');
INSERT INTO `customer_demo` VALUES (12, 'test032311', '123', '李志伟111', 2, '张家界', '12345565555', '20000101', '960455454', '女');
INSERT INTO `customer_demo` VALUES (122, 'test0323', '123', '李志伟', 2, '张家界', '12345565555', '20000101', '960455454', '女');
INSERT INTO `customer_demo` VALUES (123, 'admin2', '123', '姓名姓名姓名', 0, '未央区尚稷路西安交通大学城市学院', '18391563384', NULL, '123', '男');
INSERT INTO `customer_demo` VALUES (12333, 'demo', '123', 'ybq', 2, '111', '11111111111', '20190122', '123', '男');
INSERT INTO `customer_demo` VALUES (1233333, 'demo2', '123', 'ybqq', 2, '111', '11111', '111', '123', '男');
INSERT INTO `customer_demo` VALUES (563632, '6c974e11', 'Te734', '6c974f 6c974f', 2, '6c974f 9560, 6c974f, 6c974f, 6c9750, 666098', '+516227636', NULL, '6c9750@6c9750.com', 'Male');
INSERT INTO `customer_demo` VALUES (264680, '6c975563', 'Zi688', '6c9755 6c9755', 2, '6c9755 3250, 6c9755, 6c9755, 6c9755, 664271', '+411707654', NULL, '6c9755@6c9755.com', 'Female');
INSERT INTO `customer_demo` VALUES (689906, '6c975620', 'Bi550', '6c9756 6c9756', 2, '6c9756 4945, 6c9756, 6c9756, 6c9756, 970219', '+430758803', NULL, '6c9756@6c9756.com', 'Female');
INSERT INTO `customer_demo` VALUES (578731, '6c975698', 'Wu422', '6c9756 6c9756', 2, '6c9756 3930, 6c9756, 6c9756, 6c9756, 891066', '+348699343', NULL, '6c9756@6c9756.com', 'Female');
INSERT INTO `customer_demo` VALUES (741984, '6c975707', 'Lb105', '6c9757 6c9757', 2, '6c9757 8344, 6c9757, 6c9757, 6c9757, 152745', '+334342270', NULL, '6c9757@6c9757.com', 'Female');
INSERT INTO `customer_demo` VALUES (493471, '6c975770', 'Rz866', '6c9757 6c9757', 2, '6c9757 3660, 6c9757, 6c9757, 6c9757, 276708', '+356950664', NULL, '6c9757@6c9757.com', 'Female');
INSERT INTO `customer_demo` VALUES (217349, '6c9757d8', 'Wx963', '6c9757 6c9757', 2, '6c9757 760, 6c9757, 6c9757, 6c9757, 500305', '+346130618', NULL, '6c9758@6c9758.com', 'Female');
INSERT INTO `customer_demo` VALUES (560754, '6c975840', 'Yg502', '6c9758 6c9758', 2, '6c9758 4415, 6c9758, 6c9758, 6c9758, 864428', '+997778789', NULL, '6c9758@6c9758.com', 'Male');
INSERT INTO `customer_demo` VALUES (981347, '6c9758b9', 'Sq102', '6c9758 6c9758', 2, '6c9758 1267, 6c9758, 6c9758, 6c9758, 626426', '+776753894', NULL, '6c9758@6c9758.com', 'Female');
INSERT INTO `customer_demo` VALUES (231827, '6c9759bf', 'Ca824', '6c9759 6c9759', 2, '6c9759 9758, 6c9759, 6c9759, 6c9759, 465771', '+461242162', NULL, '6c9759@6c9759.com', 'Female');
INSERT INTO `customer_demo` VALUES (859412, '6c975a4e', 'Kk934', '6c975a 6c975a', 2, '6c975a 3788, 6c975a, 6c975a, 6c975a, 111451', '+478732540', NULL, '6c975a@6c975a.com', 'Female');
INSERT INTO `customer_demo` VALUES (627523, '6c975abb', 'Qj893', '6c975a 6c975a', 2, '6c975a 3609, 6c975a, 6c975a, 6c975a, 159498', '+743173622', NULL, '6c975a@6c975a.com', 'Male');
INSERT INTO `customer_demo` VALUES (396586, '6c975b21', 'Jv151', '6c975b 6c975b', 2, '6c975b 7951, 6c975b, 6c975b, 6c975b, 805607', '+678267305', NULL, '6c975b@6c975b.com', 'Female');
INSERT INTO `customer_demo` VALUES (146184, '6c975b88', 'Wf418', '6c975b 6c975b', 2, '6c975b 1923, 6c975b, 6c975b, 6c975b, 900295', '+931896822', NULL, '6c975b@6c975b.com', 'Female');
INSERT INTO `customer_demo` VALUES (847737, '6c975bee', 'Km241', '6c975b 6c975b', 2, '6c975c 3878, 6c975c, 6c975c, 6c975c, 466769', '+253211335', NULL, '6c975c@6c975c.com', 'Male');
INSERT INTO `customer_demo` VALUES (769256, '6c975c54', 'Jp897', '6c975c 6c975c', 2, '6c975c 6433, 6c975c, 6c975c, 6c975c, 556704', '+868194112', NULL, '6c975c@6c975c.com', 'Female');
INSERT INTO `customer_demo` VALUES (484754, '6c975cbd', 'Il252', '6c975c 6c975c', 2, '6c975c 5248, 6c975c, 6c975c, 6c975c, 116042', '+105172194', NULL, '6c975c@6c975c.com', 'Female');
INSERT INTO `customer_demo` VALUES (447219, '6c975d32', 'Xh757', '6c975d 6c975d', 2, '6c975d 8188, 6c975d, 6c975d, 6c975d, 901785', '+147073943', NULL, '6c975d@6c975d.com', 'Female');
INSERT INTO `customer_demo` VALUES (661527, '6c975d9b', 'Lj608', '6c975d 6c975d', 2, '6c975d 6756, 6c975d, 6c975d, 6c975d, 681963', '+444690253', NULL, '6c975d@6c975d.com', 'Female');
INSERT INTO `customer_demo` VALUES (276684, '6c975e14', 'Jh363', '6c975e 6c975e', 2, '6c975e 6121, 6c975e, 6c975e, 6c975e, 183898', '+174720655', NULL, '6c975e@6c975e.com', 'Female');
INSERT INTO `customer_demo` VALUES (161226, '6c975e7d', 'To529', '6c975e 6c975e', 2, '6c975e 7493, 6c975e, 6c975e, 6c975e, 315352', '+395941121', NULL, '6c975e@6c975e.com', 'Female');
INSERT INTO `customer_demo` VALUES (553450, '6c975ee3', 'Lp812', '6c975e 6c975e', 2, '6c975e 1207, 6c975f, 6c975f, 6c975f, 226950', '+795357859', NULL, '6c975f@6c975f.com', 'Male');
INSERT INTO `customer_demo` VALUES (634039, '6c975f66', 'Ki408', '6c975f 6c975f', 2, '6c975f 7508, 6c975f, 6c975f, 6c975f, 726546', '+442244129', NULL, '6c975f@6c975f.com', 'Female');
INSERT INTO `customer_demo` VALUES (520995, '6c976418', 'Em824', '6c9764 6c9764', 2, '6c9764 6295, 6c9764, 6c9764, 6c9764, 732399', '+796135812', NULL, '6c9764@6c9764.com', 'Female');
INSERT INTO `customer_demo` VALUES (127590, '6c976514', 'Dq709', '6c9765 6c9765', 2, '6c9765 5250, 6c9765, 6c9765, 6c9765, 592272', '+447566173', NULL, '6c9765@6c9765.com', 'Male');
INSERT INTO `customer_demo` VALUES (650782, '6c9765b9', 'Pd970', '6c9765 6c9765', 2, '6c9765 3797, 6c9765, 6c9765, 6c9765, 997413', '+862989018', NULL, '6c9765@6c9765.com', 'Male');
INSERT INTO `customer_demo` VALUES (720678, '6c97662a', 'Sm317', '6c9766 6c9766', 2, '6c9766 7863, 6c9766, 6c9766, 6c9766, 207839', '+712205753', NULL, '6c9766@6c9766.com', 'Female');
INSERT INTO `customer_demo` VALUES (862700, '6c976693', 'Xz265', '6c9766 6c9766', 2, '6c9766 9814, 6c9766, 6c9766, 6c9766, 355409', '+849467735', NULL, '6c9766@6c9766.com', 'Male');
INSERT INTO `customer_demo` VALUES (990264, '6c976718', 'Qh584', '6c9767 6c9767', 2, '6c9767 7932, 6c9767, 6c9767, 6c9767, 350847', '+436939503', NULL, '6c9767@6c9767.com', 'Female');
INSERT INTO `customer_demo` VALUES (976228, '6c976782', 'Kd472', '6c9767 6c9767', 2, '6c9767 6841, 6c9767, 6c9767, 6c9767, 178665', '+856679464', NULL, '6c9767@6c9767.com', 'Female');
INSERT INTO `customer_demo` VALUES (834970, '6c9767e7', 'Cy556', '6c9767 6c9767', 2, '6c9767 6860, 6c9768, 6c9768, 6c9768, 910150', '+543228607', NULL, '6c9768@6c9768.com', 'Female');
INSERT INTO `customer_demo` VALUES (263998, '6c97684b', 'Sa103', '6c9768 6c9768', 2, '6c9768 9281, 6c9768, 6c9768, 6c9768, 629854', '+428454018', NULL, '6c9768@6c9768.com', 'Female');
INSERT INTO `customer_demo` VALUES (622955, '6c9768b1', 'Ct530', '6c9768 6c9768', 2, '6c9768 1273, 6c9768, 6c9768, 6c9768, 200291', '+657416740', NULL, '6c9768@6c9768.com', 'Male');
INSERT INTO `customer_demo` VALUES (659234, '6c976a3d', 'Qg371', '6c976a 6c976a', 2, '6c976a 8137, 6c976a, 6c976a, 6c976a, 163093', '+436789398', NULL, '6c976a@6c976a.com', 'Male');
INSERT INTO `customer_demo` VALUES (807598, '6c976acf', 'Uo544', '6c976a 6c976a', 2, '6c976a 7594, 6c976a, 6c976a, 6c976a, 315224', '+367897149', NULL, '6c976a@6c976b.com', 'Female');
INSERT INTO `customer_demo` VALUES (838201, '6c976b39', 'Mx196', '6c976b 6c976b', 2, '6c976b 8183, 6c976b, 6c976b, 6c976b, 771044', '+460273927', NULL, '6c976b@6c976b.com', 'Female');
INSERT INTO `customer_demo` VALUES (316921, '6c976ba0', 'Dz517', '6c976b 6c976b', 2, '6c976b 3885, 6c976b, 6c976b, 6c976b, 551518', '+632744951', NULL, '6c976b@6c976b.com', 'Male');
INSERT INTO `customer_demo` VALUES (774894, '6c976c05', 'Vx189', '6c976c 6c976c', 2, '6c976c 7372, 6c976c, 6c976c, 6c976c, 387218', '+751969124', NULL, '6c976c@6c976c.com', 'Male');
INSERT INTO `customer_demo` VALUES (215865, '6c976c6b', 'Gy859', '6c976c 6c976c', 2, '6c976c 4423, 6c976c, 6c976c, 6c976c, 678700', '+159917884', NULL, '6c976c@6c976c.com', 'Male');
INSERT INTO `customer_demo` VALUES (355735, '6c976ccf', 'Nu466', '6c976c 6c976c', 2, '6c976c 6364, 6c976c, 6c976c, 6c976c, 961004', '+906083202', NULL, '6c976c@6c976d.com', 'Female');
INSERT INTO `customer_demo` VALUES (360265, '6c976d36', 'Rl268', '6c976d 6c976d', 2, '6c976d 6369, 6c976d, 6c976d, 6c976d, 621945', '+279016906', NULL, '6c976d@6c976d.com', 'Male');
INSERT INTO `customer_demo` VALUES (142101, '6c976d9f', 'Wc954', '6c976d 6c976d', 2, '6c976d 4531, 6c976d, 6c976d, 6c976d, 416451', '+750435607', NULL, '6c976d@6c976d.com', 'Male');
INSERT INTO `customer_demo` VALUES (687491, '6c976e04', 'Ex979', '6c976e 6c976e', 2, '6c976e 1916, 6c976e, 6c976e, 6c976e, 26413', '+601415263', NULL, '6c976e@6c976e.com', 'Female');
INSERT INTO `customer_demo` VALUES (874551, '6c976e6b', 'Ei222', '6c976e 6c976e', 2, '6c976e 6668, 6c976e, 6c976e, 6c976e, 926821', '+670095337', NULL, '6c976e@6c976e.com', 'Male');
INSERT INTO `customer_demo` VALUES (130009, '6c976ecf', 'Ay678', '6c976e 6c976e', 2, '6c976e 4188, 6c976e, 6c976e, 6c976e, 164296', '+608445098', NULL, '6c976e@6c976f.com', 'Male');
INSERT INTO `customer_demo` VALUES (967784, '6c976f34', 'Vg730', '6c976f 6c976f', 2, '6c976f 7955, 6c976f, 6c976f, 6c976f, 876630', '+996850679', NULL, '6c976f@6c976f.com', 'Male');
INSERT INTO `customer_demo` VALUES (796196, '6c976f98', 'Vs293', '6c976f 6c976f', 2, '6c976f 8886, 6c976f, 6c976f, 6c976f, 797728', '+390530114', NULL, '6c976f@6c976f.com', 'Male');
INSERT INTO `customer_demo` VALUES (222322, '6c976ffc', 'Ar400', '6c9770 6c9770', 2, '6c9770 6410, 6c9770, 6c9770, 6c9770, 201785', '+177271418', NULL, '6c9770@6c9770.com', 'Female');
INSERT INTO `customer_demo` VALUES (875865, '6c977062', 'Vp565', '6c9770 6c9770', 2, '6c9770 7681, 6c9770, 6c9770, 6c9770, 288059', '+222128002', NULL, '6c9770@6c9770.com', 'Female');
INSERT INTO `customer_demo` VALUES (698017, '6c9770c7', 'Wk441', '6c9770 6c9770', 2, '6c9770 6869, 6c9770, 6c9770, 6c9770, 296134', '+477894893', NULL, '6c9770@6c9770.com', 'Male');
INSERT INTO `customer_demo` VALUES (815870, '6c977139', 'Ii673', '6c9771 6c9771', 2, '6c9771 1849, 6c9771, 6c9771, 6c9771, 12900', '+558625392', NULL, '6c9771@6c9771.com', 'Female');
INSERT INTO `customer_demo` VALUES (115602, '6c9771a0', 'Ot134', '6c9771 6c9771', 2, '6c9771 9634, 6c9771, 6c9771, 6c9771, 701690', '+656200980', NULL, '6c9771@6c9771.com', 'Female');
INSERT INTO `customer_demo` VALUES (163601, '6c977205', 'Ku737', '6c9772 6c9772', 2, '6c9772 1970, 6c9772, 6c9772, 6c9772, 861895', '+746422684', NULL, '6c9772@6c9772.com', 'Male');
INSERT INTO `customer_demo` VALUES (885713, '6c977269', 'Jd613', '6c9772 6c9772', 2, '6c9772 4811, 6c9772, 6c9772, 6c9772, 695426', '+130383923', NULL, '6c9772@6c9772.com', 'Male');
INSERT INTO `customer_demo` VALUES (380189, '6c9772cc', 'Ip216', '6c9772 6c9772', 2, '6c9772 8123, 6c9772, 6c9772, 6c9772, 674052', '+939886609', NULL, '6c9772@6c9772.com', 'Female');
INSERT INTO `customer_demo` VALUES (477792, '6c977331', 'Eo443', '6c9773 6c9773', 2, '6c9773 1803, 6c9773, 6c9773, 6c9773, 755379', '+312267744', NULL, '6c9773@6c9773.com', 'Female');
INSERT INTO `customer_demo` VALUES (872268, '6c977450', 'Oe325', '6c9774 6c9774', 2, '6c9774 7117, 6c9774, 6c9774, 6c9774, 806518', '+907492865', NULL, '6c9774@6c9774.com', 'Male');
INSERT INTO `customer_demo` VALUES (676839, '6c9774d3', 'Ac548', '6c9774 6c9774', 2, '6c9774 1848, 6c9774, 6c9774, 6c9774, 428419', '+628713138', NULL, '6c9775@6c9775.com', 'Female');
INSERT INTO `customer_demo` VALUES (548032, '6c97753e', 'Ne331', '6c9775 6c9775', 2, '6c9775 7748, 6c9775, 6c9775, 6c9775, 101141', '+262925442', NULL, '6c9775@6c9775.com', 'Female');
INSERT INTO `customer_demo` VALUES (518948, '6c9775a4', 'Nf558', '6c9775 6c9775', 2, '6c9775 8994, 6c9775, 6c9775, 6c9775, 970260', '+237622222', NULL, '6c9775@6c9775.com', 'Female');
INSERT INTO `customer_demo` VALUES (829178, '6c977608', 'Ma656', '6c9776 6c9776', 2, '6c9776 417, 6c9776, 6c9776, 6c9776, 351995', '+671319991', NULL, '6c9776@6c9776.com', 'Male');
INSERT INTO `customer_demo` VALUES (717105, '6c977673', 'Bi414', '6c9776 6c9776', 2, '6c9776 8060, 6c9776, 6c9776, 6c9776, 980413', '+535496565', NULL, '6c9776@6c9776.com', 'Male');
INSERT INTO `customer_demo` VALUES (945344, '6c9776d7', 'Gm703', '6c9776 6c9776', 2, '6c9776 8793, 6c9776, 6c9776, 6c9776, 384828', '+357578995', NULL, '6c9777@6c9777.com', 'Male');
INSERT INTO `customer_demo` VALUES (571551, '6c97773a', 'Uj572', '6c9777 6c9777', 2, '6c9777 4891, 6c9777, 6c9777, 6c9777, 869845', '+893514954', NULL, '6c9777@6c9777.com', 'Female');
INSERT INTO `customer_demo` VALUES (414419, '6c97779f', 'Js516', '6c9777 6c9777', 2, '6c9777 2052, 6c9777, 6c9777, 6c9777, 638418', '+618704585', NULL, '6c9777@6c9777.com', 'Female');
INSERT INTO `customer_demo` VALUES (192857, '6c977803', 'Qu115', '6c9778 6c9778', 2, '6c9778 7637, 6c9778, 6c9778, 6c9778, 768741', '+597119541', NULL, '6c9778@6c9778.com', 'Male');
INSERT INTO `customer_demo` VALUES (658622, '6c977992', 'Tv909', '6c9779 6c9779', 2, '6c9779 306, 6c9779, 6c9779, 6c9779, 455222', '+265838107', NULL, '6c9779@6c9779.com', 'Female');
INSERT INTO `customer_demo` VALUES (302930, '6c977a22', 'Lq772', '6c977a 6c977a', 2, '6c977a 8591, 6c977a, 6c977a, 6c977a, 54060', '+723518312', NULL, '6c977a@6c977a.com', 'Male');
INSERT INTO `customer_demo` VALUES (487592, '6c977a8b', 'Gy993', '6c977a 6c977a', 2, '6c977a 1233, 6c977a, 6c977a, 6c977a, 637375', '+835252898', NULL, '6c977a@6c977a.com', 'Male');
INSERT INTO `customer_demo` VALUES (470989, '6c977af2', 'Om790', '6c977a 6c977b', 2, '6c977b 4000, 6c977b, 6c977b, 6c977b, 697056', '+356693272', NULL, '6c977b@6c977b.com', 'Male');
INSERT INTO `customer_demo` VALUES (836985, '6c977b58', 'Cz720', '6c977b 6c977b', 2, '6c977b 4715, 6c977b, 6c977b, 6c977b, 289903', '+131344532', NULL, '6c977b@6c977b.com', 'Male');
INSERT INTO `customer_demo` VALUES (475880, '6c977bbf', 'Eq625', '6c977b 6c977b', 2, '6c977b 555, 6c977b, 6c977b, 6c977b, 525255', '+513609614', NULL, '6c977b@6c977b.com', 'Female');
INSERT INTO `customer_demo` VALUES (308457, '6c977c24', 'Zg412', '6c977c 6c977c', 2, '6c977c 9443, 6c977c, 6c977c, 6c977c, 678674', '+604315526', NULL, '6c977c@6c977c.com', 'Female');
INSERT INTO `customer_demo` VALUES (232837, '6c977c8b', 'Lt535', '6c977c 6c977c', 2, '6c977c 1341, 6c977c, 6c977c, 6c977c, 220209', '+728686118', NULL, '6c977c@6c977c.com', 'Female');
INSERT INTO `customer_demo` VALUES (158264, '6c977cf6', 'Vy310', '6c977d 6c977d', 2, '6c977d 3376, 6c977d, 6c977d, 6c977d, 988141', '+934860362', NULL, '6c977d@6c977d.com', 'Female');
INSERT INTO `customer_demo` VALUES (627017, '6c977d5e', 'Xu249', '6c977d 6c977d', 2, '6c977d 4987, 6c977d, 6c977d, 6c977d, 995445', '+532814345', NULL, '6c977d@6c977d.com', 'Male');
INSERT INTO `customer_demo` VALUES (683397, '6c977dc2', 'Zz982', '6c977d 6c977d', 2, '6c977d 9383, 6c977d, 6c977d, 6c977d, 750409', '+943235626', NULL, '6c977d@6c977d.com', 'Male');
INSERT INTO `customer_demo` VALUES (420654, '6c977e28', 'Mi317', '6c977e 6c977e', 2, '6c977e 1966, 6c977e, 6c977e, 6c977e, 258437', '+732141817', NULL, '6c977e@6c977e.com', 'Female');
INSERT INTO `customer_demo` VALUES (618214, '6c977e8d', 'Rq177', '6c977e 6c977e', 2, '6c977e 5725, 6c977e, 6c977e, 6c977e, 605734', '+379847613', NULL, '6c977e@6c977e.com', 'Female');
INSERT INTO `customer_demo` VALUES (779228, '6c977ef1', 'Oo118', '6c977e 6c977f', 2, '6c977f 4829, 6c977f, 6c977f, 6c977f, 351324', '+377128602', NULL, '6c977f@6c977f.com', 'Male');
INSERT INTO `customer_demo` VALUES (220958, '41c43cb2', 'Fs946', '41c43c 41c43c', 2, '41c43d 5332, 41c43d, 41c43d, 41c43d, 844517', '+660448295', NULL, '41c43d@41c43d.com', 'Female');
INSERT INTO `customer_demo` VALUES (128871, '41c44189', 'Ka787', '41c441 41c441', 2, '41c441 8069, 41c441, 41c441, 41c441, 741569', '+358266311', NULL, '41c441@41c441.com', 'Male');
INSERT INTO `customer_demo` VALUES (270664, '41c44272', 'Ia233', '41c442 41c442', 2, '41c442 6783, 41c442, 41c442, 41c442, 948334', '+735918631', NULL, '41c442@41c442.com', 'Female');
INSERT INTO `customer_demo` VALUES (387690, '41c44304', 'Ns970', '41c443 41c443', 2, '41c443 6944, 41c443, 41c443, 41c443, 570026', '+790007867', NULL, '41c443@41c443.com', 'Male');
INSERT INTO `customer_demo` VALUES (384815, '41c44388', 'Fc933', '41c443 41c443', 2, '41c443 2928, 41c443, 41c443, 41c443, 685761', '+595200361', NULL, '41c443@41c443.com', 'Female');
INSERT INTO `customer_demo` VALUES (836621, '41c44407', 'Ap965', '41c444 41c444', 2, '41c444 127, 41c444, 41c444, 41c444, 177914', '+866301682', NULL, '41c444@41c444.com', 'Female');
INSERT INTO `customer_demo` VALUES (156793, '41c4448b', 'Dn320', '41c444 41c444', 2, '41c444 6152, 41c444, 41c444, 41c444, 342305', '+879243789', NULL, '41c444@41c444.com', 'Male');
INSERT INTO `customer_demo` VALUES (922242, '41c4450a', 'Ro861', '41c445 41c445', 2, '41c445 5320, 41c445, 41c445, 41c445, 122056', '+112795026', NULL, '41c445@41c445.com', 'Female');
INSERT INTO `customer_demo` VALUES (533722, '41c4458b', 'Ha331', '41c445 41c445', 2, '41c445 2025, 41c445, 41c445, 41c445, 240170', '+633825906', NULL, '41c445@41c445.com', 'Male');
INSERT INTO `customer_demo` VALUES (501875, '41c448fe', 'Md313', '41c449 41c449', 2, '41c449 7508, 41c449, 41c449, 41c449, 41442', '+959143499', NULL, '41c449@41c449.com', 'Female');
INSERT INTO `customer_demo` VALUES (441680, '41c449ae', 'Yq327', '41c449 41c449', 2, '41c449 3976, 41c449, 41c449, 41c449, 230516', '+963593588', NULL, '41c449@41c449.com', 'Male');
INSERT INTO `customer_demo` VALUES (687087, '41c44a2f', 'Yt965', '41c44a 41c44a', 2, '41c44a 5335, 41c44a, 41c44a, 41c44a, 782887', '+382474719', NULL, '41c44a@41c44a.com', 'Male');
INSERT INTO `customer_demo` VALUES (245458, '41c44aa9', 'Dg812', '41c44a 41c44a', 2, '41c44a 2202, 41c44a, 41c44a, 41c44a, 726115', '+972909047', NULL, '41c44a@41c44a.com', 'Female');
INSERT INTO `customer_demo` VALUES (501446, '41c44b2f', 'Ft171', '41c44b 41c44b', 2, '41c44b 1575, 41c44b, 41c44b, 41c44b, 550445', '+351721536', NULL, '41c44b@41c44b.com', 'Female');
INSERT INTO `customer_demo` VALUES (906860, '41c44ba8', 'Gn873', '41c44b 41c44b', 2, '41c44b 7449, 41c44b, 41c44b, 41c44b, 148084', '+555009850', NULL, '41c44b@41c44b.com', 'Male');
INSERT INTO `customer_demo` VALUES (911074, '41c44c21', 'Go187', '41c44c 41c44c', 2, '41c44c 7683, 41c44c, 41c44c, 41c44c, 549964', '+500374932', NULL, '41c44c@41c44c.com', 'Female');
INSERT INTO `customer_demo` VALUES (583722, '41c44c9a', 'Zf233', '41c44c 41c44c', 2, '41c44c 1180, 41c44c, 41c44c, 41c44c, 144886', '+433143741', NULL, '41c44c@41c44c.com', 'Male');
INSERT INTO `customer_demo` VALUES (973193, '41c44d29', 'Pc734', '41c44d 41c44d', 2, '41c44d 2183, 41c44d, 41c44d, 41c44d, 975863', '+301912897', NULL, '41c44d@41c44d.com', 'Male');
INSERT INTO `customer_demo` VALUES (367921, '41c44da2', 'Xq520', '41c44d 41c44d', 2, '41c44d 4238, 41c44d, 41c44d, 41c44d, 718204', '+387606134', NULL, '41c44d@41c44d.com', 'Male');
INSERT INTO `customer_demo` VALUES (331574, '41c44e22', 'Ya273', '41c44e 41c44e', 2, '41c44e 9261, 41c44e, 41c44e, 41c44e, 52241', '+534418803', NULL, '41c44e@41c44e.com', 'Male');
INSERT INTO `customer_demo` VALUES (851959, '41c44e9c', 'Kn487', '41c44e 41c44e', 2, '41c44e 5601, 41c44e, 41c44e, 41c44e, 509679', '+881187698', NULL, '41c44e@41c44e.com', 'Female');
INSERT INTO `customer_demo` VALUES (505460, '41c44f15', 'Vt351', '41c44f 41c44f', 2, '41c44f 1542, 41c44f, 41c44f, 41c44f, 932651', '+280422089', NULL, '41c44f@41c44f.com', 'Male');
INSERT INTO `customer_demo` VALUES (478495, '41c44f8b', 'Me516', '41c44f 41c44f', 2, '41c44f 7537, 41c44f, 41c44f, 41c44f, 381277', '+680609192', NULL, '41c44f@41c44f.com', 'Male');
INSERT INTO `customer_demo` VALUES (526155, '41c45002', 'De627', '41c450 41c450', 2, '41c450 3584, 41c450, 41c450, 41c450, 34142', '+185882876', NULL, '41c450@41c450.com', 'Male');
INSERT INTO `customer_demo` VALUES (628498, '41c4507a', 'Vh150', '41c450 41c450', 2, '41c450 3838, 41c450, 41c450, 41c450, 752043', '+647705945', NULL, '41c450@41c450.com', 'Female');
INSERT INTO `customer_demo` VALUES (196944, '41c45183', 'Eo380', '41c451 41c451', 2, '41c451 8518, 41c451, 41c451, 41c451, 323119', '+153944622', NULL, '41c451@41c451.com', 'Male');
INSERT INTO `customer_demo` VALUES (524672, '41c45237', 'Jl122', '41c452 41c452', 2, '41c452 8447, 41c452, 41c452, 41c452, 150462', '+296178544', NULL, '41c452@41c452.com', 'Female');
INSERT INTO `customer_demo` VALUES (584685, '41c452b5', 'Uh118', '41c452 41c452', 2, '41c452 2919, 41c452, 41c452, 41c452, 397608', '+201059597', NULL, '41c452@41c452.com', 'Male');
INSERT INTO `customer_demo` VALUES (555596, '41c45336', 'Lp785', '41c453 41c453', 2, '41c453 9874, 41c453, 41c453, 41c453, 651272', '+364563651', NULL, '41c453@41c453.com', 'Female');
INSERT INTO `customer_demo` VALUES (728215, '41c453ae', 'Yq331', '41c453 41c453', 2, '41c453 4348, 41c453, 41c453, 41c453, 403315', '+740821131', NULL, '41c453@41c453.com', 'Male');
INSERT INTO `customer_demo` VALUES (653302, '41c45426', 'Ah363', '41c454 41c454', 2, '41c454 6468, 41c454, 41c454, 41c454, 355510', '+853240588', NULL, '41c454@41c454.com', 'Male');
INSERT INTO `customer_demo` VALUES (171907, '41c4549d', 'Bz813', '41c454 41c454', 2, '41c454 79, 41c454, 41c454, 41c454, 660920', '+352627846', NULL, '41c454@41c454.com', 'Male');
INSERT INTO `customer_demo` VALUES (335385, '41c45524', 'Bl170', '41c455 41c455', 2, '41c455 624, 41c455, 41c455, 41c455, 77298', '+279321446', NULL, '41c455@41c455.com', 'Female');
INSERT INTO `customer_demo` VALUES (301540, '41c4569f', 'Vl844', '41c456 41c456', 2, '41c456 7537, 41c456, 41c456, 41c456, 285708', '+250580368', NULL, '41c456@41c456.com', 'Female');
INSERT INTO `customer_demo` VALUES (455708, '41c4575c', 'Aa913', '41c457 41c457', 2, '41c457 5111, 41c457, 41c457, 41c457, 842395', '+710801386', NULL, '41c457@41c457.com', 'Female');
INSERT INTO `customer_demo` VALUES (365288, '41c457db', 'Wm852', '41c457 41c457', 2, '41c457 7051, 41c457, 41c457, 41c457, 15896', '+967763269', NULL, '41c458@41c458.com', 'Female');
INSERT INTO `customer_demo` VALUES (976187, '41c45853', 'Ov508', '41c458 41c458', 2, '41c458 8115, 41c458, 41c458, 41c458, 695483', '+138467261', NULL, '41c458@41c458.com', 'Male');
INSERT INTO `customer_demo` VALUES (557246, '41c458ca', 'Eg879', '41c458 41c458', 2, '41c458 5254, 41c458, 41c458, 41c458, 28910', '+611450967', NULL, '41c458@41c458.com', 'Female');
INSERT INTO `customer_demo` VALUES (161628, '41c45941', 'Ce727', '41c459 41c459', 2, '41c459 9280, 41c459, 41c459, 41c459, 547769', '+959146818', NULL, '41c459@41c459.com', 'Male');
INSERT INTO `customer_demo` VALUES (806342, '41c459b7', 'Ni996', '41c459 41c459', 2, '41c459 204, 41c459, 41c459, 41c459, 113481', '+555535224', NULL, '41c459@41c459.com', 'Male');
INSERT INTO `customer_demo` VALUES (489771, '41c45a30', 'Pr624', '41c45a 41c45a', 2, '41c45a 8924, 41c45a, 41c45a, 41c45a, 714954', '+907757273', NULL, '41c45a@41c45a.com', 'Male');
INSERT INTO `customer_demo` VALUES (118780, '41c45ab2', 'Bi429', '41c45a 41c45a', 2, '41c45a 8712, 41c45a, 41c45a, 41c45a, 259476', '+715272537', NULL, '41c45a@41c45a.com', 'Female');
INSERT INTO `customer_demo` VALUES (233069, '41c45be9', 'Vr840', '41c45b 41c45b', 2, '41c45c 1432, 41c45c, 41c45c, 41c45c, 248681', '+832213454', NULL, '41c45c@41c45c.com', 'Male');
INSERT INTO `customer_demo` VALUES (251498, '41c45c86', 'Ww776', '41c45c 41c45c', 2, '41c45c 1321, 41c45c, 41c45c, 41c45c, 404164', '+662060756', NULL, '41c45c@41c45c.com', 'Female');
INSERT INTO `customer_demo` VALUES (709113, '41c45d05', 'Qg307', '41c45d 41c45d', 2, '41c45d 4394, 41c45d, 41c45d, 41c45d, 504240', '+282647062', NULL, '41c45d@41c45d.com', 'Female');
INSERT INTO `customer_demo` VALUES (910987, '41c45d7f', 'Zh525', '41c45d 41c45d', 2, '41c45d 4831, 41c45d, 41c45d, 41c45d, 996095', '+577862442', NULL, '41c45d@41c45d.com', 'Female');
INSERT INTO `customer_demo` VALUES (765681, '41c45df7', 'Sh349', '41c45e 41c45e', 2, '41c45e 5617, 41c45e, 41c45e, 41c45e, 977126', '+280457333', NULL, '41c45e@41c45e.com', 'Male');
INSERT INTO `customer_demo` VALUES (778859, '41c45e6e', 'On964', '41c45e 41c45e', 2, '41c45e 2225, 41c45e, 41c45e, 41c45e, 230965', '+538352615', NULL, '41c45e@41c45e.com', 'Female');
INSERT INTO `customer_demo` VALUES (325726, '41c45ee6', 'Aj845', '41c45e 41c45e', 2, '41c45e 9970, 41c45f, 41c45f, 41c45f, 499603', '+556284360', NULL, '41c45f@41c45f.com', 'Male');
INSERT INTO `customer_demo` VALUES (693610, '41c45f5e', 'Ez348', '41c45f 41c45f', 2, '41c45f 4737, 41c45f, 41c45f, 41c45f, 540290', '+352255775', NULL, '41c45f@41c45f.com', 'Female');
INSERT INTO `customer_demo` VALUES (155706, '41c45fe7', 'Zq427', '41c45f 41c45f', 2, '41c45f 8589, 41c460, 41c460, 41c460, 203312', '+495624022', NULL, '41c460@41c460.com', 'Female');
INSERT INTO `customer_demo` VALUES (659010, '41c46064', 'Iv280', '41c460 41c460', 2, '41c460 4665, 41c460, 41c460, 41c460, 731588', '+332509495', NULL, '41c460@41c460.com', 'Male');
INSERT INTO `customer_demo` VALUES (738767, '41c460db', 'Ge123', '41c460 41c460', 2, '41c460 6522, 41c460, 41c460, 41c460, 181767', '+956966594', NULL, '41c461@41c461.com', 'Male');
INSERT INTO `customer_demo` VALUES (299403, '41c46150', 'Lq835', '41c461 41c461', 2, '41c461 1652, 41c461, 41c461, 41c461, 375303', '+442607012', NULL, '41c461@41c461.com', 'Female');
INSERT INTO `customer_demo` VALUES (770752, '41c461c8', 'Kt540', '41c461 41c461', 2, '41c461 2434, 41c461, 41c461, 41c461, 749471', '+115330158', NULL, '41c461@41c461.com', 'Female');
INSERT INTO `customer_demo` VALUES (219398, '41c4623f', 'Dj439', '41c462 41c462', 2, '41c462 7852, 41c462, 41c462, 41c462, 794018', '+652841041', NULL, '41c462@41c462.com', 'Female');
INSERT INTO `customer_demo` VALUES (643249, '41c462b7', 'Yy865', '41c462 41c462', 2, '41c462 4311, 41c462, 41c462, 41c462, 604772', '+757334945', NULL, '41c462@41c462.com', 'Female');
INSERT INTO `customer_demo` VALUES (996940, '41c4632f', 'Mj459', '41c463 41c463', 2, '41c463 9097, 41c463, 41c463, 41c463, 351105', '+123703944', NULL, '41c463@41c463.com', 'Male');
INSERT INTO `customer_demo` VALUES (381560, '41c463a6', 'Is592', '41c463 41c463', 2, '41c463 6175, 41c463, 41c463, 41c463, 444721', '+433789506', NULL, '41c463@41c463.com', 'Female');
INSERT INTO `customer_demo` VALUES (539627, '41c4641d', 'Wy163', '41c464 41c464', 2, '41c464 5233, 41c464, 41c464, 41c464, 404918', '+509195630', NULL, '41c464@41c464.com', 'Male');
INSERT INTO `customer_demo` VALUES (935907, '41c46494', 'Mo433', '41c464 41c464', 2, '41c464 1855, 41c464, 41c464, 41c464, 817337', '+577109142', NULL, '41c464@41c464.com', 'Male');
INSERT INTO `customer_demo` VALUES (462340, '41c4650f', 'Kw225', '41c465 41c465', 2, '41c465 647, 41c465, 41c465, 41c465, 903797', '+392338161', NULL, '41c465@41c465.com', 'Female');
INSERT INTO `customer_demo` VALUES (630175, '41c46586', 'Fg751', '41c465 41c465', 2, '41c465 8131, 41c465, 41c465, 41c465, 893109', '+123602918', NULL, '41c465@41c465.com', 'Male');
INSERT INTO `customer_demo` VALUES (262280, '41c465fd', 'Oe379', '41c466 41c466', 2, '41c466 9851, 41c466, 41c466, 41c466, 993002', '+108513931', NULL, '41c466@41c466.com', 'Male');
INSERT INTO `customer_demo` VALUES (381769, '41c46675', 'Jw311', '41c466 41c466', 2, '41c466 5855, 41c466, 41c466, 41c466, 222596', '+420595559', NULL, '41c466@41c466.com', 'Male');
INSERT INTO `customer_demo` VALUES (548043, '41c466ec', 'Dg834', '41c466 41c466', 2, '41c467 3216, 41c467, 41c467, 41c467, 160505', '+853705605', NULL, '41c467@41c467.com', 'Female');
INSERT INTO `customer_demo` VALUES (114703, '41c4679b', 'Zu976', '41c467 41c467', 2, '41c467 5468, 41c467, 41c467, 41c467, 813872', '+486067285', NULL, '41c467@41c467.com', 'Female');
INSERT INTO `customer_demo` VALUES (306197, '41c4681f', 'Am418', '41c468 41c468', 2, '41c468 2933, 41c468, 41c468, 41c468, 404390', '+227747805', NULL, '41c468@41c468.com', 'Male');
INSERT INTO `customer_demo` VALUES (151177, '41c46897', 'Uu667', '41c468 41c468', 2, '41c468 7442, 41c468, 41c468, 41c468, 829186', '+921994055', NULL, '41c468@41c468.com', 'Male');
INSERT INTO `customer_demo` VALUES (689848, '41c46910', 'Bg138', '41c469 41c469', 2, '41c469 5174, 41c469, 41c469, 41c469, 458293', '+765289963', NULL, '41c469@41c469.com', 'Male');
INSERT INTO `customer_demo` VALUES (449418, '41c46986', 'Zs716', '41c469 41c469', 2, '41c469 2563, 41c469, 41c469, 41c469, 225399', '+422064516', NULL, '41c469@41c469.com', 'Male');
INSERT INTO `customer_demo` VALUES (542524, '41c469fd', 'Dd324', '41c46a 41c46a', 2, '41c46a 8838, 41c46a, 41c46a, 41c46a, 670204', '+729511883', NULL, '41c46a@41c46a.com', 'Male');
INSERT INTO `customer_demo` VALUES (401502, '41c46a74', 'Fb734', '41c46a 41c46a', 2, '41c46a 3138, 41c46a, 41c46a, 41c46a, 455090', '+400485462', NULL, '41c46a@41c46a.com', 'Male');
INSERT INTO `customer_demo` VALUES (566955, '41c46aeb', 'Rw297', '41c46a 41c46a', 2, '41c46b 5392, 41c46b, 41c46b, 41c46b, 37127', '+611098487', NULL, '41c46b@41c46b.com', 'Female');
INSERT INTO `customer_demo` VALUES (942950, '41c46b64', 'Mr933', '41c46b 41c46b', 2, '41c46b 5784, 41c46b, 41c46b, 41c46b, 112826', '+845918524', NULL, '41c46b@41c46b.com', 'Female');
INSERT INTO `customer_demo` VALUES (587047, '41c46c7f', 'Hv322', '41c46c 41c46c', 2, '41c46c 7649, 41c46c, 41c46c, 41c46c, 84686', '+215624598', NULL, '41c46c@41c46c.com', 'Male');
INSERT INTO `customer_demo` VALUES (600478, '41c46d18', 'Qk280', '41c46d 41c46d', 2, '41c46d 7739, 41c46d, 41c46d, 41c46d, 268569', '+118822105', NULL, '41c46d@41c46d.com', 'Male');
INSERT INTO `customer_demo` VALUES (488395, '41c46d93', 'Ga345', '41c46d 41c46d', 2, '41c46d 3294, 41c46d, 41c46d, 41c46d, 829418', '+242833608', NULL, '41c46d@41c46d.com', 'Male');
INSERT INTO `customer_demo` VALUES (145189, '41c46e0a', 'In660', '41c46e 41c46e', 2, '41c46e 5357, 41c46e, 41c46e, 41c46e, 811106', '+503450542', NULL, '41c46e@41c46e.com', 'Female');
INSERT INTO `customer_demo` VALUES (725977, '41c46e83', 'Be768', '41c46e 41c46e', 2, '41c46e 1712, 41c46e, 41c46e, 41c46e, 628434', '+665592262', NULL, '41c46e@41c46e.com', 'Male');
INSERT INTO `customer_demo` VALUES (459168, 'ab71e678', 'Fy962', 'ab71e6 ab71e6', 2, 'ab71e6 121, ab71e6, ab71e6, ab71e7, 185524', '110326056346', '20180930', '705873063@qq.com', '男');
INSERT INTO `customer_demo` VALUES (420552, 'ab71eab4', 'Os888', 'ab71ea ab71ea', 2, 'ab71ea 2557, ab71ea, ab71ea, ab71ea, 649844', '111553706146', '19990115', '975022230@qq.com', '男');
INSERT INTO `customer_demo` VALUES (771731, 'ab71eb73', 'Il236', 'ab71eb ab71eb', 2, 'ab71eb 4672, ab71eb, ab71eb, ab71eb, 880686', '112995294611', '19950803', '681175302@qq.com', '男');
INSERT INTO `customer_demo` VALUES (866282, 'ab71ec03', 'Uj527', 'ab71ec ab71ec', 2, 'ab71ec 2784, ab71ec, ab71ec, ab71ec, 967373', '112995004229', '19840912', '981675611@qq.com', '女');
INSERT INTO `customer_demo` VALUES (890969, 'ab71ec8a', 'Nw906', 'ab71ec ab71ec', 2, 'ab71ec 8386, ab71ec, ab71ec, ab71ec, 503554', '112994906462', '20011110', '263208370@qq.com', '男');
INSERT INTO `customer_demo` VALUES (180293, 'ab71ed0e', 'Bb204', 'ab71ed ab71ed', 2, 'ab71ed 3941, ab71ed, ab71ed, ab71ed, 620956', '110233223189', '20120209', '308215013@qq.com', '男');
INSERT INTO `customer_demo` VALUES (655737, 'ab71ed90', 'Hq414', 'ab71ed ab71ed', 2, 'ab71ed 7943, ab71ed, ab71ed, ab71ed, 924852', '112276101670', '19981023', '197632647@qq.com', '女');
INSERT INTO `customer_demo` VALUES (225051, 'ab71ee23', 'Ar342', 'ab71ee ab71ee', 2, 'ab71ee 3586, ab71ee, ab71ee, ab71ee, 983487', '110475489804', '19911124', '892768647@qq.com', '男');
INSERT INTO `customer_demo` VALUES (900472, 'ab71eeb1', 'Nz344', 'ab71ee ab71ee', 2, 'ab71ee 4475, ab71ee, ab71ee, ab71ee, 421175', '110710451214', '20030509', '196062543@qq.com', '男');
INSERT INTO `customer_demo` VALUES (798841, 'ab71ef35', 'Qu181', 'ab71ef ab71ef', 2, 'ab71ef 727, ab71ef, ab71ef, ab71ef, 93322', '112255064216', '20210901', '966529918@qq.com', '女');
INSERT INTO `customer_demo` VALUES (753505, 'ab71efb8', 'Bd522', 'ab71ef ab71ef', 2, 'ab71ef 9524, ab71ef, ab71ef, ab71ef, 355175', '110244532372', '20021213', '493427670@qq.com', '女');
INSERT INTO `customer_demo` VALUES (454141, 'ab71f04f', 'To529', 'ab71f0 ab71f0', 2, 'ab71f0 7573, ab71f0, ab71f0, ab71f0, 356566', '111467442582', '20000602', '385531311@qq.com', '女');
INSERT INTO `customer_demo` VALUES (113993, 'ab71f0cf', 'Hl377', 'ab71f0 ab71f0', 2, 'ab71f0 2222, ab71f0, ab71f0, ab71f0, 185519', '112217094471', '20120526', '876744217@qq.com', '女');
INSERT INTO `customer_demo` VALUES (794177, 'ab71f14e', 'Vx924', 'ab71f1 ab71f1', 2, 'ab71f1 9190, ab71f1, ab71f1, ab71f1, 846391', '111575394270', '20160626', '999703116@qq.com', '男');
INSERT INTO `customer_demo` VALUES (309346, 'ab71f1cf', 'Lk856', 'ab71f1 ab71f1', 2, 'ab71f1 9341, ab71f1, ab71f1, ab71f1, 149879', '110159429534', '19920220', '593899304@qq.com', '女');
INSERT INTO `customer_demo` VALUES (264563, 'ab71f24f', 'Fn122', 'ab71f2 ab71f2', 2, 'ab71f2 5216, ab71f2, ab71f2, ab71f2, 531894', '112716117841', '20170616', '201361496@qq.com', '女');
INSERT INTO `customer_demo` VALUES (288469, 'ab71f2ea', 'Iz882', 'ab71f2 ab71f2', 2, 'ab71f3 4537, ab71f3, ab71f3, ab71f3, 659273', '110194852823', '20100616', '587852045@qq.com', '女');
INSERT INTO `customer_demo` VALUES (245202, 'ab71f36d', 'Ne398', 'ab71f3 ab71f3', 2, 'ab71f3 984, ab71f3, ab71f3, ab71f3, 497005', '112431363175', '19991127', '889953522@qq.com', '女');
INSERT INTO `customer_demo` VALUES (318198, 'ab71f3f1', 'Xs886', 'ab71f3 ab71f4', 2, 'ab71f4 2487, ab71f4, ab71f4, ab71f4, 621935', '111909347347', '20211120', '496715160@qq.com', '女');
INSERT INTO `customer_demo` VALUES (417941, 'ab71f470', 'Ot137', 'ab71f4 ab71f4', 2, 'ab71f4 9744, ab71f4, ab71f4, ab71f4, 746847', '110567668997', '20150511', '780589767@qq.com', '女');
INSERT INTO `customer_demo` VALUES (692734, 'ab71f4ee', 'Ns934', 'ab71f4 ab71f4', 2, 'ab71f5 5131, ab71f5, ab71f5, ab71f5, 784462', '111851232042', '20040517', '139238968@qq.com', '男');
INSERT INTO `customer_demo` VALUES (920898, 'ab71f56d', 'Iy715', 'ab71f5 ab71f5', 2, 'ab71f5 6069, ab71f5, ab71f5, ab71f5, 982719', '112721678362', '20021216', '882424656@qq.com', '男');
INSERT INTO `customer_demo` VALUES (834224, 'ab71f5ed', 'Qr555', 'ab71f5 ab71f5', 2, 'ab71f6 5027, ab71f6, ab71f6, ab71f6, 995318', '111595204513', '19950120', '869135953@qq.com', '女');
INSERT INTO `customer_demo` VALUES (899964, 'ab71f67f', 'Uf699', 'ab71f6 ab71f6', 2, 'ab71f6 7393, ab71f6, ab71f6, ab71f6, 698775', '112172219312', '19920616', '732822208@qq.com', '男');
INSERT INTO `customer_demo` VALUES (154650, 'ab71f70c', 'Pv390', 'ab71f7 ab71f7', 2, 'ab71f7 1380, ab71f7, ab71f7, ab71f7, 721660', '112417851052', '20140310', '723856513@qq.com', '男');
INSERT INTO `customer_demo` VALUES (255330, 'ab71f78e', 'Sb161', 'ab71f7 ab71f7', 2, 'ab71f7 2187, ab71f7, ab71f7, ab71f7, 889433', '110627400719', '19920621', '978152041@qq.com', '女');
INSERT INTO `customer_demo` VALUES (118703, 'ab71f80e', 'Ip155', 'ab71f8 ab71f8', 2, 'ab71f8 4661, ab71f8, ab71f8, ab71f8, 147255', '111986900161', '19900728', '236396732@qq.com', '女');
INSERT INTO `customer_demo` VALUES (904912, 'ab71f8ab', 'Mq780', 'ab71f8 ab71f8', 2, 'ab71f8 8947, ab71f8, ab71f8, ab71f8, 205193', '111974468449', '19840209', '400618405@qq.com', '女');
INSERT INTO `customer_demo` VALUES (426172, 'ab71f93e', 'Fw836', 'ab71f9 ab71f9', 2, 'ab71f9 4520, ab71f9, ab71f9, ab71f9, 805480', '110985971395', '20200906', '115569053@qq.com', '男');
INSERT INTO `customer_demo` VALUES (228390, 'ab71f9c0', 'Zo805', 'ab71f9 ab71f9', 2, 'ab71f9 2568, ab71f9, ab71f9, ab71f9, 931406', '110340263043', '20070126', '243850848@qq.com', '女');
INSERT INTO `customer_demo` VALUES (310731, 'ab71fa43', 'Oa481', 'ab71fa ab71fa', 2, 'ab71fa 877, ab71fa, ab71fa, ab71fa, 167650', '111275056229', '19961009', '448263605@qq.com', '男');
INSERT INTO `customer_demo` VALUES (224876, 'ab71fcea', 'Xd123', 'ab71fd ab71fd', 2, 'ab71fd 6706, ab71fd, ab71fd, ab71fd, 274459', '111919323329', '20221112', '200128212@qq.com', '男');
INSERT INTO `customer_demo` VALUES (857089, 'ab71fe30', 'Nz464', 'ab71fe ab71fe', 2, 'ab71fe 816, ab71fe, ab71fe, ab71fe, 192151', '110852520449', '19800516', '108818018@qq.com', '男');
INSERT INTO `customer_demo` VALUES (453694, 'ab71febb', 'Sj783', 'ab71fe ab71fe', 2, 'ab71fe 6584, ab71fe, ab71fe, ab71fe, 15513', '112693348125', '20000928', '446887239@qq.com', '女');
INSERT INTO `customer_demo` VALUES (260667, 'ab71ff3c', 'Hx765', 'ab71ff ab71ff', 2, 'ab71ff 9301, ab71ff, ab71ff, ab71ff, 431134', '111904038937', '20030824', '588515839@qq.com', '女');
INSERT INTO `customer_demo` VALUES (264512, 'ab71ffbc', 'Ap871', 'ab71ff ab71ff', 2, 'ab71ff 5244, ab71ff, ab71ff, ab71ff, 49546', '110977140901', '19891230', '696210442@qq.com', '女');
INSERT INTO `customer_demo` VALUES (790031, 'ab72003d', 'Zp174', 'ab7200 ab7200', 2, 'ab7200 5991, ab7200, ab7200, ab7200, 746952', '110188308401', '19991116', '501322777@qq.com', '男');
INSERT INTO `customer_demo` VALUES (765343, 'ab7200ba', 'Qa292', 'ab7200 ab7200', 2, 'ab7200 9717, ab7200, ab7200, ab7200, 216492', '112498402843', '19880817', '715617081@qq.com', '女');
INSERT INTO `customer_demo` VALUES (205705, 'ab720138', 'Rb388', 'ab7201 ab7201', 2, 'ab7201 3754, ab7201, ab7201, ab7201, 916241', '111635374205', '20020505', '923723036@qq.com', '男');
INSERT INTO `customer_demo` VALUES (115268, 'ab7201b7', 'Ac409', 'ab7201 ab7201', 2, 'ab7201 4644, ab7201, ab7201, ab7201, 290436', '112823630133', '19980621', '343708333@qq.com', '男');
INSERT INTO `customer_demo` VALUES (742081, 'ab720236', 'Gd851', 'ab7202 ab7202', 2, 'ab7202 8207, ab7202, ab7202, ab7202, 598793', '111404544236', '20170103', '871998965@qq.com', '男');
INSERT INTO `customer_demo` VALUES (851266, 'ab7202b3', 'Id742', 'ab7202 ab7202', 2, 'ab7202 1489, ab7202, ab7202, ab7202, 603303', '111291158636', '19811029', '127511014@qq.com', '男');
INSERT INTO `customer_demo` VALUES (318896, 'ab720330', 'Ki536', 'ab7203 ab7203', 2, 'ab7203 3858, ab7203, ab7203, ab7203, 474990', '112348064793', '20080428', '557489204@qq.com', '女');
INSERT INTO `customer_demo` VALUES (778641, 'ab7203ad', 'Ut416', 'ab7203 ab7203', 2, 'ab7203 5011, ab7203, ab7203, ab7203, 451482', '110738078855', '19970301', '732594509@qq.com', '男');
INSERT INTO `customer_demo` VALUES (116241, 'ab72042b', 'Aa137', 'ab7204 ab7204', 2, 'ab7204 1593, ab7204, ab7204, ab7204, 670520', '110376062915', '19951225', '668691098@qq.com', '女');
INSERT INTO `customer_demo` VALUES (411452, 'ab7204a9', 'Ux176', 'ab7204 ab7204', 2, 'ab7204 7613, ab7204, ab7204, ab7204, 551108', '111585387980', '20100804', '813564272@qq.com', '女');
INSERT INTO `customer_demo` VALUES (189450, 'ab7205a2', 'Kt579', 'ab7205 ab7205', 2, 'ab7205 4078, ab7205, ab7205, ab7205, 439629', '110076310265', '20030711', '371761719@qq.com', '女');
INSERT INTO `customer_demo` VALUES (211287, 'ab720624', 'Fq601', 'ab7206 ab7206', 2, 'ab7206 8912, ab7206, ab7206, ab7206, 784245', '112257520525', '20180618', '743214268@qq.com', '男');
INSERT INTO `customer_demo` VALUES (503640, 'ab7206a3', 'Hc626', 'ab7206 ab7206', 2, 'ab7206 6577, ab7206, ab7206, ab7206, 533652', '110915076713', '20170414', '238345514@qq.com', '男');
INSERT INTO `customer_demo` VALUES (422841, 'ab720721', 'Sl149', 'ab7207 ab7207', 2, 'ab7207 9813, ab7207, ab7207, ab7207, 740103', '110730455833', '20040509', '536585184@qq.com', '男');
INSERT INTO `customer_demo` VALUES (406740, 'ab7207a0', 'Qc702', 'ab7207 ab7207', 2, 'ab7207 184, ab7207, ab7207, ab7207, 83442', '111914142307', '20040908', '331786634@qq.com', '女');
INSERT INTO `customer_demo` VALUES (542240, 'ab72081e', 'Ma636', 'ab7208 ab7208', 2, 'ab7208 9255, ab7208, ab7208, ab7208, 839371', '111739196817', '20050402', '701701262@qq.com', '女');
INSERT INTO `customer_demo` VALUES (824280, 'ab72089b', 'Th238', 'ab7208 ab7208', 2, 'ab7208 9510, ab7208, ab7208, ab7208, 292392', '111173191337', '19870618', '750767765@qq.com', '女');
INSERT INTO `customer_demo` VALUES (677832, 'ab720919', 'Ir536', 'ab7209 ab7209', 2, 'ab7209 3506, ab7209, ab7209, ab7209, 299228', '111667765500', '19930204', '413001266@qq.com', '男');
INSERT INTO `customer_demo` VALUES (168587, 'ab720998', 'Ci335', 'ab7209 ab7209', 2, 'ab7209 3549, ab7209, ab7209, ab7209, 989413', '110353185097', '19990721', '879656279@qq.com', '女');
INSERT INTO `customer_demo` VALUES (406390, 'ab720a16', 'Ir408', 'ab720a ab720a', 2, 'ab720a 6979, ab720a, ab720a, ab720a, 461973', '112351965270', '20090726', '717557845@qq.com', '男');
INSERT INTO `customer_demo` VALUES (670164, 'ab720a94', 'Dw864', 'ab720a ab720a', 2, 'ab720a 6616, ab720a, ab720a, ab720a, 761118', '110538212332', '20150621', '734524168@qq.com', '男');
INSERT INTO `customer_demo` VALUES (701635, 'ab720b12', 'Hj966', 'ab720b ab720b', 2, 'ab720b 7467, ab720b, ab720b, ab720b, 844895', '110047133296', '19960524', '801107180@qq.com', '女');
INSERT INTO `customer_demo` VALUES (975530, 'ab720ba1', 'Wm754', 'ab720b ab720b', 2, 'ab720b 2192, ab720b, ab720b, ab720b, 914385', '110257277625', '20150227', '392285929@qq.com', '男');
INSERT INTO `customer_demo` VALUES (633500, 'ab720c2b', 'Qi845', 'ab720c ab720c', 2, 'ab720c 1234, ab720c, ab720c, ab720c, 131386', '112140382757', '19810527', '774516234@qq.com', '男');
INSERT INTO `customer_demo` VALUES (317948, 'ab720cac', 'Xw577', 'ab720c ab720c', 2, 'ab720c 840, ab720c, ab720c, ab720c, 828930', '110322216823', '20221001', '843398871@qq.com', '女');
INSERT INTO `customer_demo` VALUES (879277, 'ab720d2b', 'Sa926', 'ab720d ab720d', 2, 'ab720d 5384, ab720d, ab720d, ab720d, 937742', '112779795931', '20030915', '788188459@qq.com', '女');
INSERT INTO `customer_demo` VALUES (631125, 'ab720de1', 'Fi993', 'ab720d ab720d', 2, 'ab720d 9733, ab720d, ab720e, ab720e, 887178', '111452102392', '20191128', '265791133@qq.com', '女');
INSERT INTO `customer_demo` VALUES (197082, 'ab720e6b', 'Yk216', 'ab720e ab720e', 2, 'ab720e 4698, ab720e, ab720e, ab720e, 962532', '111790871174', '19850727', '570567777@qq.com', '男');
INSERT INTO `customer_demo` VALUES (166212, 'ab720eec', 'Jr381', 'ab720e ab720e', 2, 'ab720f 4885, ab720f, ab720f, ab720f, 503574', '112842936456', '20121012', '904961784@qq.com', '男');
INSERT INTO `customer_demo` VALUES (648942, 'ab720f6b', 'Ho887', 'ab720f ab720f', 2, 'ab720f 7548, ab720f, ab720f, ab720f, 150840', '111531059593', '20230122', '348293017@qq.com', '女');
INSERT INTO `customer_demo` VALUES (689678, 'ab720fe8', 'Ez343', 'ab720f ab720f', 2, 'ab720f 4542, ab7210, ab7210, ab7210, 460239', '110184783098', '19930117', '675739876@qq.com', '女');
INSERT INTO `customer_demo` VALUES (534245, 'ab721065', 'Uk762', 'ab7210 ab7210', 2, 'ab7210 4478, ab7210, ab7210, ab7210, 32458', '110543660225', '20230919', '667230620@qq.com', '男');
INSERT INTO `customer_demo` VALUES (314533, 'ab7211a4', 'Nw766', 'ab7211 ab7211', 2, 'ab7211 1324, ab7211, ab7211, ab7211, 440758', '110580854225', '20100717', '274758254@qq.com', '男');
INSERT INTO `customer_demo` VALUES (575245, 'ab72125d', 'Jh374', 'ab7212 ab7212', 2, 'ab7212 6698, ab7212, ab7212, ab7212, 433660', '112523770841', '20010826', '399437519@qq.com', '男');
INSERT INTO `customer_demo` VALUES (491033, 'ab721311', 'Ig428', 'ab7213 ab7213', 2, 'ab7213 446, ab7213, ab7213, ab7213, 126852', '111498672171', '19850828', '575296071@qq.com', '男');
INSERT INTO `customer_demo` VALUES (164313, 'ab7213c4', 'Zp219', 'ab7213 ab7213', 2, 'ab7213 8475, ab7213, ab7213, ab7213, 840427', '111021114913', '20130222', '339516277@qq.com', '女');
INSERT INTO `customer_demo` VALUES (916990, 'ab721479', 'Iw385', 'ab7214 ab7214', 2, 'ab7214 261, ab7214, ab7214, ab7214, 180780', '110523820059', '20050405', '157124568@qq.com', '女');
INSERT INTO `customer_demo` VALUES (265088, 'ab72152e', 'Hx722', 'ab7215 ab7215', 2, 'ab7215 7143, ab7215, ab7215, ab7215, 497826', '111961368037', '19900607', '747736272@qq.com', '男');
INSERT INTO `customer_demo` VALUES (398127, 'ab7215e3', 'Ev636', 'ab7215 ab7215', 2, 'ab7216 5310, ab7216, ab7216, ab7216, 866819', '110776719588', '19840111', '157419248@qq.com', '女');
INSERT INTO `customer_demo` VALUES (546624, 'ab721696', 'Gw520', 'ab7216 ab7216', 2, 'ab7216 7702, ab7216, ab7216, ab7216, 450754', '110170612485', '19950808', '347244222@qq.com', '女');
INSERT INTO `customer_demo` VALUES (398729, 'ab721749', 'Ev705', 'ab7217 ab7217', 2, 'ab7217 8599, ab7217, ab7217, ab7217, 282471', '110502500697', '19930510', '989309373@qq.com', '女');
INSERT INTO `customer_demo` VALUES (165667, 'ab721804', 'Om854', 'ab7218 ab7218', 2, 'ab7218 7143, ab7218, ab7218, ab7218, 55261', '112600029203', '20010614', '801965700@qq.com', '女');
INSERT INTO `customer_demo` VALUES (893297, 'ab7218be', 'Ws113', 'ab7218 ab7218', 2, 'ab7218 8937, ab7218, ab7218, ab7218, 422804', '111702115696', '20180724', '501179695@qq.com', '女');
INSERT INTO `customer_demo` VALUES (898772, 'ab721973', 'Nw772', 'ab7219 ab7219', 2, 'ab7219 1845, ab7219, ab7219, ab7219, 679852', '110463041496', '19880726', '202636339@qq.com', '男');
INSERT INTO `customer_demo` VALUES (510600, '0fd3250a', 'Gw620', '赵何宋', -2, '0fd325 5590, 0fd325, 0fd325, 0fd325, 860715', '111120528884', '20030821', '937613416@qq.com', '女');
INSERT INTO `customer_demo` VALUES (850988, '0fd3292d', 'Pm641', '马李马', -2, '0fd329 7729, 0fd329, 0fd329, 0fd329, 88513', '112628743212', '19950103', '449412943@qq.com', '男');
INSERT INTO `customer_demo` VALUES (840622, '0fd32a19', 'Nd226', '赵宋宋', -2, '0fd32a 778, 0fd32a, 0fd32a, 0fd32a, 405266', '110621945966', '20120727', '736433502@qq.com', '女');
INSERT INTO `customer_demo` VALUES (275678, '0fd32aae', 'Ki607', '高杨梁', -2, '0fd32a 5666, 0fd32a, 0fd32a, 0fd32a, 253487', '111297893710', '19830530', '829021830@qq.com', '女');
INSERT INTO `customer_demo` VALUES (344974, '0fd32b44', 'Tw269', '赵罗郭', -2, '0fd32b 8678, 0fd32b, 0fd32b, 0fd32b, 154473', '112493328243', '19960306', '146089955@qq.com', '女');
INSERT INTO `customer_demo` VALUES (447976, '0fd32bca', 'Vx999', '黄郭孙', -2, '0fd32b 3776, 0fd32b, 0fd32b, 0fd32b, 394934', '110474752806', '19810923', '747226038@qq.com', '女');
INSERT INTO `customer_demo` VALUES (382108, '0fd32c4e', 'Xm786', '周朱朱', -2, '0fd32c 1452, 0fd32c, 0fd32c, 0fd32c, 90694', '112946389255', '20150529', '514978465@qq.com', '男');
INSERT INTO `customer_demo` VALUES (519457, '0fd32cd1', 'Vs158', '陈梁胡', -2, '0fd32c 5160, 0fd32c, 0fd32c, 0fd32c, 745223', '112465925673', '20081105', '481149132@qq.com', '女');
INSERT INTO `customer_demo` VALUES (462447, '0fd32d5c', 'Fv614', '黄宋郑', -2, '0fd32d 4406, 0fd32d, 0fd32d, 0fd32d, 577798', '111298556534', '19841224', '361926194@qq.com', '男');
INSERT INTO `customer_demo` VALUES (313313, '0fd32e03', 'Nw876', '林郭胡', -2, '0fd32e 427, 0fd32e, 0fd32e, 0fd32e, 279968', '112185642391', '20020519', '309637856@qq.com', '男');
INSERT INTO `customer_demo` VALUES (526507, '0fd32e99', 'Rx586', '宋赵徐', -2, '0fd32e 4725, 0fd32e, 0fd32e, 0fd32e, 973328', '111652848492', '19940119', '336638696@qq.com', '男');
INSERT INTO `customer_demo` VALUES (534791, '0fd32f21', 'Gv375', '张朱吴', -2, '0fd32f 4341, 0fd32f, 0fd32f, 0fd32f, 945155', '111729579963', '19921212', '848088670@qq.com', '女');
INSERT INTO `customer_demo` VALUES (587158, '0fd32fa5', 'Xu425', '吴郑赵', -2, '0fd32f 7938, 0fd32f, 0fd32f, 0fd32f, 78107', '112973227472', '20140130', '450351575@qq.com', '女');
INSERT INTO `customer_demo` VALUES (256483, '0fd33035', 'Gu286', '胡朱郑', -2, '0fd330 7186, 0fd330, 0fd330, 0fd330, 959242', '111078765926', '19930405', '589699773@qq.com', '男');
INSERT INTO `customer_demo` VALUES (130965, '0fd330b9', 'Ut520', '李罗孙', -2, '0fd330 5876, 0fd330, 0fd330, 0fd330, 499651', '110793953080', '19870622', '421457812@qq.com', '男');
INSERT INTO `customer_demo` VALUES (676116, '0fd3313b', 'Uy476', '杨宋陈', -2, '0fd331 34, 0fd331, 0fd331, 0fd331, 436924', '112477013296', '20040212', '799414100@qq.com', '女');
INSERT INTO `customer_demo` VALUES (309747, '0fd331d3', 'Al180', '刘徐梁', -2, '0fd331 9393, 0fd331, 0fd331, 0fd331, 104769', '110882714643', '19890418', '817561797@qq.com', '女');
INSERT INTO `customer_demo` VALUES (596406, '0fd3325a', 'Zh590', '高吴郭', -2, '0fd332 2947, 0fd332, 0fd332, 0fd332, 319857', '110854639375', '20060501', '392207528@qq.com', '男');
INSERT INTO `customer_demo` VALUES (780252, '0fd332de', 'Il253', '朱刘陈', -2, '0fd332 5705, 0fd332, 0fd332, 0fd333, 216555', '111886791123', '19880703', '144320887@qq.com', '男');
INSERT INTO `customer_demo` VALUES (728946, '0fd33369', 'Kv112', '马高赵', -2, '0fd333 9326, 0fd333, 0fd333, 0fd333, 876796', '111241600061', '19920228', '857298963@qq.com', '女');
INSERT INTO `customer_demo` VALUES (370532, '0fd333eb', 'Fd160', '罗吴赵', -2, '0fd334 1113, 0fd334, 0fd334, 0fd334, 758799', '111620002186', '19811127', '893636475@qq.com', '女');
INSERT INTO `customer_demo` VALUES (201373, '0fd3346b', 'Xf364', '梁吴徐', -2, '0fd334 698, 0fd334, 0fd334, 0fd334, 976727', '110978022758', '19980829', '366011306@qq.com', '女');
INSERT INTO `customer_demo` VALUES (121154, '0fd334ec', 'Uu656', '郭高高', -2, '0fd335 7087, 0fd335, 0fd335, 0fd335, 71461', '112306538369', '20200729', '257810547@qq.com', '男');
INSERT INTO `customer_demo` VALUES (289379, '0fd3356f', 'Pk341', '李胡高', -2, '0fd335 2642, 0fd335, 0fd335, 0fd335, 856043', '111537990477', '20170121', '413422493@qq.com', '男');
INSERT INTO `customer_demo` VALUES (720941, '0fd335ff', 'Kz681', '黄马李', -2, '0fd336 5162, 0fd336, 0fd336, 0fd336, 398194', '111673724259', '19800702', '397203922@qq.com', '男');
INSERT INTO `customer_demo` VALUES (546699, '0fd33684', 'Zl390', '杨杨徐', -2, '0fd336 5113, 0fd336, 0fd336, 0fd336, 231125', '111134834697', '19970214', '471991034@qq.com', '女');
INSERT INTO `customer_demo` VALUES (958807, '0fd33703', 'Wk539', '陈马黄', -2, '0fd337 7807, 0fd337, 0fd337, 0fd337, 976617', '111377791067', '20130812', '842723911@qq.com', '男');
INSERT INTO `customer_demo` VALUES (511534, '0fd33786', 'Dg931', '梁吴马', -2, '0fd337 6245, 0fd337, 0fd337, 0fd337, 395726', '112685019159', '19940227', '244182154@qq.com', '男');
INSERT INTO `customer_demo` VALUES (710425, '0fd33811', 'Sl223', '周黄胡', -2, '0fd338 1873, 0fd338, 0fd338, 0fd338, 16091', '111444613050', '20030211', '518565560@qq.com', '女');
INSERT INTO `customer_demo` VALUES (417851, '0fd33890', 'Nn165', '高郭杨', -2, '0fd338 753, 0fd338, 0fd338, 0fd338, 631122', '110211200121', '20120731', '402847414@qq.com', '女');
INSERT INTO `customer_demo` VALUES (580761, '0fd33910', 'Od973', '孙朱杨', -2, '0fd339 4920, 0fd339, 0fd339, 0fd339, 796028', '111487783832', '19850624', '367688218@qq.com', '男');
INSERT INTO `customer_demo` VALUES (377863, '0fd3398f', 'Fe348', '高杨何', -2, '0fd339 1576, 0fd339, 0fd339, 0fd339, 453652', '110614253835', '20061028', '969193068@qq.com', '男');
INSERT INTO `customer_demo` VALUES (220122, '0fd33a24', 'Qv346', '梁周赵', -2, '0fd33a 2583, 0fd33a, 0fd33a, 0fd33a, 500114', '110823137165', '19851206', '321707953@qq.com', '男');
INSERT INTO `customer_demo` VALUES (570707, '0fd33aa7', 'Gs844', '宋周王', -2, '0fd33a 9883, 0fd33a, 0fd33a, 0fd33a, 844905', '112221821485', '20120512', '364340487@qq.com', '女');
INSERT INTO `customer_demo` VALUES (354637, '0fd33b29', 'Xt921', '周张周', -2, '0fd33b 6248, 0fd33b, 0fd33b, 0fd33b, 975119', '112997025270', '19830120', '546826678@qq.com', '男');
INSERT INTO `customer_demo` VALUES (890037, '0fd33ba9', 'Of410', '张徐罗', -2, '0fd33b 2729, 0fd33b, 0fd33b, 0fd33b, 607021', '112351142977', '19910320', '513777780@qq.com', '女');
INSERT INTO `customer_demo` VALUES (872766, '0fd33c28', 'Te666', '胡陈陈', -2, '0fd33c 3163, 0fd33c, 0fd33c, 0fd33c, 14537', '112628991408', '20040930', '493906642@qq.com', '女');
INSERT INTO `customer_demo` VALUES (812612, '0fd33ca7', 'Mc132', '梁杨朱', -2, '0fd33c 768, 0fd33c, 0fd33c, 0fd33c, 720854', '111879257486', '20100721', '416027344@qq.com', '男');
INSERT INTO `customer_demo` VALUES (116188, '0fd33d27', 'Be789', '赵刘高', -2, '0fd33d 6462, 0fd33d, 0fd33d, 0fd33d, 802560', '112777581882', '20210812', '633850346@qq.com', '女');
INSERT INTO `customer_demo` VALUES (942661, '0fd33dbc', 'Ll909', '刘王林', -2, '0fd33d 2139, 0fd33d, 0fd33d, 0fd33d, 112278', '110241207377', '19910803', '204485613@qq.com', '女');
INSERT INTO `customer_demo` VALUES (354751, '0fd33e41', 'Gi961', '高李郑', -2, '0fd33e 3314, 0fd33e, 0fd33e, 0fd33e, 968945', '110448474794', '19940815', '737661619@qq.com', '女');
INSERT INTO `customer_demo` VALUES (881833, '0fd33ee3', 'Jd642', '胡黄何', -2, '0fd33e 8737, 0fd33e, 0fd33f, 0fd33f, 47582', '111149749397', '20201219', '720812490@qq.com', '男');
INSERT INTO `customer_demo` VALUES (471837, '0fd33f6f', 'Uq892', '徐郭杨', -2, '0fd33f 764, 0fd33f, 0fd33f, 0fd33f, 610119', '110535942133', '19910806', '144154261@qq.com', '女');
INSERT INTO `customer_demo` VALUES (703457, '0fd33ff3', 'Mh194', '胡梁赵', -2, '0fd340 9120, 0fd340, 0fd340, 0fd340, 710943', '110544359902', '20211107', '250026245@qq.com', '男');
INSERT INTO `customer_demo` VALUES (165115, '0fd34073', 'Kw205', '宋徐吴', -2, '0fd340 6938, 0fd340, 0fd340, 0fd340, 223988', '112884380161', '20020104', '933543704@qq.com', '女');
INSERT INTO `customer_demo` VALUES (284096, '0fd340f4', 'Ao690', '胡陈宋', -2, '0fd341 4140, 0fd341, 0fd341, 0fd341, 106949', '112121780336', '19860217', '324961430@qq.com', '女');
INSERT INTO `customer_demo` VALUES (302404, '0fd34176', 'Da728', '吴王何', -2, '0fd341 8411, 0fd341, 0fd341, 0fd341, 889169', '110232435832', '20200522', '908169988@qq.com', '女');
INSERT INTO `customer_demo` VALUES (496001, '0fd341f5', 'Ih489', '黄黄郭', -2, '0fd342 6410, 0fd342, 0fd342, 0fd342, 1398', '112748273795', '19970820', '928207171@qq.com', '女');
INSERT INTO `customer_demo` VALUES (153262, '0fd34288', 'Kv999', '徐周周', -2, '0fd342 8634, 0fd342, 0fd342, 0fd342, 148959', '112536372066', '19940220', '778973714@qq.com', '男');
INSERT INTO `customer_demo` VALUES (859610, '0fd3430d', 'Og608', '张何徐', -2, '0fd343 9581, 0fd343, 0fd343, 0fd343, 484992', '111348019117', '19920401', '997548783@qq.com', '男');
INSERT INTO `customer_demo` VALUES (452318, '0fd3438f', 'Sm216', '赵罗高', -2, '0fd343 2616, 0fd343, 0fd343, 0fd343, 899970', '110854946764', '20171229', '955629636@qq.com', '男');
INSERT INTO `customer_demo` VALUES (987202, '0fd34410', 'Le630', '吴周孙', -2, '0fd344 5000, 0fd344, 0fd344, 0fd344, 955740', '112164224206', '20020320', '602130967@qq.com', '女');
INSERT INTO `customer_demo` VALUES (517934, '0fd34491', 'Lu722', '李陈高', -2, '0fd344 4638, 0fd344, 0fd344, 0fd344, 891454', '112803111768', '20080220', '800102545@qq.com', '女');
INSERT INTO `customer_demo` VALUES (218511, '0fd3451d', 'Pn790', '黄周高', -2, '0fd345 8974, 0fd345, 0fd345, 0fd345, 104467', '110509678336', '20160111', '766522403@qq.com', '女');
INSERT INTO `customer_demo` VALUES (831635, '0fd3459e', 'Qu973', '孙胡郭', -2, '0fd345 5416, 0fd345, 0fd345, 0fd345, 620236', '111571371264', '20020618', '102030448@qq.com', '男');
INSERT INTO `customer_demo` VALUES (536791, '0fd3461e', 'Df649', '徐吴郭', -2, '0fd346 3245, 0fd346, 0fd346, 0fd346, 487462', '111608869669', '20160602', '757496660@qq.com', '男');
INSERT INTO `customer_demo` VALUES (886019, '0fd346a0', 'Ia199', '孙刘赵', -2, '0fd346 8683, 0fd346, 0fd346, 0fd346, 549601', '112571396343', '19821022', '816889403@qq.com', '男');
INSERT INTO `customer_demo` VALUES (138421, '0fd3471f', 'Yq414', '高李何', -2, '0fd347 6872, 0fd347, 0fd347, 0fd347, 145444', '111003522218', '20181018', '761360414@qq.com', '女');
INSERT INTO `customer_demo` VALUES (846550, '0fd3479e', 'Sd597', '黄宋梁', -2, '0fd347 4319, 0fd347, 0fd347, 0fd347, 556512', '111540276683', '20120513', '462620375@qq.com', '女');
INSERT INTO `customer_demo` VALUES (498479, '0fd34823', 'Qu155', '罗马王', -2, '0fd348 3207, 0fd348, 0fd348, 0fd348, 580614', '110177444345', '20210906', '400088301@qq.com', '男');
INSERT INTO `customer_demo` VALUES (486472, '0fd348a2', 'Re749', '刘孙陈', -2, '0fd348 3589, 0fd348, 0fd348, 0fd348, 245349', '112550246739', '19800909', '452612886@qq.com', '女');
INSERT INTO `customer_demo` VALUES (894249, '0fd34926', 'Zg346', '胡吴李', -2, '0fd349 660, 0fd349, 0fd349, 0fd349, 177411', '110933084760', '20190604', '304338949@qq.com', '女');
INSERT INTO `customer_demo` VALUES (863225, '0fd349a6', 'Nb799', '林李黄', -2, '0fd349 4021, 0fd349, 0fd349, 0fd349, 36580', '110070527210', '20130517', '963308102@qq.com', '女');
INSERT INTO `customer_demo` VALUES (836751, '0fd34a24', 'Wx979', '张林李', -2, '0fd34a 2069, 0fd34a, 0fd34a, 0fd34a, 879109', '110675997943', '19901215', '363430104@qq.com', '女');
INSERT INTO `customer_demo` VALUES (871271, '0fd34ada', 'Bq198', '马林马', -2, '0fd34a 9006, 0fd34a, 0fd34a, 0fd34a, 742390', '112969891642', '20150812', '571156162@qq.com', '女');
INSERT INTO `customer_demo` VALUES (263965, '0fd34b68', 'Rt794', '胡郭高', -2, '0fd34b 9219, 0fd34b, 0fd34b, 0fd34b, 142894', '110154362947', '19930427', '307230914@qq.com', '男');
INSERT INTO `customer_demo` VALUES (868226, '0fd34bed', 'Yd914', '张郭周', -2, '0fd34c 6369, 0fd34c, 0fd34c, 0fd34c, 96669', '111282196861', '20040519', '678847620@qq.com', '男');
INSERT INTO `customer_demo` VALUES (905881, '0fd34c6d', 'Zf258', '陈孙罗', -2, '0fd34c 1421, 0fd34c, 0fd34c, 0fd34c, 903854', '112721874823', '20121005', '387368002@qq.com', '男');
INSERT INTO `customer_demo` VALUES (757636, '0fd34ced', 'Ga394', '胡李孙', -2, '0fd34d 2460, 0fd34d, 0fd34d, 0fd34d, 769547', '112671595985', '19900525', '506226807@qq.com', '男');
INSERT INTO `customer_demo` VALUES (811138, '0fd34d6c', 'Ry784', '罗徐孙', -2, '0fd34d 1430, 0fd34d, 0fd34d, 0fd34d, 177731', '111621128429', '20130304', '399387860@qq.com', '女');
INSERT INTO `customer_demo` VALUES (377787, '0fd34dea', 'Yw527', '何周胡', -2, '0fd34d 533, 0fd34e, 0fd34e, 0fd34e, 340629', '111370490413', '20090425', '169445162@qq.com', '男');
INSERT INTO `customer_demo` VALUES (913032, '0fd34e70', 'Lm136', '高梁高', -2, '0fd34e 5533, 0fd34e, 0fd34e, 0fd34e, 327264', '110071495790', '20180619', '984134266@qq.com', '女');
INSERT INTO `customer_demo` VALUES (608032, '0fd34ef3', 'Iw525', '郭刘马', -2, '0fd34f 4134, 0fd34f, 0fd34f, 0fd34f, 366677', '111221187134', '20170713', '107489508@qq.com', '女');
INSERT INTO `customer_demo` VALUES (332166, '0fd34f7c', 'Iv254', '周周何', -2, '0fd34f 7467, 0fd34f, 0fd34f, 0fd34f, 394932', '110797074735', '20011217', '798703701@qq.com', '女');
INSERT INTO `customer_demo` VALUES (705927, '0fd35007', 'Zu216', '杨何刘', -2, '0fd350 4558, 0fd350, 0fd350, 0fd350, 820850', '110789840549', '19890830', '438305329@qq.com', '男');
INSERT INTO `customer_demo` VALUES (177716, '0fd3508b', 'Cg980', '张林罗', -2, '0fd350 6237, 0fd350, 0fd350, 0fd350, 367076', '110107283490', '20110720', '781301291@qq.com', '女');
INSERT INTO `customer_demo` VALUES (117107, '0fd3510c', 'Do439', '杨李郭', -2, '0fd351 2406, 0fd351, 0fd351, 0fd351, 103317', '110615651593', '20080508', '658654730@qq.com', '男');
INSERT INTO `customer_demo` VALUES (437200, '0fd3518d', 'Tn520', '郭赵杨', -2, '0fd351 3282, 0fd351, 0fd351, 0fd351, 920507', '111147011859', '19940906', '351379211@qq.com', '女');
INSERT INTO `customer_demo` VALUES (350414, '0fd3520a', 'Nu369', '陈宋吴', -2, '0fd352 1511, 0fd352, 0fd352, 0fd352, 479823', '110162993315', '19920304', '125983531@qq.com', '女');
INSERT INTO `customer_demo` VALUES (174049, '0fd3528e', 'Nh988', '王刘何', -2, '0fd352 2178, 0fd352, 0fd352, 0fd352, 864666', '110990488417', '20120218', '580054744@qq.com', '女');

-- ----------------------------
-- Table structure for insurance_policies
-- ----------------------------
DROP TABLE IF EXISTS `insurance_policies`;
CREATE TABLE `insurance_policies`  (
  `policies_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `number` int(11) NOT NULL COMMENT '订单号  用uuid或者随机id都行',
  `start_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '购买的保险时间',
  `end_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '保险到期时间（尽量以年为单位计算）',
  `insurance_cost` float(255, 2) NULL DEFAULT NULL COMMENT '总共花费',
  `type_id` int(11) NULL DEFAULT NULL COMMENT '保险的类别id',
  `cust_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `root_id` int(11) NULL DEFAULT NULL COMMENT '保险员id',
  PRIMARY KEY (`policies_id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  INDEX `cust_id`(`cust_id`) USING BTREE,
  INDEX `root_id`(`root_id`) USING BTREE,
  INDEX `number`(`number`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of insurance_policies
-- ----------------------------
INSERT INTO `insurance_policies` VALUES (31, 57556735, '2023/3/12', '2024/3/12', 1000.00, 1, 2, 1);

-- ----------------------------
-- Table structure for insurance_types
-- ----------------------------
DROP TABLE IF EXISTS `insurance_types`;
CREATE TABLE `insurance_types`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '保险id',
  `insuranceName` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '保险名称',
  `upperLimit` float(255, 2) NULL DEFAULT NULL COMMENT '保险最高上限金额 （不管索赔理赔最高都是这个）',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `rate` float(255, 2) NULL DEFAULT NULL COMMENT '赔率，用户够买保险* 赔率为自己的理赔最高金额，索赔如果超过则不合理',
  `ranges` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '可以运用的范围，和上面的描述差不多',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of insurance_types
-- ----------------------------
INSERT INTO `insurance_types` VALUES (1, '医疗保险', 20000.00, '分为住院医疗险和门诊医疗险。它的主要作用在于解决医疗费用，是社保的重要补充', 50.00, '111');
INSERT INTO `insurance_types` VALUES (2, '重疾保险', 400000.00, '重大疾病保险，提供如恶性肿瘤、急性心肌梗塞、脑中风后遗症等重大疾病的保障', 80.00, '222');
INSERT INTO `insurance_types` VALUES (4, '意外险', 500000.00, '意外险杠杆高、提供伤残保障、没有等待期、没有健康告知门槛低。', 101.00, '121212');
INSERT INTO `insurance_types` VALUES (5, '养老保险', 100000.00, '养老保险测试', 30.00, '1212123321313');
INSERT INTO `insurance_types` VALUES (6, '修改测试', 100.00, '修改测试', 10.00, '1234');
INSERT INTO `insurance_types` VALUES (7, '养老保险2', 100000.00, '养老保险测试', 30.00, '12121212');

-- ----------------------------
-- Table structure for lipei
-- ----------------------------
DROP TABLE IF EXISTS `lipei`;
CREATE TABLE `lipei`  (
  `lipei_id` int(11) NOT NULL COMMENT '理赔id',
  `lipei_number` int(11) NULL DEFAULT NULL COMMENT '理赔订单号',
  `lipei_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '理赔的时间',
  `lipei_money` float(255, 2) NULL DEFAULT NULL COMMENT '理赔的金额，不能超出产品的最高金额且不超过用户的购买金额*赔率',
  `claims_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '购买的订单号',
  `root_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '处理理赔的保险员（注意理赔代表改订单的索赔状态改为negotiation）',
  PRIMARY KEY (`lipei_id`) USING BTREE,
  INDEX `claims_id`(`claims_id`) USING BTREE,
  INDEX `number`(`number`) USING BTREE,
  INDEX `root_id`(`root_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lipei
-- ----------------------------
INSERT INTO `lipei` VALUES (4633, 31, '1678631428873', 100.00, 2754, NULL, '1');

-- ----------------------------
-- Table structure for root
-- ----------------------------
DROP TABLE IF EXISTS `root`;
CREATE TABLE `root`  (
  `root_id` int(11) NOT NULL COMMENT '保险员或者经理id',
  `root_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '名字',
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `role` int(11) NULL DEFAULT NULL COMMENT '权限 0 经理 1管理员',
  `root_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  PRIMARY KEY (`root_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of root
-- ----------------------------
INSERT INTO `root` VALUES (1, '余博奇', 'admin', '123', 0, '13888888888');
INSERT INTO `root` VALUES (2, '张思维', 'zsw111', '123', 1, '18374938190');

SET FOREIGN_KEY_CHECKS = 1;
