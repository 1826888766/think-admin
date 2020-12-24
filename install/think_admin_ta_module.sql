create table ta_module
(
    id          int auto_increment comment 'id'
        primary key,
    name        varchar(20)          null comment '名称',
    status      tinyint(1) default 0 not null comment '0 禁用 1 启用',
    is_show     int        default 0 not null comment '是否显示导航',
    create_time int                  not null,
    update_time int                  not null
)
    comment '模块';

INSERT INTO think_admin.ta_module (id, name, status, is_show, create_time, update_time) VALUES (1, '插件', 1, 1, 1608794832, 1608794832);
INSERT INTO think_admin.ta_module (id, name, status, is_show, create_time, update_time) VALUES (2, '系统', 1, 1, 1608796328, 1608796328);