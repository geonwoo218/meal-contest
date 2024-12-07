create table highschool_menu(
menu_date date,
menu_name varchar2(50),
menu_order number(1),
select_count number default 0
);


insert into highschool_menu values('20240930', '���ҹ�',1,0);
insert into highschool_menu values('20240930', '�Ұ�� �����쵿',2,0);
insert into highschool_menu values('20240930', '��ġ��ġ�',3,0);
insert into highschool_menu values('20241002', '���벢�ٺ���',0);
insert into highschool_menu values('20241002', '��������',0);
insert into highschool_menu values('20241002', '���߰�����',0);
insert into highschool_menu values('20241002', '��������',0);
insert into highschool_menu values('20241007', '��������',0);
insert into  highschool_menu values('20241007','������ �ᳪ����',0);
insert into highschool_menu values('20241007', '������ �߰���',0);
insert into highschool_menu values('20241007', '��¡���ġ��',0);
insert into highschool_menu values('20241007', '���߰�����',0);
insert into highschool_menu values('20241007', '��',0);
insert into highschool_menu values('20241008', '���ҹ�',0);
insert into highschool_menu values('20241008', '�δ��',0);
insert into highschool_menu values('20241008', '���ķ�����',0);
insert into highschool_menu values('20241008', '�������� ġ�� ���±/�ҽ�',0);
insert into highschool_menu values('20241008', '�Ѱ���ġ',0);
insert into highschool_menu values('20241008', '��������',0);

SELECT * FROM HIGHSCHOOL_MENU;

commit;

SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date,
       LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names
FROM highschool_menu
GROUP BY TO_CHAR(menu_date, 'YYYYMMDD')
ORDER BY menu_date;
