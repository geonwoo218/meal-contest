create table highschool_menu(
menu_date date,
menu_name varchar2(50),
select_count number default 0
);

SELECT * FROM HIGHSCHOOL_MENU;
SELECT COUNT(*), MENU_DATE,sum(select_count)/count(*) FROM HIGHSCHOOL_MENU GROUP BY MENU_DATe order by 3 desc,2;
SELECT menu_date, menu_name, select_count FROM highschool_menu ORDER BY select_count DESC,1,2;

SELECT 
    h1.menu_date, 
    h1.menu_name, 
    h1.select_count, 
    COUNT(*) OVER(PARTITION BY h1.menu_date) AS menu_count, 
    AVG(h1.select_count) OVER(PARTITION BY h1.menu_date) AS avg_select_count
FROM 
    highschool_menu h1
ORDER BY 
    avg_select_count DESC, 
    h1.menu_date, 
    h1.menu_name;

insert into highschool_menu values('20240930', 'Âý½Ò¹ä',0);
insert into highschool_menu values('20240930', 'ºÒ°í±â ººÀ½¿ìµ¿',0);
insert into highschool_menu values('20240930', 'ÂüÄ¡±èÄ¡Âî°³',0);
insert into highschool_menu values('20241002', '¼ø´ë²¢ÀÙººÀ½',0);
insert into highschool_menu values('20241002', '°í±¸¸¶¸ÀÅÁ',0);
insert into highschool_menu values('20241002', '¹èÃß°ÑÀýÀÌ',0);
insert into highschool_menu values(11, '20241002', '»ýÀÏÄÉÀÍ',0);
insert into highschool_menu values(12, '20241007', 'Â÷¼ö¼ö¹ä',0);
insert into  highschool_menu values(13,'20241007','¹ÙÁö¶ô Äá³ª¹°±¹',0);
insert into highschool_menu values(14, '20241007', '»À¾ø´Â ´ß°¥ºñ',0);
insert into highschool_menu values(15, '20241007', '¿ÀÂ¡¾î±èÄ¡Àü',0);
insert into highschool_menu values(16, '20241007', '¹èÃß°ÑÀýÀÌ',0);
insert into highschool_menu values(17, '20241007', '¹è',0);
insert into highschool_menu values(18, '20241008', 'Âý½Ò¹ä',0);
insert into highschool_menu values(19, '20241008', 'ºÎ´ëÂî°³',0);
insert into highschool_menu values(20, '20241008', '°ÇÆÄ·¡ººÀ½',0);
insert into highschool_menu values(21, '20241008', 'Æ÷Å×ÀÌÅä Ä¡Áî ¸íÅÂ±î½º/¼Ò½º',0);
insert into highschool_menu values(22, '20241008', 'ÃÑ°¢±èÄ¡',0);
insert into highschool_menu values(23, '20241008', 'Âûº¸¸®»§',0);

commit;
select * from highschool_menu;
SELECT menu_name FROM highschool_menu WHERE menu_date = '20240930';

SELECT menu_name FROM highschool_menu WHERE menu_date LIKE '202410%';
SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date,
       LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names
FROM highschool_menu-- 2024³â 10¿ù µ¥ÀÌÅÍ¸¸ ¼±ÅÃ
GROUP BY TO_CHAR(menu_date, 'YYYYMMDD')
ORDER BY menu_date;
