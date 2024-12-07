create table highschool_menu(
menu_date date,
menu_name varchar2(50),
menu_order number(1),
select_count number default 0
);


insert into highschool_menu values('20240930', 'Âı½Ò¹ä',1,0);
insert into highschool_menu values('20240930', 'ºÒ°í±â ººÀ½¿ìµ¿',2,0);
insert into highschool_menu values('20240930', 'ÂüÄ¡±èÄ¡Âî°³',3,0);
insert into highschool_menu values('20241002', '¼ø´ë²¢ÀÙººÀ½',0);
insert into highschool_menu values('20241002', '°í±¸¸¶¸ÀÅÁ',0);
insert into highschool_menu values('20241002', '¹èÃß°ÑÀıÀÌ',0);
insert into highschool_menu values('20241002', '»ıÀÏÄÉÀÍ',0);
insert into highschool_menu values('20241007', 'Â÷¼ö¼ö¹ä',0);
insert into  highschool_menu values('20241007','¹ÙÁö¶ô Äá³ª¹°±¹',0);
insert into highschool_menu values('20241007', '»À¾ø´Â ´ß°¥ºñ',0);
insert into highschool_menu values('20241007', '¿ÀÂ¡¾î±èÄ¡Àü',0);
insert into highschool_menu values('20241007', '¹èÃß°ÑÀıÀÌ',0);
insert into highschool_menu values('20241007', '¹è',0);
insert into highschool_menu values('20241008', 'Âı½Ò¹ä',0);
insert into highschool_menu values('20241008', 'ºÎ´ëÂî°³',0);
insert into highschool_menu values('20241008', '°ÇÆÄ·¡ººÀ½',0);
insert into highschool_menu values('20241008', 'Æ÷Å×ÀÌÅä Ä¡Áî ¸íÅÂ±î½º/¼Ò½º',0);
insert into highschool_menu values('20241008', 'ÃÑ°¢±èÄ¡',0);
insert into highschool_menu values('20241008', 'Âûº¸¸®»§',0);

SELECT * FROM HIGHSCHOOL_MENU;

commit;

SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date,
       LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names
FROM highschool_menu
GROUP BY TO_CHAR(menu_date, 'YYYYMMDD')
ORDER BY menu_date;
