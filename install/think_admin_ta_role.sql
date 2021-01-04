create table ta_role
(
    id     int auto_increment
        primary key,
    name   varchar(50)          not null comment '角色名称',
    status tinyint(1) default 1 not null
)
    comment '后台管理用户角色';

INSERT INTO think_admin.ta_role (id, name, status) VALUES (1, '超级管理员', 1);
INSERT INTO think_admin.ta_role (id, name, status) VALUES (2, '管理员', 1);
INSERT INTO think_admin.ta_role (id, name, status) VALUES (3, '测试', 1);