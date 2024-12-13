create table highschool_menu(
menu_date date,
menu_name varchar2(50),
menu_order number(1),
select_count number default 0
);


SELECT * FROM HIGHSCHOOL_MENU;
=======
-------------------------------
insert into highschool_menu values('20240930', 'Âý½Ò¹ä',0);
insert into highschool_menu values('20240930', 'ºÒ°í±â ººÀ½¿ìµ¿',0);
insert into highschool_menu values('20240930', 'ÂüÄ¡±èÄ¡Âî°³',0);
insert into highschool_menu values('20241002', '¼ø´ë²¢ÀÙººÀ½',0);
insert into highschool_menu values('20241002', '°í±¸¸¶¸ÀÅÁ',0);
insert into highschool_menu values('20241002', '¹èÃß°ÑÀýÀÌ',0);
insert into highschool_menu values('20241002', '»ýÀÏÄÉÀÍ',0);
insert into highschool_menu values('20241007', 'Â÷¼ö¼ö¹ä',0);
insert into  highschool_menu values('20241007','¹ÙÁö¶ô Äá³ª¹°±¹',0);
insert into highschool_menu values('20241007', '»À¾ø´Â ´ß°¥ºñ',0);
insert into highschool_menu values('20241007', '¿ÀÂ¡¾î±èÄ¡Àü',0);
insert into highschool_menu values('20241007', '¹èÃß°ÑÀýÀÌ',0);
insert into highschool_menu values('20241007', '¹è',0);
insert into highschool_menu values('20241008', 'Âý½Ò¹ä',0);
insert into highschool_menu values('20241008', 'ºÎ´ëÂî°³',0);
insert into highschool_menu values('20241008', '°ÇÆÄ·¡ººÀ½',0);
insert into highschool_menu values('20241008', 'Æ÷Å×ÀÌÅä Ä¡Áî ¸íÅÂ±î½º/¼Ò½º',0);
insert into highschool_menu values('20241008', 'ÃÑ°¢±èÄ¡',0);
insert into highschool_menu values('20241008', 'Âûº¸¸®»§',0);

insert into highschool_menu values('20241010', '¿Á¼ö¼ö¹ä',0);
insert into highschool_menu values('20241010', '´ÜÆÏÂð»§',0);
insert into highschool_menu values('20241010', '°Ç»õ¿ì±Ù´ë±¹',0);
insert into highschool_menu values('20241010', '¼øµÎºÎ°è¶õÂò',0);
insert into highschool_menu values('20241010', 'Á¦À°ºÒ°í±â',0);
insert into highschool_menu values('20241010', '¹èÃß±èÄ¡',0);
insert into highschool_menu values('20241011', '¹ä',0);
insert into highschool_menu values('20241011', '½§½§¹ö°Å',0);
insert into highschool_menu values('20241011', 'Å©·çÅë½ºÇÁ',0);
insert into highschool_menu values('20241011', '¹«¸»·©ÀÌ ±èÄ¡',0);
insert into highschool_menu values('20241011', 'Á¶¸®Æþ ¶ó¶¼',0);
insert into highschool_menu values('20241011', '½ºÆ½ ±èÀÚ¹Ý',0);
insert into highschool_menu values('20241014', 'Èæ¹Ì¹ä',0);
insert into highschool_menu values('20241014', 'À°°³Àå',0);
insert into highschool_menu values('20241014', 'Ãë³ª¹°ººÀ½',0);
insert into highschool_menu values('20241014', 'µ·À°±èÄ¡ººÀ½',0);
insert into highschool_menu values('20241014', '¿ÀÂ¡¾î½ÇÃ¤ººÀ½',0);
insert into highschool_menu values('20241014', '²¢ÀÙ±èÄ¡',0);
insert into highschool_menu values('20241015', 'ÇÜ¾ÆÃ¤ººÀ½¹ä',0);
insert into highschool_menu values('20241015', 'À¯ºÎµÈÀå±¹',0);
insert into highschool_menu values('20241015', '¹«ÇÇÅ¬',0);
insert into highschool_menu values('20241015', 'ÆÏ Ç°Àº ´ÜÈ£¹Ú',0);
insert into highschool_menu values('20241015', '·ÑÄ«Ã÷/¼Ò½º',0);
insert into highschool_menu values('20241015', '¹èÃß°ÑÀýÀÌ',0);
insert into highschool_menu values('20241016', 'È¥ÇÕÀâ°î¹ä',0);
insert into highschool_menu values('20241016', 'ÂüÄ¡±èÄ¡Âî°³',0);
insert into highschool_menu values('20241016', 'ÈÆÁ¦Ä¡Å²»ø·¯µå',0);
insert into highschool_menu values('20241016', '¹ö¼¸ÀâÃ¤',0);
insert into highschool_menu values('20241016', 'ÃÑ°¢±èÄ¡',0);
insert into highschool_menu values('20241016', 'À°°³Àå',0);
insert into highschool_menu values('20241016', '²Ü¶±',0);
insert into highschool_menu values('20241017', '°ïµå·¹³ª¹°¹ä/°£Àå¾ç³äÀå',0);
insert into highschool_menu values('20241017', 'ÆØÀÌ¹ö¼¸°è¶õ±¹',0);
insert into highschool_menu values('20241017', 'Ä¡ÆÄÀÌ',0);
insert into highschool_menu values('20241017', '¿­¹«±èÄ¡',0);
insert into highschool_menu values('20241017', '±Ö',0);
--------------------------------------------------------------------
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


>>>>>>> Stashed changes

commit;

SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date,
       LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names
FROM highschool_menu
GROUP BY TO_CHAR(menu_date, 'YYYYMMDD')
ORDER BY menu_date;
