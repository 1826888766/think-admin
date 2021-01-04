create table ta_role_menu
(
    id      int auto_increment
        primary key,
    role_id int not null,
    menu_id int not null
)
    comment '角色对应权限';

INSERT INTO think_admin.ta_role_menu (id, role_id, menu_id) VALUES (39, 1, 5);
INSERT INTO think_admin.ta_role_menu (id, role_id, menu_id) VALUES (38, 1, 4);
INSERT INTO think_admin.ta_role_menu (id, role_id, menu_id) VALUES (37, 1, 3);
INSERT INTO think_admin.ta_role_menu (id, role_id, menu_id) VALUES (36, 1, 2);
INSERT INTO think_admin.ta_role_menu (id, role_id, menu_id) VALUES (35, 1, 10);
INSERT INTO think_admin.ta_role_menu (id, role_id, menu_id) VALUES (34, 1, 9);
INSERT INTO think_admin.ta_role_menu (id, role_id, menu_id) VALUES (33, 1, 8);
INSERT INTO think_admin.ta_role_menu (id, role_id, menu_id) VALUES (32, 1, 1);
INSERT INTO think_admin.ta_role_menu (id, role_id, menu_id) VALUES (31, 1, 11);