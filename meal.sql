create table highschool_menu(
menu_code number primary key,
menu_date date,
menu_name varchar2(50),
select_count number default 0
);

insert into highschool_menu values(1, '20240930', '찹쌀밥',0);
insert into highschool_menu values(2, '20240930', '불고기 볶음우동',0);
insert into highschool_menu values(3, '20240930', '참치김치찌개',0);
insert into highschool_menu values(4, '20240930', '닭꼬치/웨지감자',0);
insert into highschool_menu values(5, '20240930', '깍두기',0);
insert into highschool_menu values(6, '20241002', '완두콩밥',0);
insert into highschool_menu values(7, '20241002', '들깨미역국',0);
insert into highschool_menu values(8, '20241002', '순대깻잎볶음',0);
insert into highschool_menu values(9, '20241002', '고구마맛탕',0);
insert into highschool_menu values(10, '20241002', '배추겉절이',0);
insert into highschool_menu values(11, '20241002', '생일케익',0);
insert into highschool_menu values(12, '20241007', '차수수밥',0);
insert into  highschool_menu values(13,'20241007','바지락 콩나물국',0);
insert into highschool_menu values(14, '20241007', '뼈없는 닭갈비',0);
insert into highschool_menu values(15, '20241007', '오징어김치전',0);
insert into highschool_menu values(16, '20241007', '배추겉절이',0);
insert into highschool_menu values(17, '20241007', '배',0);
insert into highschool_menu values(18, '20241008', '찹쌀밥',0);
insert into highschool_menu values(19, '20241008', '부대찌개',0);
insert into highschool_menu values(20, '20241008', '건파래볶음',0);
insert into highschool_menu values(21, '20241008', '포테이토 치즈 명태까스/소스',0);
insert into highschool_menu values(22, '20241008', '총각김치',0);
insert into highschool_menu values(23, '20241008', '찰보리빵',0);

commit;

SELECT menu_name FROM highschool_menu WHERE menu_date = '20240930';

SELECT menu_name FROM highschool_menu WHERE menu_date LIKE '202410%';
SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date,
       LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names
FROM highschool_menu
WHERE TO_CHAR(menu_date, 'YYYYMM') = '202410'  -- 2024년 10월 데이터만 선택
GROUP BY TO_CHAR(menu_date, 'YYYYMMDD')
ORDER BY menu_date;