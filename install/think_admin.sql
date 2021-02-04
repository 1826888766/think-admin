SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for PREFIX_black_ip
-- ----------------------------
DROP TABLE IF EXISTS `PREFIX_black_ip`;
CREATE TABLE `PREFIX_black_ip`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `count` int(11) NULL DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '1 黑名单 2 白名单',
  `status` int(11) NOT NULL DEFAULT 1,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '禁用ip' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of PREFIX_black_ip
-- ----------------------------

-- ----------------------------
-- Table structure for PREFIX_log
-- ----------------------------
DROP TABLE IF EXISTS `PREFIX_log`;
CREATE TABLE `PREFIX_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求链接',
  `admin_id` int(11) NULL DEFAULT NULL,
  `param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求数据',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT 1,
  `request_ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '1 系统日志 2 请求日志 3 接口日志 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 148 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of PREFIX_log
-- ----------------------------
INSERT INTO `PREFIX_log` VALUES (1, '【正常】全局请求中间件', 'http://www.think.io/console/log/index.html', NULL, '{\"s\":\"\\/console\\/log\\/index.html\"}', 1612229764, 1612229974, 5, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (2, '【正常】全局请求中间件', 'http://www.think.io/console/log/index.html?page=1&limit=10', NULL, '{\"s\":\"\\/console\\/log\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612229764, 1612229974, 5, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (3, '【正常】全局请求中间件', 'http://www.think.io/console/module/index.html', NULL, '{\"s\":\"\\/console\\/module\\/index.html\"}', 1612229765, 1612229973, 3, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (4, '【正常】全局请求中间件', 'http://www.think.io/console/module/index.html?page=1&limit=10', NULL, '{\"s\":\"\\/console\\/module\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612229765, 1612229973, 3, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (5, '【正常】全局请求中间件', 'http://www.think.io/console/role/index.html', NULL, '{\"s\":\"\\/console\\/role\\/index.html\"}', 1612229767, 1612229941, 3, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (6, '【正常】全局请求中间件', 'http://www.think.io/console/role/index.html?page=1&limit=10', NULL, '{\"s\":\"\\/console\\/role\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612229768, 1612229941, 3, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (7, '【正常】全局请求中间件', 'http://www.think.io/console/user/index.html', NULL, '{\"s\":\"\\/console\\/user\\/index.html\"}', 1612229770, 1612229958, 7, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (8, '【正常】全局请求中间件', 'http://www.think.io/console/user/index.html?page=1&limit=10', NULL, '{\"s\":\"\\/console\\/user\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612229770, 1612229959, 8, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (9, '【正常】全局请求中间件', 'http://www.think.io/console/menu/index.html', NULL, '{\"s\":\"\\/console\\/menu\\/index.html\"}', 1612229774, 1612229838, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (10, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html?module_id=1', NULL, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"1\"}', 1612229774, 1612229838, 2, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (11, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html?module_id=3', NULL, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"3\"}', 1612229776, 1612229871, 3, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (12, '【正常】全局请求中间件', 'http://www.think.io/console/User/add.html?iframe=1', NULL, '{\"s\":\"\\/console\\/User\\/add.html\",\"iframe\":\"1\"}', 1612229811, 1612229811, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (13, '【正常】全局请求中间件', 'http://www.think.io/console/User/add', NULL, '{\"s\":\"\\/console\\/User\\/add\",\"id\":\"\",\"nickname\":\"测试\",\"username\":\"ceshi\",\"mobile\":\"18713933800\",\"password\":\"123456\",\"password_confirm\":\"123456\",\"role_id\":{\"2\":\"3\"},\"status\":\"1\"}', 1612229831, 1612229831, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (14, '【正常】全局请求中间件', 'http://www.think.io/console/User/role.html?id=2&iframe=1', NULL, '{\"s\":\"\\/console\\/User\\/role.html\",\"id\":\"2\",\"iframe\":\"1\"}', 1612229833, 1612229876, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (15, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/add.html?id=4&module_id=3&iframe=1', NULL, '{\"s\":\"\\/console\\/Menu\\/add.html\",\"id\":\"4\",\"module_id\":\"3\",\"iframe\":\"1\"}', 1612229852, 1612229852, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (16, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/add', NULL, '{\"s\":\"\\/console\\/Menu\\/add\",\"parent_id\":\"4\",\"name\":\"设置角色\",\"url\":\"console\\/user\\/role\",\"sort\":\"\",\"target\":\"_self\",\"module_id\":\"3\",\"id\":\"\",\"status\":\"1\",\"type\":\"1\",\"is_show\":\"0\",\"is_auth\":\"1\"}', 1612229871, 1612229871, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (17, '【正常】全局请求中间件', 'http://www.think.io/console/User/permission.html?id=2&iframe=1', NULL, '{\"s\":\"\\/console\\/User\\/permission.html\",\"id\":\"2\",\"iframe\":\"1\"}', 1612229905, 1612229905, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (18, '【正常】全局请求中间件', 'http://www.think.io/console/login/logout.html', NULL, '{\"s\":\"\\/console\\/login\\/logout.html\"}', 1612229916, 1612229916, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (19, '【正常】全局请求中间件', 'http://www.think.io/console/login/index.html', NULL, '{\"s\":\"\\/console\\/login\\/index.html\"}', 1612229916, 1612243962, 39, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (20, '【正常】全局请求中间件', 'http://www.think.io/captcha.html', NULL, '{\"s\":\"\\/captcha.html\"}', 1612229916, 1612243962, 9, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (21, '【正常】全局请求中间件', 'http://www.think.io/console/Login/index.html', NULL, '{\"s\":\"\\/console\\/Login\\/index.html\",\"username\":\"ceshi\",\"password\":\"123456\",\"captcha\":\"26\"}', 1612229926, 1612229926, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (22, '【正常】全局请求中间件', 'http://www.think.io/console/index/index.html', NULL, '{\"s\":\"\\/console\\/index\\/index.html\"}', 1612229928, 1612229928, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (23, '【正常】全局请求中间件', 'http://www.think.io/console/black_ip/index.html', NULL, '{\"s\":\"\\/console\\/black_ip\\/index.html\"}', 1612229937, 1612229937, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (24, '【正常】全局请求中间件', 'http://www.think.io/console/black_ip/index.html?page=1&limit=10', NULL, '{\"s\":\"\\/console\\/black_ip\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612229937, 1612229937, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (25, '【正常】全局请求中间件', 'http://www.think.io/console/log/index.html?page=3&limit=10', NULL, '{\"s\":\"\\/console\\/log\\/index.html\",\"page\":\"3\",\"limit\":\"10\"}', 1612229977, 1612229977, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (26, '【正常】全局请求中间件', 'http://www.think.io/console/log/index.html?page=2&limit=10', NULL, '{\"s\":\"\\/console\\/log\\/index.html\",\"page\":\"2\",\"limit\":\"10\"}', 1612229979, 1612229979, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (27, '【正常】全局请求中间件', 'http://www.think.io/console/log/index.html', 2, '{\"s\":\"\\/console\\/log\\/index.html\"}', 1612230116, 1612231076, 14, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (28, '【正常】全局请求中间件', 'http://www.think.io/console/log/index.html?page=1&limit=10', 2, '{\"s\":\"\\/console\\/log\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612230116, 1612231076, 14, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (29, '【正常】全局请求中间件', 'http://www.think.io/console/black_ip/index.html', 2, '{\"s\":\"\\/console\\/black_ip\\/index.html\"}', 1612230119, 1612230187, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (30, '【正常】全局请求中间件', 'http://www.think.io/console/black_ip/index.html?page=1&limit=10', 2, '{\"s\":\"\\/console\\/black_ip\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612230119, 1612230188, 2, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (31, '【正常】全局请求中间件', 'http://www.think.io/console/module/index.html', 2, '{\"s\":\"\\/console\\/module\\/index.html\"}', 1612230190, 1612230657, 3, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (32, '【正常】全局请求中间件', 'http://www.think.io/console/module/index.html?page=1&limit=10', 2, '{\"s\":\"\\/console\\/module\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612230190, 1612230658, 3, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (33, '【正常】全局请求中间件', 'http://www.think.io/console/role/index.html', 2, '{\"s\":\"\\/console\\/role\\/index.html\"}', 1612230192, 1612230683, 4, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (34, '【正常】全局请求中间件', 'http://www.think.io/console/role/index.html?page=1&limit=10', 2, '{\"s\":\"\\/console\\/role\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612230192, 1612230684, 4, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (35, '【正常】全局请求中间件', 'http://www.think.io/console/user/index.html', 2, '{\"s\":\"\\/console\\/user\\/index.html\"}', 1612230637, 1612233855, 12, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (36, '【正常】全局请求中间件', 'http://www.think.io/console/user/index.html?page=1&limit=10', 2, '{\"s\":\"\\/console\\/user\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612230637, 1612233855, 15, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (37, '【正常】全局请求中间件', 'http://www.think.io/console/User/permission.html?id=2&iframe=1', 2, '{\"s\":\"\\/console\\/User\\/permission.html\",\"id\":\"2\",\"iframe\":\"1\"}', 1612230639, 1612230714, 5, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (38, '【正常】全局请求中间件', 'http://www.think.io/console/User/permission.html?id=2&iframe=1', 2, '{\"s\":\"\\/console\\/User\\/permission.html\",\"id\":\"2\",\"iframe\":\"1\",\"layuiTreeCheck_\":\"\",\"menu_id\":{\"0\":\"11\",\"1\":\"1\",\"4\":\"6\",\"5\":\"7\",\"6\":\"26\",\"7\":\"29\"}}', 1612230645, 1612230645, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (39, '【正常】全局请求中间件', 'http://www.think.io/console/User/permission.html?id=2&iframe=1', 2, '{\"s\":\"\\/console\\/User\\/permission.html\",\"id\":\"2\",\"iframe\":\"1\",\"layuiTreeCheck_\":\"\",\"menu_id\":[\"11\",\"1\",\"2\",\"4\",\"6\",\"7\",\"26\",\"29\"]}', 1612230651, 1612230695, 2, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (40, '【正常】全局请求中间件', 'http://www.think.io/console/menu/index.html', 2, '{\"s\":\"\\/console\\/menu\\/index.html\"}', 1612230722, 1612230723, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (41, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html?module_id=1', 2, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"1\"}', 1612230722, 1612230724, 2, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (42, '【正常】全局请求中间件', 'http://www.think.io/console/login/info.html', 2, '{\"s\":\"\\/console\\/login\\/info.html\"}', 1612230729, 1612230729, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (43, '【正常】全局请求中间件', 'http://www.think.io/console/User/edit.html?id=2&iframe=1', 2, '{\"s\":\"\\/console\\/User\\/edit.html\",\"id\":\"2\",\"iframe\":\"1\"}', 1612231078, 1612233858, 53, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (44, '【正常】全局请求中间件', 'http://www.think.io/console/upload/index?full_path=yes', 2, '{\"s\":\"\\/console\\/upload\\/index\",\"full_path\":\"yes\"}', 1612232625, 1612233838, 16, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (45, '【正常】全局请求中间件', 'http://www.think.io/', NULL, NULL, 1612234116, 1612234116, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (46, '【正常】全局请求中间件', 'http://www.think.io/console/Login/index.html', NULL, '{\"s\":\"\\/console\\/Login\\/index.html\",\"username\":\"admin\",\"password\":\"123456\",\"captcha\":\"\"}', 1612234122, 1612243972, 7, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (47, '【正常】全局请求中间件', 'http://www.think.io/console/Login/index.html', NULL, '{\"s\":\"\\/console\\/Login\\/index.html\",\"username\":\"ceshi\",\"password\":\"123456\",\"captcha\":\"\"}', 1612234135, 1612235966, 2, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (48, '【正常】全局请求中间件', 'http://www.think.io/console/index/index.html', 1, '{\"s\":\"\\/console\\/index\\/index.html\"}', 1612235281, 1612247735, 92, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (49, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index.html', 1, '{\"s\":\"\\/console\\/Addons\\/index.html\"}', 1612235283, 1612250581, 40, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (50, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index?page=1&limit=10', 1, '{\"s\":\"\\/console\\/Addons\\/index\",\"page\":\"1\",\"limit\":\"10\"}', 1612235283, 1612250581, 40, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (51, '【正常】全局请求中间件', 'http://www.think.io/console/menu/index.html', 1, '{\"s\":\"\\/console\\/menu\\/index.html\"}', 1612235287, 1612252688, 22, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (52, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html?module_id=1', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"1\"}', 1612235287, 1612252689, 22, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (53, '【正常】全局请求中间件', 'http://www.think.io/console/login/logout.html', 1, '{\"s\":\"\\/console\\/login\\/logout.html\"}', 1612235419, 1612235960, 3, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (54, '【正常】全局请求中间件', 'http://www.think.io/', NULL, NULL, 1612235563, 1612235563, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (55, '【正常】全局请求中间件', 'http://www.think.io/console/index/index.html', 2, '{\"s\":\"\\/console\\/index\\/index.html\"}', 1612235968, 1612235968, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (56, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index.html', 2, '{\"s\":\"\\/console\\/Addons\\/index.html\"}', 1612235971, 1612243962, 14, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (57, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index?page=1&limit=10', 2, '{\"s\":\"\\/console\\/Addons\\/index\",\"page\":\"1\",\"limit\":\"10\"}', 1612235971, 1612238958, 13, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (58, '【正常】全局请求中间件', 'http://www.think.io/console/index/%3Cblockquote%20class=', 1, '{\"s\":\"\\/console\\/index\\/<blockquote class=\"}', 1612244090, 1612244090, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (59, '【正常】全局请求中间件', 'http://www.think.io/console/login/index.html', 1, '{\"s\":\"\\/console\\/login\\/index.html\"}', 1612244094, 1612244094, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (60, '【正常】全局请求中间件', 'http://www.think.io/captcha.html', 1, '{\"s\":\"\\/captcha.html\"}', 1612244094, 1612244094, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (61, '【正常】全局请求中间件', 'http://www.think.io/console/Login/index.html', 1, '{\"s\":\"\\/console\\/Login\\/index.html\",\"username\":\"admin\",\"password\":\"123456\",\"captcha\":\"\"}', 1612244100, 1612244100, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (62, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/add.html?id=11&module_id=1&iframe=1', 1, '{\"s\":\"\\/console\\/Menu\\/add.html\",\"id\":\"11\",\"module_id\":\"1\",\"iframe\":\"1\"}', 1612250589, 1612251488, 29, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (63, '【正常】全局请求中间件', 'http://www.think.io/static/lib/layui/css/modules/layer//static/skin/style.css', 1, '{\"s\":\"\\/static\\/lib\\/layui\\/css\\/modules\\/layer\\/static\\/skin\\/style.css\"}', 1612250655, 1612250655, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (64, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/edit.html?id=11&module_id=1&iframe=1', 1, '{\"s\":\"\\/console\\/Menu\\/edit.html\",\"id\":\"11\",\"module_id\":\"1\",\"iframe\":\"1\"}', 1612250873, 1612250873, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (65, '【正常】全局请求中间件', 'http://www.think.io/console/user/index.html', 1, '{\"s\":\"\\/console\\/user\\/index.html\"}', 1612251495, 1612260475, 49, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (66, '【正常】全局请求中间件', 'http://www.think.io/console/user/index.html?page=1&limit=10', 1, '{\"s\":\"\\/console\\/user\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612251496, 1612260475, 48, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (67, '【正常】全局请求中间件', 'http://www.think.io/console/User/edit.html?id=2&iframe=1', 1, '{\"s\":\"\\/console\\/User\\/edit.html\",\"id\":\"2\",\"iframe\":\"1\"}', 1612251498, 1612260476, 3, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (68, '【正常】全局请求中间件', 'http://www.think.io/console/role/index.html', 1, '{\"s\":\"\\/console\\/role\\/index.html\"}', 1612251778, 1612252870, 10, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (69, '【正常】全局请求中间件', 'http://www.think.io/console/role/index.html?page=1&limit=10', 1, '{\"s\":\"\\/console\\/role\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612251779, 1612252870, 10, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (70, '【正常】全局请求中间件', 'http://www.think.io/console/Role/edit.html?id=2&iframe=1', 1, '{\"s\":\"\\/console\\/Role\\/edit.html\",\"id\":\"2\",\"iframe\":\"1\"}', 1612251784, 1612251784, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (71, '【正常】全局请求中间件', 'http://www.think.io/console/Role/permission.html?id=3&iframe=1', 1, '{\"s\":\"\\/console\\/Role\\/permission.html\",\"id\":\"3\",\"iframe\":\"1\"}', 1612251844, 1612252478, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (72, '【正常】全局请求中间件', 'http://www.think.io/console/Role/edit.html?id=1&iframe=1', 1, '{\"s\":\"\\/console\\/Role\\/edit.html\",\"id\":\"1\",\"iframe\":\"1\"}', 1612251847, 1612251847, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (73, '【正常】全局请求中间件', 'http://www.think.io/console/module/index.html', 1, '{\"s\":\"\\/console\\/module\\/index.html\"}', 1612251851, 1612252851, 7, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (74, '【正常】全局请求中间件', 'http://www.think.io/console/module/index.html?page=1&limit=10', 1, '{\"s\":\"\\/console\\/module\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612251851, 1612252852, 7, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (75, '【正常】全局请求中间件', 'http://www.think.io/console/Module/edit.html?id=1&iframe=1', 1, '{\"s\":\"\\/console\\/Module\\/edit.html\",\"id\":\"1\",\"iframe\":\"1\"}', 1612251853, 1612251853, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (76, '【正常】全局请求中间件', 'http://www.think.io/console/black_ip/index.html', 1, '{\"s\":\"\\/console\\/black_ip\\/index.html\"}', 1612251855, 1612259588, 15, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (77, '【正常】全局请求中间件', 'http://www.think.io/console/black_ip/index.html?page=1&limit=10', 1, '{\"s\":\"\\/console\\/black_ip\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612251856, 1612259588, 15, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (78, '【正常】全局请求中间件', 'http://www.think.io/console/black_ip/add?iframe=1', 1, '{\"s\":\"\\/console\\/black_ip\\/add\",\"iframe\":\"1\"}', 1612251858, 1612251858, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (79, '【正常】全局请求中间件', 'http://www.think.io/console/log/index.html', 1, '{\"s\":\"\\/console\\/log\\/index.html\"}', 1612251861, 1612252779, 20, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (80, '【正常】全局请求中间件', 'http://www.think.io/console/log/index.html?page=1&limit=10', 1, '{\"s\":\"\\/console\\/log\\/index.html\",\"page\":\"1\",\"limit\":\"10\"}', 1612251861, 1612252780, 20, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (81, '【正常】全局请求中间件', 'http://www.think.io/console/Role/edit.html?id=3&iframe=1', 1, '{\"s\":\"\\/console\\/Role\\/edit.html\",\"id\":\"3\",\"iframe\":\"1\"}', 1612252481, 1612252481, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (82, '【正常】全局请求中间件', 'http://www.think.io/console/Role/add.html?iframe=1', 1, '{\"s\":\"\\/console\\/Role\\/add.html\",\"iframe\":\"1\"}', 1612252483, 1612252483, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (83, '【正常】全局请求中间件', 'http://www.think.io/console/User/edit.html?id=1&iframe=1', 1, '{\"s\":\"\\/console\\/User\\/edit.html\",\"id\":\"1\",\"iframe\":\"1\"}', 1612260436, 1612260436, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (84, '【正常】全局请求中间件', 'http://www.think.io/console', NULL, '{\"s\":\"\\/console\"}', 1612314513, 1612333052, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (85, '【正常】全局请求中间件', 'http://www.think.io/console/login/index.html', NULL, '{\"s\":\"\\/console\\/login\\/index.html\"}', 1612314513, 1612314513, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (86, '【正常】全局请求中间件', 'http://www.think.io/captcha.html', NULL, '{\"s\":\"\\/captcha.html\"}', 1612314513, 1612314513, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (87, '【正常】全局请求中间件', 'http://www.think.io/console/Login/index.html', NULL, '{\"s\":\"\\/console\\/Login\\/index.html\",\"username\":\"admin\",\"password\":\"123456\",\"captcha\":\"\"}', 1612314520, 1612314520, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (88, '【正常】全局请求中间件', 'http://www.think.io/console/index/index.html', 1, '{\"s\":\"\\/console\\/index\\/index.html\"}', 1612314522, 1612348979, 68, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (89, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index.html', 1, '{\"s\":\"\\/console\\/Addons\\/index.html\"}', 1612314525, 1612322661, 9, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (90, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index?page=1&limit=10', 1, '{\"s\":\"\\/console\\/Addons\\/index\",\"page\":\"1\",\"limit\":\"10\"}', 1612314525, 1612349052, 53, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (91, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/install.html', 1, '{\"s\":\"\\/console\\/Addons\\/install.html\",\"id\":\"httpclient\"}', 1612315873, 1612322215, 2, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (92, '【正常】全局请求中间件', 'http://www.think.io/console/menu/index.html', 1, '{\"s\":\"\\/console\\/menu\\/index.html\"}', 1612315979, 1612322090, 26, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (93, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html?module_id=1', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"1\"}', 1612315980, 1612345125, 25, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (94, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html?module_id=2', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"2\"}', 1612316167, 1612316167, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (95, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html?module_id=3', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"3\"}', 1612316169, 1612344971, 3, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (96, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html?module_id=4', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"4\"}', 1612316171, 1612321727, 3, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (97, '【正常】全局请求中间件', 'http://www.think.io/addons//httpclient@_api/index.html', 1, '{\"s\":\"\\/addons\\/httpclient@_api\\/index.html\"}', 1612316188, 1612316266, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (98, '【正常】全局请求中间件', 'http://www.think.io/addons//httpclient@api/index.html', 1, '{\"s\":\"\\/addons\\/httpclient@api\\/index.html\"}', 1612316273, 1612316273, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (99, '【正常】全局请求中间件', 'http://www.think.io/addons//api/index.html', 1, '{\"s\":\"\\/addons\\/api\\/index.html\"}', 1612316292, 1612316405, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (100, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/index.html', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/index.html\"}', 1612316418, 1612321886, 74, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (101, '【正常】全局请求中间件', 'http://www.think.io/Api/index.html', 1, '{\"s\":\"\\/Api\\/index.html\"}', 1612321663, 1612321786, 4, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (102, '【正常】全局请求中间件', 'http://www.think.io/console/Index/welcome.html?iframe=1', 1, '{\"s\":\"\\/console\\/Index\\/welcome.html\",\"iframe\":\"1\"}', 1612322004, 1612348980, 68, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (103, '【正常】全局请求中间件', 'http://www.think.io/console/Login/index.html', 1, '{\"s\":\"\\/console\\/Login\\/index.html\",\"username\":\"admin\",\"password\":\"123456\",\"captcha\":\"\"}', 1612322037, 1612333058, 5, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (104, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/add.html?module_id=1&iframe=1', 1, '{\"s\":\"\\/console\\/Menu\\/add.html\",\"module_id\":\"1\",\"iframe\":\"1\"}', 1612322053, 1612322053, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (105, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/add', 1, '{\"s\":\"\\/console\\/Menu\\/add\",\"parent_id\":\"\",\"name\":\"欢迎页\",\"url\":\"console\\/index\\/welcome\",\"sort\":\"\",\"target\":\"_self\",\"module_id\":\"1\",\"id\":\"\",\"status\":\"1\",\"type\":\"0\",\"is_show\":\"0\",\"is_auth\":\"0\"}', 1612322083, 1612322083, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (106, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/index.html?iframe=1', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/index.html\",\"iframe\":\"1\"}', 1612322137, 1612348982, 227, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (107, '【正常】全局请求中间件', 'http://www.think.io/console/menu/index.html?iframe=1', 1, '{\"s\":\"\\/console\\/menu\\/index.html\",\"iframe\":\"1\"}', 1612322191, 1612345125, 5, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (108, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index.html?iframe=1', 1, '{\"s\":\"\\/console\\/Addons\\/index.html\",\"iframe\":\"1\"}', 1612322194, 1612349051, 12, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (109, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/setting.html?id=httpclient&iframe=1', 1, '{\"s\":\"\\/console\\/Addons\\/setting.html\",\"id\":\"httpclient\",\"iframe\":\"1\"}', 1612322237, 1612322566, 6, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (110, '【正常】全局请求中间件', 'http://www.think.io/console/index/index.html?iframe=1', 1, '{\"s\":\"\\/console\\/index\\/index.html\",\"iframe\":\"1\"}', 1612322588, 1612322603, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (111, '【正常】全局请求中间件', 'http://www.think.io/console/login/index.html', 1, '{\"s\":\"\\/console\\/login\\/index.html\"}', 1612322746, 1612348452, 14, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (112, '【正常】全局请求中间件', 'http://www.think.io/captcha.html', 1, '{\"s\":\"\\/captcha.html\"}', 1612322747, 1612348452, 6, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (113, '【正常】全局请求中间件', 'http://www.think.io/console/index/layerOpen(\'/console/login/info.html\')', 1, '{\"s\":\"\\/console\\/index\\/layerOpen(\'\\/console\\/login\\/info.html\')\"}', 1612328305, 1612328305, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (114, '【正常】全局请求中间件', 'http://www.think.io/console/login/info.html?iframe=1', 1, '{\"s\":\"\\/console\\/login\\/info.html\",\"iframe\":\"1\"}', 1612328324, 1612328335, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (115, '【正常】全局请求中间件', 'http://www.think.io/console/login/token.html?iframe=1', 1, '{\"s\":\"\\/console\\/login\\/token.html\",\"iframe\":\"1\"}', 1612328332, 1612328337, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (116, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/index.html?method=post&url=http%3A%2F%2Fwww.baidu.com', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/index.html\",\"method\":\"post\",\"url\":\"http:\\/\\/www.baidu.com\"}', 1612333085, 1612333100, 2, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (117, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/index.html?method=post&url=', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/index.html\",\"method\":\"post\",\"url\":\"\"}', 1612333102, 1612333103, 3, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (118, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/index.html?iframe=1', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/index.html\",\"iframe\":\"1\"}', 1612333157, 1612333465, 5, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (119, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/lay/modules/element.js', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/lay\\/modules\\/element.js\"}', 1612333291, 1612333291, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (120, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/lay/modules/layer.js', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/lay\\/modules\\/layer.js\"}', 1612333291, 1612333291, 1, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (121, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/index.html?method=post&url=http%3A%2F%2Fwww.think.io%2Fconsole%2Findex%2Findex.html', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/index.html\",\"method\":\"post\",\"url\":\"http:\\/\\/www.think.io\\/console\\/index\\/index.html\"}', 1612338215, 1612339148, 12, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (122, '【正常】全局请求中间件', 'http://www.think.io/console/index/index.html', 1, '{\"s\":\"\\/console\\/index\\/index.html\"}', 1612338242, 1612344981, 48, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (123, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index', 1, '{\"s\":\"\\/console\\/Addons\\/index\"}', 1612344658, 1612344727, 4, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (124, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index', 1, '{\"s\":\"\\/console\\/Addons\\/index\",\"page\":\"2\"}', 1612344866, 1612344866, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (125, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index', 1, '{\"s\":\"\\/console\\/Addons\\/index\",\"page\":\"2\",\"limit\":\"1\"}', 1612344906, 1612344906, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (126, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"3\"}', 1612345013, 1612345013, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (127, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"2\"}', 1612345016, 1612345016, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (128, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\"}', 1612345045, 1612345069, 4, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (129, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index?page=1&limit=10', 1, '{\"s\":\"\\/console\\/Addons\\/index\",\"page\":\"1\",\"limit\":\"10\",\"{}\":\"\"}', 1612345145, 1612345145, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (130, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html?module_id=1', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"1\",\"{}\":\"\"}', 1612345156, 1612345156, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (131, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"{\\\"module_id\\\":\\\"3\\\"}\":\"\"}', 1612345170, 1612345170, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (132, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"{\\\"module_id\\\":\\\"5\\\"}\":\"\"}', 1612345176, 1612345176, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (133, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"5\"}', 1612345199, 1612345199, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (134, '【正常】全局请求中间件', 'http://www.think.io/console/Menu/index.html', 1, '{\"s\":\"\\/console\\/Menu\\/index.html\",\"module_id\":\"4\"}', 1612345205, 1612345205, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (135, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/send', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/send\",\"headers\":{\"Content-Type\":\"application\\/json\"},\"data\":\"{}\"}', 1612346314, 1612346314, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (136, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/send', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/send\",\"url\":\"http:\\/\\/www.think.io\\/console\\/Addons\\/index?page=1&limit=10\",\"method\":\"post\",\"headers\":{\"Content-Type\":\"application\\/json\"}}', 1612346461, 1612346461, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (137, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/send', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/send\",\"url\":\"http:\\/\\/www.think.io\\/console\\/Addons\\/index?page=1&limit=10\",\"method\":\"post\",\"header\":{\"Content-Type\":\"application\\/json\"}}', 1612346478, 1612348452, 19, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (138, '【正常】全局请求中间件', 'http://www.think.io/console/Addons/index?page=1&limit=10', NULL, '{\"s\":\"\\/console\\/Addons\\/index\",\"page\":\"1\",\"limit\":\"10\"}', 1612346539, 1612348452, 18, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (139, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/send', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/send\",\"url\":\"http:\\/\\/www.baidu.com\",\"method\":\"post\",\"header\":{\"Content-Type\":\"application\\/json\"}}', 1612347553, 1612348500, 7, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (140, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/send', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/send\",\"url\":\"https:\\/\\/www.baidu.com\",\"method\":\"post\",\"header\":{\"Content-Type\":\"application\\/json\"}}', 1612347599, 1612347599, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (141, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/send', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/send\",\"url\":\"https:\\/\\/blog.csdn.net\\/qinshi501\\/article\\/details\\/73469355\",\"method\":\"post\",\"header\":{\"Content-Type\":\"application\\/json\"}}', 1612347676, 1612347676, 1, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (142, '【正常】全局请求中间件', 'http://www.think.io/addons/httpclient/api/send', 1, '{\"s\":\"\\/addons\\/httpclient\\/api\\/send\",\"url\":\"https:\\/\\/www.jb51.net\\/article\\/51839.htm\",\"method\":\"post\",\"header\":{\"Content-Type\":\"application\\/json\"}}', 1612348521, 1612349033, 11, '127.0.0.1', 2);
INSERT INTO `PREFIX_log` VALUES (143, '【正常】全局请求中间件', 'http://www.think.io/skin/2019/css/common.css', 1, '{\"s\":\"\\/skin\\/2019\\/css\\/common.css\"}', 1612348767, 1612349033, 10, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (144, '【正常】全局请求中间件', 'http://www.think.io/skin/2019/css/base.css', 1, '{\"s\":\"\\/skin\\/2019\\/css\\/base.css\"}', 1612348767, 1612349033, 10, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (145, '【正常】全局请求中间件', 'http://www.think.io/jslib/syntaxhighlighter/styles/shCore.css', 1, '{\"s\":\"\\/jslib\\/syntaxhighlighter\\/styles\\/shCore.css\"}', 1612348767, 1612349033, 10, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (146, '【正常】全局请求中间件', 'http://www.think.io/jslib/syntaxhighlighter/styles/shThemeDefault.css', 1, '{\"s\":\"\\/jslib\\/syntaxhighlighter\\/styles\\/shThemeDefault.css\"}', 1612348767, 1612349033, 10, '127.0.0.1', 1);
INSERT INTO `PREFIX_log` VALUES (147, '【正常】全局请求中间件', 'http://www.think.io/images/logo.gif', 1, '{\"s\":\"\\/images\\/logo.gif\"}', 1612348767, 1612349033, 10, '127.0.0.1', 1);

-- ----------------------------
-- Table structure for PREFIX_menu
-- ----------------------------
DROP TABLE IF EXISTS `PREFIX_menu`;
CREATE TABLE `PREFIX_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单跳转链接',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '状态',
  `is_auth` tinyint(2) NULL DEFAULT 0 COMMENT '是否验证权限',
  `is_show` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否显示导航',
  `module_id` int(11) NOT NULL DEFAULT 1 COMMENT '模块',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `target` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '打开方式',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '父节点',
  `is_plugin` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是插件 0 否 1 是',
  `sort` int(11) NOT NULL DEFAULT 0,
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 视图 1 按钮',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '导航菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of PREFIX_menu
-- ----------------------------
INSERT INTO `PREFIX_menu` VALUES (1, '本地插件', 'console/Addons/index', 1, 1, '1', 2, 1608794832, 1609732144, '_self', 0, 0, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (2, '系统菜单', 'console/menu/index', 1, 1, '1', 3, 1608796328, 1608796328, '', 0, 0, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (4, '系统用户', 'console/user/index', 1, 1, '1', 3, 1608796328, 1608796328, '', 0, 0, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (6, '系统角色', 'console/role/index', 1, 1, '1', 3, 1608796328, 1608796328, '', 0, 0, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (7, '系统模块', 'console/module/index', 1, 1, '1', 3, 1608796328, 1608796328, '', 0, 0, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (12, '添加', 'console/menu/add', 1, 1, '0', 3, 1609722776, 1609722776, '', 2, 0, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (13, '删除', 'console/menu/del', 1, 1, '0', 3, 1609724073, 1609741143, '', 2, 0, 1, 0);
INSERT INTO `PREFIX_menu` VALUES (11, '控制台', 'console/index/index', 1, 0, '0', 1, 1608884995, 1612139526, '_self', 0, 0, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (14, '编辑', 'console/menu/edit', 1, 1, '0', 3, 1609724614, 1609724614, '_self', 2, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (27, '清空日志', 'console/log/clear', 1, 1, '0', 3, 1612148124, 1612148124, '_self', 26, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (36, '删除', 'console/Addons/del', 1, 1, '0', 2, 1612163834, 1612163834, '_self', 1, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (33, '设置', 'console/Addons/setting', 1, 1, '0', 2, 1612158102, 1612158102, '_self', 1, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (34, '安装', 'console/Addons/install', 1, 1, '0', 2, 1612163603, 1612163603, '_self', 1, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (35, '卸载', 'console/Addons/uninstall', 1, 1, '0', 2, 1612163802, 1612163802, '_self', 1, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (23, '添加', 'console/module/index', 1, 1, '0', 3, 1612139700, 1612139700, '_self', 7, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (24, '编辑', 'console/module/edit', 1, 1, '0', 3, 1612139749, 1612139749, '_self', 7, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (25, '删除', 'console/module/del', 1, 1, '0', 3, 1612139771, 1612141146, '_self', 7, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (26, '系统日志', 'console/log/index', 1, 1, '1', 3, 1612142902, 1612142902, '_self', 0, 0, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (28, '禁用ip', 'console/log/disable', 1, 1, '0', 3, 1612149367, 1612149367, '_self', 26, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (29, '白名单', 'console/black_ip/index', 1, 1, '1', 3, 1612150088, 1612169108, '_self', 0, 0, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (30, '状态更新', 'console/black_ip/status', 1, 1, '0', 3, 1612151021, 1612151021, '_self', 29, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (31, '删除', 'console/black_ip/del', 1, 1, '0', 3, 1612151042, 1612151042, '_self', 29, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (32, '添加', 'console/black_ip/add', 1, 1, '0', 3, 1612153141, 1612153141, '_self', 29, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (37, '添加', 'console/user/add', 1, 1, '0', 3, 1612170447, 1612170447, '_self', 4, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (38, '编辑', 'console/user/edit', 1, 1, '0', 3, 1612170468, 1612170468, '_self', 4, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (39, '删除', 'console/user/del', 1, 1, '0', 3, 1612170488, 1612170488, '_self', 4, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (40, '基本资料', 'console/login/info', 1, 1, '0', 3, 1612170550, 1612170550, '_self', 4, 0, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (41, '设置权限', 'console/role/permission', 1, 1, '0', 3, 1612173943, 1612173943, '_self', 6, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (42, '编辑', 'console/role/edit', 1, 1, '0', 3, 1612173963, 1612173963, '_self', 6, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (43, '添加', 'console/role/add', 1, 1, '0', 3, 1612173984, 1612173984, '_self', 6, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (44, '删除', 'console/role/del', 1, 1, '0', 3, 1612173997, 1612173997, '_self', 6, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (45, '设置权限', 'console/user/permission', 1, 1, '0', 3, 1612174013, 1612174013, '_self', 4, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (46, '设置角色', 'console/user/role', 1, 1, '0', 3, 1612229871, 1612229871, '_self', 4, 0, 0, 1);
INSERT INTO `PREFIX_menu` VALUES (47, '接口测试', 'httpclient://api/index', 1, 1, '1', 4, 1612315873, 1612315873, '_self', 0, 1, 0, 0);
INSERT INTO `PREFIX_menu` VALUES (48, '欢迎页', 'console/index/welcome', 1, 0, '0', 1, 1612322083, 1612322083, '_self', 0, 0, 0, 0);

-- ----------------------------
-- Table structure for PREFIX_module
-- ----------------------------
DROP TABLE IF EXISTS `PREFIX_module`;
CREATE TABLE `PREFIX_module`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 禁用 1 启用',
  `is_show` int(11) NOT NULL DEFAULT 0 COMMENT '是否显示导航',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '模块' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of PREFIX_module
-- ----------------------------
INSERT INTO `PREFIX_module` VALUES (1, '首页', 1, 1, 1608796328, 1608796328);
INSERT INTO `PREFIX_module` VALUES (2, '插件', 1, 1, 1608794832, 1608794832);
INSERT INTO `PREFIX_module` VALUES (3, '系统', 1, 1, 1608796328, 1608796328);
INSERT INTO `PREFIX_module` VALUES (4, '测试', 1, 1, 1609380886, 1609380886);

-- ----------------------------
-- Table structure for PREFIX_role
-- ----------------------------
DROP TABLE IF EXISTS `PREFIX_role`;
CREATE TABLE `PREFIX_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台管理用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of PREFIX_role
-- ----------------------------
INSERT INTO `PREFIX_role` VALUES (1, '超级管理员', 1);
INSERT INTO `PREFIX_role` VALUES (2, '管理员', 1);
INSERT INTO `PREFIX_role` VALUES (3, '测试', 1);

-- ----------------------------
-- Table structure for PREFIX_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `PREFIX_role_menu`;
CREATE TABLE `PREFIX_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色对应权限' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of PREFIX_role_menu
-- ----------------------------
INSERT INTO `PREFIX_role_menu` VALUES (72, 3, 7);
INSERT INTO `PREFIX_role_menu` VALUES (71, 3, 6);
INSERT INTO `PREFIX_role_menu` VALUES (70, 3, 4);
INSERT INTO `PREFIX_role_menu` VALUES (69, 3, 2);
INSERT INTO `PREFIX_role_menu` VALUES (68, 3, 1);
INSERT INTO `PREFIX_role_menu` VALUES (66, 1, 17);
INSERT INTO `PREFIX_role_menu` VALUES (65, 1, 15);
INSERT INTO `PREFIX_role_menu` VALUES (64, 1, 7);
INSERT INTO `PREFIX_role_menu` VALUES (63, 1, 6);
INSERT INTO `PREFIX_role_menu` VALUES (55, 2, 15);
INSERT INTO `PREFIX_role_menu` VALUES (54, 2, 1);
INSERT INTO `PREFIX_role_menu` VALUES (67, 3, 11);
INSERT INTO `PREFIX_role_menu` VALUES (62, 1, 4);
INSERT INTO `PREFIX_role_menu` VALUES (61, 1, 2);
INSERT INTO `PREFIX_role_menu` VALUES (60, 1, 1);
INSERT INTO `PREFIX_role_menu` VALUES (59, 1, 11);
INSERT INTO `PREFIX_role_menu` VALUES (73, 3, 26);
INSERT INTO `PREFIX_role_menu` VALUES (74, 3, 29);

-- ----------------------------
-- Table structure for PREFIX_user
-- ----------------------------
DROP TABLE IF EXISTS `PREFIX_user`;
CREATE TABLE `PREFIX_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录名',
  `mobile` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `last_login_time` int(11) NULL DEFAULT NULL,
  `last_login_ip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `role_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色id',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '用户状态',
  `menu_id` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单独分配的权限',
  `password_fail` int(11) NOT NULL DEFAULT 0,
  `online` int(11) NOT NULL DEFAULT 0 COMMENT '0 不在线 1 在线',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of PREFIX_user
-- ----------------------------
INSERT INTO `PREFIX_user` VALUES (1, '', '超级管理员', 'admin', '18713933801', '$2y$10$2GrLbByiM.XdjEJ9RWSW1OCTrZbxSO7qk5IAl5/5dPANUJod7qlW.', 1609145805, 1612333058, 1612333058, '127.0.0.1', '1,2,3', 1, 'a:2:{s:3:\"add\";a:1:{i:0;s:1:\"6\";}s:3:\"del\";a:1:{i:0;i:4;}}', 0, 0);
INSERT INTO `PREFIX_user` VALUES (2, '', '测试', 'ceshi', '18713933800', '$2y$10$2GrLbByiM.XdjEJ9RWSW1OCTrZbxSO7qk5IAl5/5dPANUJod7qlW.', 1612229831, 1612235966, 1612235966, '127.0.0.1', '3', 1, 'a:2:{s:3:\"add\";a:0:{}s:3:\"del\";a:0:{}}', 0, 0);

SET FOREIGN_KEY_CHECKS = 1;
