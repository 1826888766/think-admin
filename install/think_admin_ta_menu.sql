create table ta_menu
(
    id          int auto_increment comment 'ID'
        primary key,
    name        varchar(255)           not null comment '菜单名称',
    url         varchar(255)           not null comment '菜单跳转链接',
    status      tinyint(2)  default 0  not null comment '状态',
    is_auth     tinyint(2)  default 0  null comment '是否验证权限',
    is_show     varchar(255)           null comment '是否显示导航',
    module_id   int         default 0  not null comment '模块',
    create_time int                    null,
    update_time int                    null,
    target      varchar(20) default '' not null comment '打开方式',
    parent_id   int         default 0  not null comment '父节点',
    is_plugin   tinyint(1)  default 0  not null comment '是否是插件 0 否 1 是',
    sort        int         default 0  not null,
    type        tinyint(1)  default 0  not null comment '0 视图 1 按钮'
)
    comment '导航菜单';

INSERT INTO think_admin.ta_menu (id, name, url, status, is_auth, is_show, module_id, create_time, update_time, target, parent_id, is_plugin, sort, type) VALUES (1, '本地插件', 'console/Addons/index', 1, 1, '1', 1, 1608794832, 1609732144, '_self', 0, 0, 0, 0);
INSERT INTO think_admin.ta_menu (id, name, url, status, is_auth, is_show, module_id, create_time, update_time, target, parent_id, is_plugin, sort, type) VALUES (2, '系统菜单', 'console/menu/index', 1, 1, '1', 2, 1608796328, 1608796328, '', 0, 0, 0, 0);
INSERT INTO think_admin.ta_menu (id, name, url, status, is_auth, is_show, module_id, create_time, update_time, target, parent_id, is_plugin, sort, type) VALUES (4, '系统用户', 'console/user/index', 1, 1, '1', 2, 1608796328, 1608796328, '', 0, 0, 0, 0);
INSERT INTO think_admin.ta_menu (id, name, url, status, is_auth, is_show, module_id, create_time, update_time, target, parent_id, is_plugin, sort, type) VALUES (6, '系统角色', 'console/role/index', 1, 1, '1', 2, 1608796328, 1608796328, '', 0, 0, 0, 0);
INSERT INTO think_admin.ta_menu (id, name, url, status, is_auth, is_show, module_id, create_time, update_time, target, parent_id, is_plugin, sort, type) VALUES (7, '系统模块', 'console/module/index', 1, 1, '1', 2, 1608796328, 1608796328, '', 0, 0, 0, 0);
INSERT INTO think_admin.ta_menu (id, name, url, status, is_auth, is_show, module_id, create_time, update_time, target, parent_id, is_plugin, sort, type) VALUES (12, '添加', 'console/menu/add', 1, 1, '0', 2, 1609722776, 1609722776, '', 2, 0, 0, 0);
INSERT INTO think_admin.ta_menu (id, name, url, status, is_auth, is_show, module_id, create_time, update_time, target, parent_id, is_plugin, sort, type) VALUES (13, '删除', 'console/menu/del', 1, 1, '0', 2, 1609724073, 1609741143, '', 2, 0, 1, 0);
INSERT INTO think_admin.ta_menu (id, name, url, status, is_auth, is_show, module_id, create_time, update_time, target, parent_id, is_plugin, sort, type) VALUES (11, '控制台', 'console/index/index', 1, 0, '1', 0, 1608884995, 1609741131, '', 0, 0, 1, 0);
INSERT INTO think_admin.ta_menu (id, name, url, status, is_auth, is_show, module_id, create_time, update_time, target, parent_id, is_plugin, sort, type) VALUES (14, '编辑', 'console/menu/edit', 1, 1, '0', 2, 1609724614, 1609724614, '_self', 2, 0, 0, 1);
INSERT INTO think_admin.ta_menu (id, name, url, status, is_auth, is_show, module_id, create_time, update_time, target, parent_id, is_plugin, sort, type) VALUES (15, '百度', 'http://www.baidu.com', 1, 1, '1', 2, 1609724660, 1609727505, '_blank', 0, 0, 0, 1);