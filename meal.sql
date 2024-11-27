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

insert into highschool_menu values('20240930', '���ҹ�',0);
insert into highschool_menu values('20240930', '�Ұ�� �����쵿',0);
insert into highschool_menu values('20240930', '��ġ��ġ�',0);
insert into highschool_menu values('20241002', '���벢�ٺ���',0);
insert into highschool_menu values('20241002', '��������',0);
insert into highschool_menu values('20241002', '���߰�����',0);
insert into highschool_menu values(11, '20241002', '��������',0);
insert into highschool_menu values(12, '20241007', '��������',0);
insert into  highschool_menu values(13,'20241007','������ �ᳪ����',0);
insert into highschool_menu values(14, '20241007', '������ �߰���',0);
insert into highschool_menu values(15, '20241007', '��¡���ġ��',0);
insert into highschool_menu values(16, '20241007', '���߰�����',0);
insert into highschool_menu values(17, '20241007', '��',0);
insert into highschool_menu values(18, '20241008', '���ҹ�',0);
insert into highschool_menu values(19, '20241008', '�δ��',0);
insert into highschool_menu values(20, '20241008', '���ķ�����',0);
insert into highschool_menu values(21, '20241008', '�������� ġ�� ���±/�ҽ�',0);
insert into highschool_menu values(22, '20241008', '�Ѱ���ġ',0);
insert into highschool_menu values(23, '20241008', '��������',0);

commit;
select * from highschool_menu;
SELECT menu_name FROM highschool_menu WHERE menu_date = '20240930';

SELECT menu_name FROM highschool_menu WHERE menu_date LIKE '202410%';
SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date,
       LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names
FROM highschool_menu-- 2024�� 10�� �����͸� ����
GROUP BY TO_CHAR(menu_date, 'YYYYMMDD')
ORDER BY menu_date;
