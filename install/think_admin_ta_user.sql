create table ta_user
(
    id              int auto_increment
        primary key,
    nickname        varchar(50)  default '' not null comment '昵称',
    username        varchar(50)  default '' not null comment '登录名',
    mobile          varchar(15)  default '' not null comment '手机号',
    password        varchar(255) default '' not null comment '密码',
    create_time     int                     null,
    update_time     int                     null,
    last_login_time int                     null,
    last_login_ip   varchar(100) default '' not null comment '最后登录ip',
    role_id         varchar(255) default '' not null comment '角色id',
    status          tinyint(1)   default 0  not null comment '用户状态'
)
    comment '后台用户表';

INSERT INTO think_admin.ta_user (id, nickname, username, mobile, password, create_time, update_time, last_login_time, last_login_ip, role_id, status) VALUES (1, '超级管理员', 'admin', '18713933800', '', 1609145805, 1609227786, null, '', '1,2,3', 0);