/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 127.0.0.1:3306
 Source Schema         : think_admin

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 29/12/2020 09:40:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ta_menu
-- ----------------------------
DROP TABLE IF EXISTS `ta_menu`;
CREATE TABLE `ta_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单跳转链接',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '状态',
  `is_auth` tinyint(2) NULL DEFAULT 0 COMMENT '是否验证权限',
  `is_show` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否显示导航',
  `module_id` int(11) NOT NULL DEFAULT 0 COMMENT '模块',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `target` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '打开方式',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '父节点',
  `is_plugin` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是插件 0 否 1 是',
  `sort` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '导航菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ta_menu
-- ----------------------------
INSERT INTO `ta_menu` VALUES (1, '本地插件', '/console/Addons/index.html', 1, 1, '1', 1, 1608794832, 1608794832, '', 0, 0, 0);
INSERT INTO `ta_menu` VALUES (2, '系统菜单', 'console/menu/index', 1, 1, '1', 2, 1608796328, 1608796328, '', 0, 0, 0);
INSERT INTO `ta_menu` VALUES (4, '系统用户', 'console/user/index', 1, 1, '1', 2, 1608796328, 1608796328, '', 0, 0, 0);
INSERT INTO `ta_menu` VALUES (6, '系统角色', 'console/role/index', 1, 1, '1', 2, 1608796328, 1608796328, '', 0, 0, 0);
INSERT INTO `ta_menu` VALUES (8, '菜单列表', 'console/menu/index', 1, 0, '1', 1, 1608866838, 1608866838, '', 1, 0, 0);
INSERT INTO `ta_menu` VALUES (7, '系统模块', 'console/module/index', 1, 1, '1', 2, 1608796328, 1608796328, '', 0, 0, 0);
INSERT INTO `ta_menu` VALUES (9, '菜单列表', 'console/menu/index', 1, 0, '1', 1, 1608875282, 1608875282, '', 8, 0, 1);
INSERT INTO `ta_menu` VALUES (10, '菜单列表', 'console/menu/index', 1, 0, '1', 1, 1608875532, 1608875532, '', 9, 0, 0);
INSERT INTO `ta_menu` VALUES (11, '控制台', 'console/index/index', 1, 0, '1', 0, 1608884995, 1608884995, '', 0, 0, 0);

-- ----------------------------
-- Table structure for ta_module
-- ----------------------------
DROP TABLE IF EXISTS `ta_module`;
CREATE TABLE `ta_module`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 禁用 1 启用',
  `is_show` int(11) NOT NULL DEFAULT 0 COMMENT '是否显示导航',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '模块' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ta_module
-- ----------------------------
INSERT INTO `ta_module` VALUES (1, '插件', 1, 1, 1608794832, 1608794832);
INSERT INTO `ta_module` VALUES (2, '系统', 1, 1, 1608796328, 1608796328);
INSERT INTO `ta_module` VALUES (0, '首页', 1, 1, 1608796328, 1608796328);

-- ----------------------------
-- Table structure for ta_role
-- ----------------------------
DROP TABLE IF EXISTS `ta_role`;
CREATE TABLE `ta_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台管理用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ta_role
-- ----------------------------
INSERT INTO `ta_role` VALUES (1, '超级管理员', 1);
INSERT INTO `ta_role` VALUES (2, '管理员', 1);
INSERT INTO `ta_role` VALUES (3, '测试', 1);

-- ----------------------------
-- Table structure for ta_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `ta_role_menu`;
CREATE TABLE `ta_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色对应权限' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of ta_role_menu
-- ----------------------------
INSERT INTO `ta_role_menu` VALUES (39, 1, 5);
INSERT INTO `ta_role_menu` VALUES (38, 1, 4);
INSERT INTO `ta_role_menu` VALUES (37, 1, 3);
INSERT INTO `ta_role_menu` VALUES (36, 1, 2);
INSERT INTO `ta_role_menu` VALUES (35, 1, 10);
INSERT INTO `ta_role_menu` VALUES (34, 1, 9);
INSERT INTO `ta_role_menu` VALUES (33, 1, 8);
INSERT INTO `ta_role_menu` VALUES (32, 1, 1);
INSERT INTO `ta_role_menu` VALUES (31, 1, 11);

-- ----------------------------
-- Table structure for ta_user
-- ----------------------------
DROP TABLE IF EXISTS `ta_user`;
CREATE TABLE `ta_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录名',
  `mobile` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `last_login_time` int(11) NULL DEFAULT NULL,
  `last_login_ip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `role_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ta_user
-- ----------------------------
INSERT INTO `ta_user` VALUES (1, '超级管理员', 'admin', '18713933800', '', 1609145805, 1609148391, NULL, '', '1,2,3');

SET FOREIGN_KEY_CHECKS = 1;
