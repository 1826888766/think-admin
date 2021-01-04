/*
 Navicat Premium Data Transfer

 Source Server         : 知了互联测试环境
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 39.99.234.18:3306
 Source Schema         : zhiliaohulian_newjob

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 31/12/2020 08:34:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for kw_comment_reply
-- ----------------------------
DROP TABLE IF EXISTS `kw_comment_reply`;
CREATE TABLE `kw_comment_reply`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户id 0 假评论 其他为真评论',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论内容',
  `dig_account` int(11) NOT NULL DEFAULT 0 COMMENT '点赞量',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '类型1圈子资讯   2话题',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  `comment_id` int(11) NOT NULL COMMENT '评论id',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '审核状态 0 未审核 1 已通过 2 未通过',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '评论回复' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
